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

// proc 0
P0_INP0_TYPE* proc_0_inp_0;
P0_OUT0_TYPE* proc_0_out_0;

// proc 1
P1_INP0_TYPE* proc_1_inp_0;
P1_INP1_TYPE* proc_1_inp_1;
P1_OUT0_TYPE* proc_1_out_0;
P1_OUT1_TYPE* proc_1_out_1;


// pointers to elements for proc 0
void* proc_0_inparg_0[P0_INP0_NUM_OF_TOKEN];
void* proc_0_outarg_0[P0_OUT0_NUM_OF_TOKEN];

// pointers to elements for proc 1
void* proc_1_inparg_0[P1_INP0_NUM_OF_TOKEN];
void* proc_1_inparg_1[P1_INP1_NUM_OF_TOKEN];
void* proc_1_outarg_0[P1_OUT0_NUM_OF_TOKEN];
void* proc_1_outarg_1[P1_OUT1_NUM_OF_TOKEN];

// top level pointers to be passed for proc 0
void** proc_0_inps[P0_NUM_OF_INPS];
void** proc_0_outs[P0_NUM_OF_OUTS];

// top level pointers to be passed for proc 1
void** proc_1_inps[P1_NUM_OF_INPS];
void** proc_1_outs[P1_NUM_OF_OUTS];


void proc_0(void ***inpargs, void ***outargs){
	//extracting tokens
	int* num1 = (P0_INP0_TYPE*)inpargs[0][0];
	int* out1 = (P0_OUT0_TYPE*)outargs[0][0];

	//printf("proc_0 -- num1: %x\n",*num1);

	*out1 = *num1 + 1;

	//printf("proc_0 -- out1: %x\n",*out1);
}

void proc_1(void ***inpargs, void ***outargs){
	//extracting tokens
	int* num1 = (P1_INP0_TYPE*)inpargs[0][0];
	int* num2 = (P1_INP1_TYPE*)inpargs[1][0];
	int* out1 = (P1_OUT0_TYPE*)outargs[0][0];
	int* out2 = (P1_OUT1_TYPE*)outargs[1][0];

	//printf("proc_1 -- num1: %x\n",*num1);
	//printf("proc_1 -- num2: %x\n",*num2);

	*out1 = *num1 + *num2;
	*out2 = *num2 - *num1;

	//printf("proc_1 -- out1: %x\n",*out1);
	//printf("proc_1 -- out2: %x\n",*out2);
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


void read_buff(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){

	//printf("read buffer - size of token type: %d\n",edge->size_of_token_type);
	//printf("read buffer - number of input token: %d\n",edge->num_of_inp_token);


	if(proc_num == 0){
		if(input_num == 0){
			uint8_t tmp[edge->size_of_token_type];

			for(int i =0; i < edge->num_of_inp_token; ++i){
				ring_buffer_dequeue_arr(edge->buffer,tmp,edge->size_of_token_type);
				//printf("circular buffer size(after dequeue): %d\n",ring_buffer_num_items((edge->buffer)));
				ring_buffer_pop_arr(edge->buffer,(24 - edge->size_of_token_type));
				//printf("circular buffer size(after pop): %d\n",ring_buffer_num_items((edge->buffer)));
				/*for(int i =0; i< sizeof(tmp); i++){
					printf("tmp[i]: %d\n",tmp[i]);
				}*/
				proc_0_inp_0[i] = ( (P0_INP0_TYPE*)tmp )[0];
			}
			/*for(int i =0; i< sizeof(proc_0_inp_0); i++){
				printf("proc_0_inp_0[i]: %d\n",proc_0_inp_0[i]);
			}*/
			printf("processor number %d reads data from %d ,which is %x\n",edge->proc_dest,edge->proc_src,( (P0_INP0_TYPE*)tmp )[0]);
		}
	}

	if(proc_num == 1){
		if(input_num == 0){
			uint8_t tmp[edge->size_of_token_type];

			for(int i =0; i < edge->num_of_inp_token; ++i){
				ring_buffer_dequeue_arr(edge->buffer,tmp,edge->size_of_token_type);
				//printf("circular buffer size(after dequeue): %d\n",ring_buffer_num_items((edge->buffer)));
				ring_buffer_pop_arr(edge->buffer,(24 - edge->size_of_token_type));
				//printf("circular buffer size(after pop): %d\n",ring_buffer_num_items((edge->buffer)));
				/*for(int i =0; i< sizeof(tmp); i++){
					printf("tmp[i]: %d\n",tmp[i]);
				}*/
				proc_1_inp_0[i] = ( (P1_INP0_TYPE*)tmp )[0];
			}
			/*for(int i =0; i< sizeof(proc_1_inp_0); i++){
				printf("proc_1_inp_0[i]: %d\n",proc_1_inp_0[i]);
			}*/
			printf("processor number %d reads data from %d ,which is %x\n",edge->proc_dest,edge->proc_src,( (P1_INP0_TYPE*)tmp )[0]);
		}
		if(input_num == 1){
			uint8_t tmp[edge->size_of_token_type];

			for(int i =0; i < edge->num_of_inp_token; ++i){
				ring_buffer_dequeue_arr(edge->buffer,tmp,edge->size_of_token_type);
				//printf("circular buffer size(after dequeue): %d\n",ring_buffer_num_items((edge->buffer)));
				ring_buffer_pop_arr(edge->buffer,(24 - edge->size_of_token_type));
				//printf("circular buffer size(after pop): %d\n",ring_buffer_num_items((edge->buffer)));
				/*for(int i =0; i< sizeof(tmp); i++){
					printf("tmp[i]: %d\n",tmp[i]);
				}*/
				proc_1_inp_1[i] = ( (P1_INP1_TYPE*)tmp )[0];
			}
			/*for(int i =0; i< sizeof(proc_1_inp_1); i++){
				printf("proc_1_inp_1[i]: %d\n",proc_1_inp_1[i]);
			}*/
			printf("processor number %d reads data from %d ,which is %x\n",edge->proc_dest,edge->proc_src,( (P1_INP1_TYPE*)tmp )[0]);
		}
	}
}

void read_data(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){

	//printf("circular buffer size: %d\n",ring_buffer_num_items((edge->buffer)));
	while(ring_buffer_num_items((edge->buffer)) < (edge->num_of_inp_token * 24)){
		//alt_putstr("waiting for receiving data:\n");
		receive_poll();

		//alt_putstr("read from FIFO:\n");
		receive_packet();
	}
	//printf("circular buffer size(after read data): %d\n",ring_buffer_num_items((edge->buffer)));
	read_buff(edge, proc_num, input_num);
}

void serializing_send(struct Edge *edge, unsigned char *array){
	unsigned char send_array[24];

	for(int i = 0; i < edge->size_of_token_type; ++i){
		send_array[i] = array[i];
		//printf("in serialized data function: array[i]: %d\n",array[i]);
	}

	if(edge->external == 1){
		//printf("external\n");
		//alt_putstr("write to FIFO\n");
		/*for(int i = 0; i < 24; ++i)
			printf("send_array: %d\t",send_array[i]);*/
		send_packet(edge->node_src, edge->node_dest, edge->proc_src, edge->proc_dest, 32, send_array);
	}
	else{
		ring_buffer_queue_arr(edge->buffer,send_array,24);
	}
	printf("processor number %d sends data to %d ,which is %x\n",edge->proc_src,edge->proc_dest,( (int*)send_array )[0]);

}

void send_data(struct Edge *edge, alt_u16 proc_num, uint8_t output_num){

	if(proc_num == 0){
		if(output_num == 0){
			for(int i =0; i < edge->num_of_out_token; ++i){
				serializing_send(edge, ((unsigned char*)proc_0_outarg_0[i]));
			}
		}
	}

	if(proc_num == 1){
		if(output_num == 0){
			for(int i =0; i < edge->num_of_out_token; ++i){
				serializing_send(edge, ((unsigned char*)proc_1_outarg_0[i]));
			}
		}
		if(output_num == 1){
			for(int i =0; i < edge->num_of_out_token; ++i){
				serializing_send(edge, ((unsigned char*)proc_1_outarg_1[i]));
			}
		}
	}
}

void proc_args_init(){
	// space allocation for input and output for proc 0
	proc_0_inp_0 = (P0_INP0_TYPE*)malloc(P0_INP0_NUM_OF_TOKEN*sizeof(P0_INP0_TYPE));
	proc_0_out_0 = (P0_OUT0_TYPE*)malloc(P0_OUT0_NUM_OF_TOKEN*sizeof(P0_OUT0_TYPE));

	// pointers to elements for proc 0
    proc_0_inparg_0[0] = &proc_0_inp_0[0];
    proc_0_outarg_0[0] = &proc_0_out_0[0];

    // top level pointers to be passed for proc 0
    proc_0_inps[0] = proc_0_inparg_0;
    proc_0_outs[0] = proc_0_outarg_0;


	// space allocation for input and output for proc 1
	proc_1_inp_0 = (P1_INP0_TYPE*)malloc(P1_INP0_NUM_OF_TOKEN*sizeof(P1_INP0_TYPE));
	proc_1_inp_1 = (P1_INP1_TYPE*)malloc(P1_INP1_NUM_OF_TOKEN*sizeof(P1_INP1_TYPE));
	proc_1_out_0 = (P1_OUT0_TYPE*)malloc(P1_OUT0_NUM_OF_TOKEN*sizeof(P1_OUT0_TYPE));
	proc_1_out_1 = (P1_OUT1_TYPE*)malloc(P1_OUT1_NUM_OF_TOKEN*sizeof(P1_OUT1_TYPE));

	// pointers to elements for proc 1
    proc_1_inparg_0[0] = &proc_1_inp_0[0];
    proc_1_inparg_1[0] = &proc_1_inp_1[0];
    proc_1_outarg_0[0] = &proc_1_out_0[0];
    proc_1_outarg_1[0] = &proc_1_out_1[0];

    // top level pointers to be passed for proc 1
    proc_1_inps[0] = proc_1_inparg_0;
    proc_1_inps[1] = proc_1_inparg_1;
    proc_1_outs[0] = proc_1_outarg_0;
    proc_1_outs[1] = proc_1_outarg_1;


}

void cleanUp(){
	// clean up proc 0
	free(proc_0_inp_0);
	free(proc_0_out_0);

	// clean up proc 1
	free(proc_1_inp_0);
	free(proc_1_inp_1);
	free(proc_1_out_0);
	free(proc_1_out_1);
}

void start_FIFO(){
	//alt_putstr("Hello from Nios II!\n");

	//initialization of FIFOs
	init_input_fifo_wrclk_control(FIFO_SINK_0_IN_CSR_BASE);
	init_input_fifo_wrclk_control(FIFO_SOURCE_0_IN_CSR_BASE);

	//alt_putstr("source status:\n");
	//print_status(FIFO_SOURCE_0_IN_CSR_BASE);

	//alt_putstr("sink status:\n");
	//print_status(FIFO_SINK_0_IN_CSR_BASE);
}

int main()
{
	char p0_initial_token[24] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
	char p1_initial_token[24] = {24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1};

	start_FIFO();
	proc_args_init();
	init_structures();

	ring_buffer_queue_arr(&buff_p5_p0,p0_initial_token,24);
	ring_buffer_queue_arr(&buff_p4_p1,p1_initial_token,24);


	for(int k = 0; k < 5; k++){

	  for(int i = 0; i < P0_NUM_OF_INPS; ++i){
		  //alt_putstr("before get edge(for receive)\n");
		  struct Edge *edge = get_edge(0,i,0/*it means input edges*/);

		  /*printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);*/

		  //alt_putstr("before read_data\n");
		  read_data(edge,0/*which process*/, i/*which input*/);
		  //alt_putstr("after read_data\n");
	  }

	  //alt_putstr("before call proc_0\n");
	  proc_0(proc_0_inps, proc_0_outs);
	  //alt_putstr("after call proc_0\n");


	  for(int i = 0; i <P0_NUM_OF_OUTS; ++i){

		  //alt_putstr("before get edge(for send)\n");
		  struct Edge *edge = get_edge(0,i,1/*it means output edges*/);

		  /*printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",  edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);*/

		  //alt_putstr("before send_data\n");
		  send_data(edge,0/*which process*/, i/*which output*/);
		  //alt_putstr("after send_data\n");
	  }


	  for(int i = 0; i <P1_NUM_OF_INPS; ++i){
		  /* This is only for current node */
		  //alt_putstr("before get edge(for receive)\n");
		  struct Edge *edge = get_edge(1,i,0/*it means input edges*/);

		  /*printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);*/

		  /* This is only for current node */
		  //alt_putstr("before read_data\n");
		  read_data(edge,1/*which process*/, i/*which input*/);
		  //alt_putstr("after read_data\n");
	  }

	  //alt_putstr("before call proc_1\n");
	  proc_1(proc_1_inps, proc_1_outs);
	  //alt_putstr("after call proc_1\n");


	  for(int i = 0; i <P1_NUM_OF_OUTS; ++i){

		  //alt_putstr("before get edge(for send)\n");
		  /* This is only for current node */
		  struct Edge *edge = get_edge(1,i,1/*it means output edges*/);

		  /*printf("edge node source: %d\n",edge->node_src);
		  printf("edge node dest: %d\n",  edge->node_dest);
		  printf("edge proc source: %d\n",edge->proc_src);
		  printf("edge proc source: %d\n",edge->proc_dest);*/

		  /* This is only for current node */
		  //alt_putstr("before send_data\n");
		  send_data(edge,1/*which process*/, i/*which output*/);
		  //alt_putstr("after send_data\n");
	  }
	  usleep(4000000000);
	}
	  cleanUp();

	  while (1);

	  return 0;
}
