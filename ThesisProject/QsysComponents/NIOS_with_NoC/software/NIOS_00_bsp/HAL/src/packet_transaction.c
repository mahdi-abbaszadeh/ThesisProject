#include "packet_transaction.h"

void send_packet(alt_u32 base_address, alt_u32 ctrl_address,
                 unsigned char src, unsigned char  dest, unsigned char packsize, unsigned char *data){

    unsigned int temp;

    temp = ((packsize)<<16) | ((src)<<8) | (dest);
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = (src)<<24;
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 3))<<24) | ((*(data + 2))<<16) | ((*(data + 1))<<8) | ((*data));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 7))<<24) | ((*(data + 6))<<16) | ((*(data + 5))<<8) | ((*(data + 4)));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 11))<<24) | ((*(data + 10))<<16) | ((*(data + 9))<<8) | ((*(data + 8)));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 15))<<24) | ((*(data + 14))<<16) | ((*(data + 13))<<8) | ((*(data + 12)));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 19))<<24) | ((*(data + 18))<<16) | ((*(data + 17))<<8) | ((*(data + 16)));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

    temp = ((*(data + 23))<<24) | ((*(data + 22))<<16) | ((*(data + 21))<<8) | ((*(data + 20)));
    altera_avalon_fifo_write_fifo(base_address, ctrl_address, temp);

}
