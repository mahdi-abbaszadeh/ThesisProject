#include "sys/alt_stdio.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "sys/alt_irq.h"
#include <stdio.h>
#include <stdint.h>
#include "packet_transaction_util.h"

#include <unistd.h>

#define ALMOST_EMPTY 2
#define ALMOST_FULL 11
volatile int input_fifo_wrclk_irq_event;

/* This is only for current node */
// proc 2
P2_INP0_TYPE* proc_2_inp_0;
P2_OUT0_TYPE* proc_2_out_0;

/* This is only for current node */
// pointers to elements for proc 2
void* proc_2_inparg_0[P2_INP0_NUM_OF_TOKEN];
void* proc_2_outarg_0[P2_OUT0_NUM_OF_TOKEN];

/* This is only for current node */
// top level pointers to be passed for proc 2
void** proc_2_inps[P2_NUM_OF_INPS];
void** proc_2_outs[P2_NUM_OF_OUTS];


void proc_2(void ***inpargs, void ***outargs){
	//extracting tokens
	int* num1 = (P2_INP0_TYPE*)inpargs[0][0];
	int* out1 = (P2_OUT0_TYPE*)outargs[0][0];
	*out1 = *num1 + 1;
}

static int init_input_fifo_wrclk_control(alt_u32 control_base_address)
{
  int return_code = ALTERA_AVALON_FIFO_OK;
  return_code = altera_avalon_fifo_init(control_base_address,
                                          0, // Disabled interrupts
                                          ALMOST_EMPTY,
                                          ALMOST_FULL);
  return return_code;
}

void print_status(alt_u32 control_base_address)

{
  printf("--------------------------------------\n");
  printf("LEVEL = %u\n", altera_avalon_fifo_read_level(control_base_address) );
  printf("STATUS = %u\n", altera_avalon_fifo_read_status(control_base_address,
    ALTERA_AVALON_FIFO_STATUS_ALL) );
  printf("EVENT = %u\n", altera_avalon_fifo_read_event(control_base_address,
    ALTERA_AVALON_FIFO_EVENT_ALL) );
  printf("IENABLE = %u\n", altera_avalon_fifo_read_ienable(control_base_address,
    ALTERA_AVALON_FIFO_IENABLE_ALL) );
  printf("ALMOSTEMPTY = %u\n",
    altera_avalon_fifo_read_almostempty(control_base_address) );
  printf("ALMOSTFULL = %u\n\n",
    altera_avalon_fifo_read_almostfull(control_base_address));
}

/* This is only for current node */
void read_buff(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){
	if(proc_num == 2){
		if(input_num == 0){
			uint8_t tmp[edge->size_of_token_type];
			for(int i =0; i < edge->num_of_inp_token; ++i){
				ring_buffer_dequeue_arr(edge->buffer,tmp,edge->size_of_token_type);
				ring_buffer_pop_arr(edge->buffer,(24 - edge->size_of_token_type));
				proc_2_inp_0[i] = ( (P2_INP0_TYPE*)tmp )[0];
			}
		}
	}
}

void read_data(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){

	while(ring_buffer_num_items((edge->buffer)) < (edge->num_of_inp_token * 24)){
		if(receive_poll())
			receive_packet();
	}
	read_buff(edge, proc_num, input_num);
}

void serializing_send(struct Edge *edge, unsigned char *array){
	unsigned char send_array[24];

	for(int i = 0; i < edge->size_of_token_type; ++i){
		send_array[i] = array[i];
	}

	if(edge->external == 1){
		send_packet(edge->node_src, edge->node_dest, edge->proc_src, edge->proc_dest, 32, send_array);
	}
	else{
		ring_buffer_queue_arr(edge->buffer,send_array,24);
	}
}

/* This is only for current node */
void send_data(struct Edge *edge, alt_u16 proc_num, uint8_t output_num){

	if(proc_num == 2){
		if(output_num == 0){
			for(int i =0; i < edge->num_of_out_token; ++i){
				serializing_send(edge, ((unsigned char*)proc_2_outarg_0[i]));
			}
		}
	}
}

void proc_args_init(){
	// space allocation for input and output for proc 2
	proc_2_inp_0 = (P2_INP0_TYPE*)malloc(P2_INP0_NUM_OF_TOKEN*sizeof(P2_INP0_TYPE));
	proc_2_out_0 = (P2_OUT0_TYPE*)malloc(P2_OUT0_NUM_OF_TOKEN*sizeof(P2_OUT0_TYPE));

	// pointers to elements for proc 2
    proc_2_inparg_0[0] = &proc_2_inp_0[0];
    proc_2_outarg_0[0] = &proc_2_out_0[0];

    // top level pointers to be passed for proc 2
    proc_2_inps[0] = proc_2_inparg_0;
    proc_2_outs[0] = proc_2_outarg_0;
}

void cleanUp(){
	// clean up proc 2
	free(proc_2_inp_0);
	free(proc_2_out_0);
}

void start_FIFO(){
	//alt_putstr("Hello from Nios II!\n");

	//initialization of FIFOs
	init_input_fifo_wrclk_control(FIFO_SINK_1_IN_CSR_BASE);
	init_input_fifo_wrclk_control(FIFO_SOURCE_1_IN_CSR_BASE);

	//alt_putstr("source status:\n");
	//print_status(FIFO_SOURCE_1_IN_CSR_BASE);

	//alt_putstr("sink status:\n");
	//print_status(FIFO_SINK_1_IN_CSR_BASE);
}

/* This is only for current node */
int main()
{
	start_FIFO();
	proc_args_init();
	init_structures();


	for(int k = 0; k < 5; ++k){
		//alt_putstr("NODE 1 ---------------------------------------------------------\n");
	  for(int i = 0; i <P2_NUM_OF_INPS; ++i){
		  struct Edge *edge = get_edge(2,i,0/*it means input edges*/);
		  //printf("k = %d\t before read data from processor 2\n",k);
		  read_data(edge,2/*which process*/, i/*which input*/);
		  //printf("k = %d\t after read data from processor 2\n",k);
	  }

	  proc_2(proc_2_inps, proc_2_outs);

	  for(int i = 0; i <P2_NUM_OF_OUTS; ++i){
		  struct Edge *edge = get_edge(2,i,1/*it means output edges*/);
		  send_data(edge,2/*which process*/, i/*which output*/);
	  }
	}
	cleanUp();

	while (1);

	return 0;
}