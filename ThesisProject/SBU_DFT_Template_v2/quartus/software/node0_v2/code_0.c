#include "sys/alt_stdio.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "sys/alt_irq.h"
#include <stdio.h>
#include <stdint.h>
#include "packet_transaction_util.h"
#define ALMOST_EMPTY 2
#define ALMOST_FULL 11
volatile int input_fifo_wrclk_irq_event;

// proc 0
int* proc_0_inp_0;
int* proc_0_out_0;

// proc 1
int* proc_1_inp_0;
int* proc_1_inp_1;
int* proc_1_out_0;
int* proc_1_out_1;

/*void proc_0(struct Proc_0_arg *args){
	int i1;
	i1 = args->input_0[0];
	printf("i1: %x\n",i1);

	i1 = i1 + 2.0;

	printf("i1: %x\n",i1);

	args->output_0[0] = i1;

	printf("args->output_0[0]: %d\n",args->output_0[0]);

	return;
}*/

void proc_0(void ***inpargs, void ***outargs){
	//extracting tokens
	int* num1 = (P0_INP0_TYPE*)inpargs[0][0];
	int* out1 = (P0_OUT0_TYPE*)outargs[0][0];

	printf("proc_0 -- num1: %x\n",*num1);

	*out1 = *num1 + 1;

	printf("proc_0 -- out1: %x\n",*out1);
}

void proc_1(void ***inpargs, void ***outargs){
	//extracting tokens
	int* num1 = (P1_INP0_TYPE*)inpargs[0][0];
	int* num2 = (P1_INP1_TYPE*)inpargs[1][0];
	int* out1 = (P1_OUT0_TYPE*)outargs[0][0];
	int* out2 = (P1_OUT1_TYPE*)outargs[1][0];

	*out1 = *num1 + *num2;
	*out2 = *num1 - *num2;
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


void read_buff(ring_buffer_t *cbuf, uint8_t num_of_token, alt_u16 proc_num, uint8_t input_num){

	if(proc_num == 0){
		if(input_num == 0){
			uint8_t tmp[P0_INP0_TYPE_SIZE];

			for(int i =0; i < num_of_token; ++i){
				ring_buffer_dequeue_arr(cbuf,tmp,P0_INP0_TYPE_SIZE);
				proc_0_inp_0[i] = ( (P0_INP0_TYPE*)tmp )[0];
			}
		}
	}

	if(proc_num == 1){
		if(input_num == 0){
			uint8_t tmp[P1_INP0_TYPE_SIZE];

			for(int i =0; i < num_of_token; ++i){
				ring_buffer_dequeue_arr(cbuf,tmp,P1_INP0_TYPE_SIZE);
				proc_1_inp_0[i] = ( (P1_INP0_TYPE*)tmp )[0];
			}
		}
		if(input_num == 1){
			uint8_t tmp[P1_INP1_TYPE_SIZE];

			for(int i =0; i < num_of_token; ++i){
				ring_buffer_dequeue_arr(cbuf,tmp,P1_INP1_TYPE_SIZE);
				proc_1_inp_1[i] = ( (P1_INP1_TYPE*)tmp )[0];
			}
		}
	}
}

void read_data(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){

	printf("circular buffer size: %d\n",ring_buffer_num_items((edge->buffer)));
	while(ring_buffer_num_items((edge->buffer)) < edge->num_of_token){
		alt_putstr("waiting for receiving data:\n");
		receive_poll();

		alt_putstr("read from FIFO:\n");
		receive_packet();
	}
	printf("circular buffer size(after read data): %d\n",ring_buffer_num_items((edge->buffer)));
	read_buff(edge->buffer, edge->num_of_token, proc_num, input_num);
}

void serializing_send(struct Edge *edge, unsigned char *array, unsigned char out_type_size){
	unsigned char send_array[24] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
	uint8_t num_of_packet_size = 0;
	uint8_t count = 0;
	num_of_packet_size = sizeof(array)/24;

	if(edge->external == 1){
		printf("external\n");
		do{
			for(int i = 0; i < out_type_size; ++i){
				send_array[i] = array[i + (count * 24)];
				printf("in seriliazed data function: array[i]: %d\n",array[i + (count * 24)]);

			}
			count++;

			alt_putstr("write to FIFO\n");
			for(int i = 0; i < 24; ++i)
				printf("send_array: %d\n",send_array[i]);
			send_packet(edge->node_src, edge->node_dest, edge->proc_src, edge->proc_dest, 32, send_array);
		}while(count < num_of_packet_size);
	}

	else{
		ring_buffer_queue_arr(edge->buffer,array,sizeof(array));
	}

}

void send_data(struct Edge *edge, alt_u16 proc_num, uint8_t output_num){

	if(proc_num == 0){
		if(output_num == 0)
			serializing_send(edge, ((unsigned char*)proc_0_out_0), P0_OUT0_TYPE_SIZE );
	}

	if(proc_num == 1){
		if(output_num == 0)
			serializing_send(edge, ((unsigned char*)proc_1_out_0), P0_OUT0_TYPE_SIZE );
		if(output_num == 1)
			serializing_send(edge, ((unsigned char*)proc_1_out_1), P1_OUT1_TYPE_SIZE );
	}
}


int main()
{
	// space allocation for input and output for proc 0
	proc_0_inp_0 = (int*)malloc(P0_INP0_TOKENT_SIZE*sizeof(int));
	proc_0_out_0 = (int*)malloc(P0_OUT0_TOKENT_SIZE*sizeof(int));

	// space allocation for input and output for proc 1
	proc_1_inp_0 = (int*)malloc(P1_INP0_TOKENT_SIZE*sizeof(int));
	proc_1_inp_1 = (int*)malloc(P1_INP1_TOKENT_SIZE*sizeof(int));
	proc_1_out_0 = (int*)malloc(P1_OUT0_TOKENT_SIZE*sizeof(int));
	proc_1_out_1 = (int*)malloc(P1_OUT1_TOKENT_SIZE*sizeof(int));

	// pointers to elements for proc 1
    void* proc_0_inparg_0[1];
    void* proc_0_outarg_0[1];
    proc_0_inparg_0[0] = &proc_0_inp_0[0];
    proc_0_outarg_0[0] = &proc_0_out_0[0];

    // pointers to elements for proc 1
    void* proc_1_inparg_0[1];
    void* proc_1_inparg_1[1];
    void* proc_1_outarg_0[1];
    void* proc_1_outarg_1[1];
    proc_1_inparg_0[0] = &proc_1_inp_0[0];
    proc_1_inparg_1[0] = &proc_1_inp_1[0];
    proc_1_outarg_0[0] = &proc_1_out_0[0];
    proc_1_outarg_1[0] = &proc_1_out_1[0];

    // top level pointers to be passed for proc 0
    void** proc_0_inps[1] = {proc_0_inparg_0};
    void** proc_0_outs[1] = {proc_0_outarg_0};

    // top level pointers to be passed for proc 1
    void** proc_1_inps[2] = {proc_1_inparg_0,proc_1_inparg_1};
    void** proc_1_outs[2] = {proc_1_outarg_0,proc_1_outarg_1};


	alt_putstr("Hello from Nios II!\n");

	//initialization of FIFOs
	init_input_fifo_wrclk_control(FIFO_SINK_0_IN_CSR_BASE);
	init_input_fifo_wrclk_control(FIFO_SOURCE_0_IN_CSR_BASE);

	alt_putstr("source status:\n");
	print_status(FIFO_SOURCE_0_IN_CSR_BASE);

	alt_putstr("sink status:\n");
	print_status(FIFO_SINK_0_IN_CSR_BASE);

	//init_buffer();
	alt_putstr("before init_structures\n");
	init_structures();
	alt_putstr("after init_structures\n");

	//while(1){

	  for(int i = 0; i < 1 /*number of process_0's input(0) ports*/; ++i){
		  alt_putstr("before get edge(for receive)\n");
		  struct Edge *edge = get_edge(0,i,0/*it means input edges*/);

		  printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);

		  alt_putstr("before read_data\n");
		  read_data(edge,0/*which process*/, i/*which input*/);
		  alt_putstr("after read_data\n");
	  }

	  alt_putstr("before call proc_0\n");
	  proc_0(proc_0_inps, proc_0_outs);
	  alt_putstr("after call proc_0\n");


	  for(int i = 0; i < 1 /*number of process_0's output(1) ports*/ ; ++i){

		  alt_putstr("before get edge(for send)\n");
		  struct Edge *edge = get_edge(0,i,1/*it means output edges*/);

		  printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",  edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);

		  alt_putstr("before send_data\n");
		  send_data(edge,0/*which process*/, i/*which output*/);
		  alt_putstr("after send_data\n");
	  }
	//}

	/*alt_putstr("read from FIFO:\n");
	receive_packet(receive_array);

	alt_putstr("write to FIFO\n");
	send_packet(0x0,0x1,0x1111,0x2222,0x20,send_array);


	alt_putstr("waiting for receiving data:\n");
	receive_poll();

	alt_putstr("read from FIFO:\n");
	receive_packet(receive_array);*/

	// clean up proc 0
	free(proc_0_inp_0);
	free(proc_0_out_0);

	// clean up proc 1
	free(proc_1_inp_0);
	free(proc_1_inp_1);
	free(proc_1_out_0);
	free(proc_1_out_1);

	while (1);

	return 0;
}
