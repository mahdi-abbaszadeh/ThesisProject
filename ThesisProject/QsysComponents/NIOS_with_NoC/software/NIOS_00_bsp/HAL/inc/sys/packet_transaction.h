#ifndef __PACKET_TRANS__
#define __PACKET_TRANS__

#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include <stdlib.h>

void send_packet(alt_u32 base_address, alt_u32 ctrl_address,
                 unsigned char src, unsigned char  dest, unsigned char packsize, unsigned char *data);
#endif /* __PACKET_TRANS__ */
