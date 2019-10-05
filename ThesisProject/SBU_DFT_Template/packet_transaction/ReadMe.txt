Send & Receive Interface

- Send packet
	for sending packet, you have to use "send_packet" function
	this function has 6 arguments which are base address and control 
	address of FIFOs. Source and destination of packet. Also packet size
	and payload.

- Receive packet
	for receiving packet also you have to use "receive_packet" function. It has 
	arguments which are base address and control address of FIFO and also payload 
	which is output of function. 

* also you have to poll in your own code to receive packet