#include "packet_transaction_util.h"
#include "packet_transaction.h"

void send_packet(unsigned char src, unsigned char  dest, unsigned char packsize, unsigned char *payload){

    unsigned int temp;

    temp = ((packsize)<<16) | ((src)<<8) | (dest);
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = (src)<<24;
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 3))<<24) | ((*(payload + 2))<<16) | ((*(payload + 1))<<8) | ((*payload));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 7))<<24) | ((*(payload + 6))<<16) | ((*(payload + 5))<<8) | ((*(payload + 4)));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 11))<<24) | ((*(payload + 10))<<16) | ((*(payload + 9))<<8) | ((*(payload + 8)));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 15))<<24) | ((*(payload + 14))<<16) | ((*(payload + 13))<<8) | ((*(payload + 12)));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 19))<<24) | ((*(payload + 18))<<16) | ((*(payload + 17))<<8) | ((*(payload + 16)));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

    temp = ((*(payload + 23))<<24) | ((*(payload + 22))<<16) | ((*(payload + 21))<<8) | ((*(payload + 20)));
    altera_avalon_fifo_write_fifo(FIFO_SOURCE_BASE, FIFO_SOURCE_CSR, temp);

}

void read_payload(unsigned int temp, unsigned int byte_coef, unsigned char *payload){
	*(payload + 0 + byte_coef) = temp;
	printf("payload[%d] = %d\n",byte_coef,*(payload + 0 + byte_coef));
	temp >>= 8;
	
	*(payload + 1 + byte_coef) = temp;
	printf("payload[%d] = %d\n",(byte_coef + 1),*(payload + 1 + byte_coef));
	temp >>= 8;
	
	*(payload + 2 + byte_coef) = temp;
	printf("payload[%d] = %d\n",(byte_coef + 2),*(payload + 2 + byte_coef));
	temp >>= 8;
	
	*(payload + 3 + byte_coef) = temp;
	printf("payload[%d] = %d\n",(byte_coef + 3),*(payload + 3 + byte_coef));
}

void receive_packet(unsigned char *payload){
	
	unsigned int temp;
	unsigned char destinantion, source, packet_size;
	
	//first four bytes
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	destinantion = temp;
	printf("destiantion = %d\n",destinantion);
	temp >>= 8;

	source = temp;
	printf("source = %d\n",source);
	temp >>= 8;

	packet_size = temp;
	printf("packet_size = %d\n",packet_size);


	//second four bytes are not important
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);

	//from now, recieve the payload

	//1st four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,0,payload);

	//2nd four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,4,payload);

	//3rd four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,8,payload);

	//4th four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,12,payload);

	//5th four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,16,payload);

	//6th four bytes of payload 
	temp = altera_avalon_fifo_read_fifo(FIFO_SINK_BASE, FIFO_SINK_CSR);
	read_payload(temp,20,payload);	
}

void receive_poll(){
	int status;
	status = altera_avalon_fifo_read_status(FIFO_SINK_CSR,FIFO_STATUS);
    while(status & 0x02){
  	  status = altera_avalon_fifo_read_status(FIFO_SINK_CSR,FIFO_STATUS);
    }
}

