#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include <stdlib.h>

#define FIFO_SINK_CSR	FIFO_SINK_3_IN_CSR_BASE
#define FIFO_SOURCE_CSR	FIFO_SOURCE_3_IN_CSR_BASE
#define FIFO_SINK_BASE	FIFO_SINK_3_OUT_BASE
#define FIFO_SOURCE_BASE	FIFO_SOURCE_3_IN_BASE
#define FIFO_STATUS	ALTERA_AVALON_FIFO_STATUS_ALL

void send_packet(unsigned char node_src, unsigned char node_dest,
alt_u16 proc_src, alt_u16 proc_dest, unsigned char packsize, unsigned char *payload);

void receive_packet(unsigned char *payload);

void receive_poll();
