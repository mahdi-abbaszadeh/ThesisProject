/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "system.h"
#include "sys/alt_irq.h"
#include <stdio.h>
#include <stdlib.h>
#define ALMOST_EMPTY 2
#define ALMOST_FULL 11
volatile int input_fifo_wrclk_irq_event;



/* Initialize the fifo */
static int init_input_fifo_wrclk_control(alt_u32 control_base_address/*, alt_u32 control_interrupt*/)
{
/*


int return_code = ALTERA_AVALON_FIFO_OK;
 Recast the IRQ History pointer to match the alt_irq_register() function
* prototype.
void* input_fifo_wrclk_irq_event_ptr = (void*) &input_fifo_wrclk_irq_event;
 Enable all interrupts.
 Clear event register, set enable all irq, set almostempty and
almostfull threshold
return_code = altera_avalon_fifo_init(control_base_address,
0, // Disabled interrupts
ALMOST_EMPTY,
ALMOST_FULL);
 Register the interrupt handler.
alt_irq_register( control_interrupt,
input_fifo_wrclk_irq_event_ptr, handle_input_fifo_wrclk_interrupts );

*/

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


/*static void handle_input_fifo_wrclk_interrupts(void* context, alt_u32 id)
{
 Cast context to input_fifo_wrclk_irq_event's type. It is important
* to declare this volatile to avoid unwanted compiler optimization.

volatile int* input_fifo_wrclk_irq_event_ptr = (volatile int*) context;
 Store the value in the FIFO's irq history register in *context.
*input_fifo_wrclk_irq_event_ptr =
altera_avalon_fifo_read_event(INPUT_FIFO_IN_CSR_BASE,
ALTERA_AVALON_FIFO_EVENT_ALL);
printf("Interrupt Occurs for %#x\n", INPUT_FIFO_IN_CSR_BASE);
print_status(INPUT_FIFO_IN_CSR_BASE);
 Reset the FIFO's IRQ History register.
altera_avalon_fifo_clear_event(INPUT_FIFO_IN_CSR_BASE,
ALTERA_AVALON_FIFO_EVENT_ALL);
}*/

int main()
{
  int value = 0;
  alt_putstr("Hello from Nios II!\n");

  //initialization of FIFOs
  init_input_fifo_wrclk_control(MM2STFIFO_0_IN_CSR_BASE);
  init_input_fifo_wrclk_control(ST2MMFIFO_0_IN_CSR_BASE);

  alt_putstr("MM2STFIFO status:\n");
  print_status(MM2STFIFO_0_IN_CSR_BASE);

  alt_putstr("ST2MMFIFO status:\n");
  print_status(ST2MMFIFO_0_IN_CSR_BASE);

  alt_putstr("write to FIFO\n");
  //altera_avalon_fifo_write_fifo(MM2STFIFO_0_IN_BASE, MM2STFIFO_0_IN_CSR_BASE,85);
  altera_avalon_fifo_write_fifo(MM2STFIFO_0_IN_BASE, MM2STFIFO_0_IN_CSR_BASE,69);

  alt_putstr("read from FIFO:\n");
  value = altera_avalon_fifo_read_fifo(ST2MMFIFO_0_OUT_BASE, ST2MMFIFO_0_IN_CSR_BASE);
  printf("value = %d\n",value);
  //value = altera_avalon_fifo_read_fifo(ST2MMFIFO_0_OUT_BASE, ST2MMFIFO_0_IN_CSR_BASE);
  //printf("value = %d\n",value);
  /* Event loop never exits. */
  while (1);

  return 0;
}
