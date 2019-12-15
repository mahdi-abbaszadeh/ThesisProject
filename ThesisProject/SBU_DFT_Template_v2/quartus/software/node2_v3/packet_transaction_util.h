#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include <stdlib.h>
#include <stdbool.h>
#include "ringbuffer_util.h"

#define FIFO_SINK_CSR		FIFO_SINK_2_IN_CSR_BASE
#define FIFO_SOURCE_CSR		FIFO_SOURCE_2_IN_CSR_BASE
#define FIFO_SINK_BASE		FIFO_SINK_2_OUT_BASE
#define FIFO_SOURCE_BASE	FIFO_SOURCE_2_IN_BASE
#define FIFO_STATUS			ALTERA_AVALON_FIFO_STATUS_ALL

/* This is only for current node */
//proc 4
#define P4_INP0_NUM_OF_TOKEN 1
#define P4_OUT0_NUM_OF_TOKEN 1
#define P4_OUT1_NUM_OF_TOKEN 1
#define P4_INP0_TYPE int
#define P4_OUT0_TYPE int
#define P4_OUT1_TYPE int
#define P4_NUM_OF_INPS 1
#define P4_NUM_OF_OUTS 2

/* This is only for current node */
//proc 5
#define P5_INP0_NUM_OF_TOKEN 1
#define P5_OUT0_NUM_OF_TOKEN 1
#define P5_INP0_TYPE int
#define P5_OUT0_TYPE int
#define P5_NUM_OF_INPS 1
#define P5_NUM_OF_OUTS 1



#define BUFFER_SIZE 50

/* This is only for current node */
/******************** BUFFER *********************/
//input buffer for process3 from process4
ring_buffer_t buff_p3_p4;

//input buffer for process4 from process5
ring_buffer_t buff_p4_p5;
/******************** BUFFER *********************/


/******************* Structure *******************/
struct Edge{
	uint8_t node_src;
	uint8_t node_dest;
	alt_u16 proc_src;
	alt_u16 proc_dest;
	uint8_t num_of_inp_token;
	uint8_t num_of_out_token;
	uint8_t size_of_token_type;
	ring_buffer_t *buffer;
	bool external;
};
/******************* Structure *******************/

struct Edge* get_edge(uint8_t proc_num, uint8_t port_num, uint8_t inout);

ring_buffer_t* get_buffer(alt_u16 proc_src, alt_u16 proc_dest);

void init_buffer();

void init_structures();

void send_packet(unsigned char node_src, unsigned char node_dest,
alt_u16 proc_src, alt_u16 proc_dest, unsigned char packsize, unsigned char *payload);

void receive_packet();

void receive_poll();
