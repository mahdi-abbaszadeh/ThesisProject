#include "sys/alt_stdio.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include "sys/alt_irq.h"
#include <stdio.h>
#include <stdlib.h>
#include "packet_transaction_util.h"
#define ALMOST_EMPTY 2
#define ALMOST_FULL 11
volatile int input_fifo_wrclk_irq_event;


void proc_3(unsigned char *in_0, unsigned char *out_00, unsigned char *out_01){
	for (int i = 0; i < 24; ++i){
		*(out_00 + i) = *(in_0 + i);
		*(out_01 + i) = !(*(in_0 + i));
	}
}

void proc_4(unsigned char *in_0, unsigned char *out_0){
    for (int i = 0; i < 24; ++i){
        *(out_0 + i) = *(in_0 + i) - 5;
    }
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

int main()
{
  unsigned char send_array[24] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
  unsigned char receive_array[24];

  unsigned char proc_3_in_0[24] = {};
  unsigned char proc_3_out_0[48] = {};

  unsigned char proc_4_in_0[24] = {};
  unsigned char proc_4_out_0[24] = {};

  alt_putstr("Hello from Nios II!\n");

    //initialization of FIFOs
  init_input_fifo_wrclk_control(FIFO_SINK_2_IN_CSR_BASE);
  init_input_fifo_wrclk_control(FIFO_SOURCE_2_IN_CSR_BASE);

  alt_putstr("source status:\n");
  print_status(FIFO_SOURCE_2_IN_CSR_BASE);

  alt_putstr("sink status:\n");
  print_status(FIFO_SINK_2_IN_CSR_BASE);

  alt_putstr("waiting for receiving data:\n");
  receive_poll();

  alt_putstr("read from FIFO:\n");
  receive_packet(receive_array);

  alt_putstr("write to FIFO\n");
  send_packet(0x2,0x3,0x1111,0x2222,0x20,send_array);

  while (1);

  return 0;
}
