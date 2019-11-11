#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include <stdlib.h>
#include "circular_buffer.h"

#define FIFO_SINK_CSR	FIFO_SINK_0_IN_CSR_BASE
#define FIFO_SOURCE_CSR	FIFO_SOURCE_0_IN_CSR_BASE
#define FIFO_SINK_BASE	FIFO_SINK_0_OUT_BASE
#define FIFO_SOURCE_BASE	FIFO_SOURCE_0_IN_BASE
#define FIFO_STATUS	ALTERA_AVALON_FIFO_STATUS_ALL

#define BUFFER_SIZE 50

/******************** BUFFER *********************/
//input buffer for process0 from process5
cbuf_handle_t buff_p5_p0;
//input buffer for process1 from process0
cbuf_handle_t buff_p0_p1;
//input buffer for process1 from process4
cbuf_handle_t buff_p4_p1;
/******************** BUFFER *********************/

/******************* Structure *******************/
struct Edge{
	uint8_t node_src;
	uint8_t node_dest;
	alt_u16 proc_src;
	alt_u16 proc_dest;
	uint8_t num_of_token;
	cbuf_handle_t *buffer;
	bool external;
};
/******************* Structure *******************/

struct Edge* get_edge(uint8_t proc_num, uint8_t port_num, uint8_t inout);

cbuf_handle_t* get_buffer(alt_u16 proc_src, alt_u16 proc_dest);

void init_buffer();

void init_structures();

void send_packet(unsigned char node_src, unsigned char node_dest,
alt_u16 proc_src, alt_u16 proc_dest, unsigned char packsize, unsigned char *payload);

void receive_packet();

void receive_poll();
