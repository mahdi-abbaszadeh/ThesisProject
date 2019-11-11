#include "sys/alt_stdio.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include "sys/alt_irq.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "packet_transaction_util.h"
#define ALMOST_EMPTY 2
#define ALMOST_FULL 11
volatile int input_fifo_wrclk_irq_event;


struct Proc_0_arg{

	//inputs
	double input_0[1];

	//outputs
	double output_0[1];
}p_0_arg;

struct Proc_1_arg{

	//inputs
	double input_0[1];
	double input_1[1];

	//outputs
	double output_0[1];
	double output_1[1];
}p_1_arg;



void proc_0(struct Proc_0_arg *args){
	double i1 = args->input_0[0];

	i1 += 10;

	args->output_0[0] = i1;
}

/*void proc_1(struct Proc_1_arg *args){
    for (int i = 0; i < 24; ++i){
        *(out_0 + i) = *(in_00 + i) + *(in_00 + i) + *(in_1 + i);
    }
}*/

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

void read_buff(cbuf_handle_t *cbuf, uint8_t num_of_token, alt_u16 proc_num, uint8_t input_num){

	if(proc_num == 0){
		if(input_num == 0){
			char tmp[sizeof(double)];

			for(int i =0; i < num_of_token; ++i){
				for(int j = 0; j < sizeof(double); ++j){
					circular_buf_get(cbuf,tmp[j]);
				}
				p_0_arg.input_0[i] = ( (double *)tmp )[0];
			}
		}
	}

	if(proc_num == 1){
		if(input_num == 0){
			char tmp[sizeof(double)];

			for(int i =0; i < num_of_token; ++i){
				for(int j = 0; j < sizeof(double); ++j){
					circular_buf_get(cbuf,tmp[j]);
				}
				p_1_arg.input_0[i] = ( (double *)tmp )[0];
			}
		}
		if(input_num == 0){
			char tmp[sizeof(double)];

			for(int i =0; i < num_of_token; ++i){
				for(int j = 0; j < sizeof(double); ++j){
					circular_buf_get(cbuf,tmp[j]);
				}
				p_1_arg.input_1[i] = ( (double *)tmp )[0];
			}
		}
	}
}

void read_data(struct Edge *edge, alt_u16 proc_num, uint8_t input_num){

	while(circular_buf_size(edge->buffer) < edge->num_of_token){
		alt_putstr("waiting for receiving data:\n");
		receive_poll();

		alt_putstr("read from FIFO:\n");
		receive_packet();
	}
	read_buff(edge->buffer, edge->num_of_token, proc_num, input_num);
}

void serializing_send(struct Edge *edge, unsigned char *array){
	unsigned char send_array[24];
	uint8_t size = 0;
	uint8_t count = 0;
	size = sizeof(array)/24;

	if(edge->external == 1){
		do{
			for(int i = 0; i < 24; ++i){
				send_array[i] = array[i + (count * 24)];
			}
			count++;

			alt_putstr("write to FIFO\n");
			send_packet(edge->node_src, edge->node_dest, edge->proc_src, edge->proc_dest, 24, send_array);
		}while(count < size);
	}

	else{
		for(int i= 0; i < sizeof(array); ++i){
			edge->buffer[i] = array[i];
		}
	}

}

void send_data(struct Edge *edge, alt_u16 proc_num, uint8_t output_num){

	if(proc_num == 0){
		if(output_num == 0)
			serializing_send(edge, ((unsigned char*)p_0_arg.output_0) );
	}

	if(proc_num == 1){
		if(output_num == 0)
			serializing_send(edge, ((unsigned char*)p_1_arg.output_0) );
		if(output_num == 1)
			serializing_send(edge, ((unsigned char*)p_1_arg.output_1) );
	}
}

int main()
{
  alt_putstr("Hello from Nios II!\n");

  //initialization of FIFOs
  init_input_fifo_wrclk_control(FIFO_SINK_0_IN_CSR_BASE);
  init_input_fifo_wrclk_control(FIFO_SOURCE_0_IN_CSR_BASE);

  alt_putstr("source status:\n");
  print_status(FIFO_SOURCE_0_IN_CSR_BASE);

  alt_putstr("sink status:\n");
  print_status(FIFO_SINK_0_IN_CSR_BASE);

  init_buffer();
  init_structures();

  while(1){

	  for(int i = 0; i < 1 /*number of process_0's input(0) ports*/; ++i){

		  struct Edge *edge = get_edge(0,i,0/*it means input edges*/);

		  read_data(edge,0/*which process*/, i/*which input*/);
	  }

	  proc_0(&p_0_arg);

	  for(int i = 0; i < 1/*number of process_0's output(1) ports*/; ++i){

		  struct Edge *edge = get_edge(0,i,1/*it means output edges*/);

		  send_data(edge,0/*which process*/, i/*which output*/);
	  }
  }

/*  alt_putstr("read from FIFO:\n");
  receive_packet(receive_array);

  alt_putstr("write to FIFO\n");
  send_packet(0x0,0x1,0x1111,0x2222,0x20,send_array);


  alt_putstr("waiting for receiving data:\n");
  receive_poll();

  alt_putstr("read from FIFO:\n");
  receive_packet(receive_array);*/

  while (1);

  return 0;
}
