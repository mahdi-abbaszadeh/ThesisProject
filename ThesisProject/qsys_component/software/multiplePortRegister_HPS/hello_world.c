/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "system.h"

int main()
{
	/*int count = 0;
	int delay;*/
	unsigned short int* reg1 = (unsigned short int*)REG16_MULTIPLEPORT_AVALON_INTERFACE_0_AVALON_SLAVE_1_BASE;
	unsigned short int* reg2 = (unsigned short int*)REG16_MULTIPLEPORT_AVALON_INTERFACE_0_AVALON_SLAVE_2_BASE;

	printf("Hello from Nios II!\n");
	*(reg1) = 85;
	printf("%x\n",*(reg1));
	*(reg2) = *(reg1) - 16;
	printf("%x\n",*(reg2));


//	while(1) {
//				IOWR_ALTERA_AVALON_PIO_DATA(COMPONENT_1_LED_BASE, count & 0x0F);
//				delay = 0;
//				while(delay < 2000000)
//				{
//					delay++;
//				}
//				count++;
//	}
  return 0;
}
