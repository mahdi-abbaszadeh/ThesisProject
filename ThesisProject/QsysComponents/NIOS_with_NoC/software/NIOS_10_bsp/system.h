/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_10' in SOPC Builder design 'NoC_QSYS'
 * SOPC Builder design path: ../../NoC_QSYS.sopcinfo
 *
 * Generated: Sun Jul 28 16:43:26 IRDT 2019
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00008820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x10
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00004020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x10
#define ALT_CPU_NAME "nios2_10"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00004000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00008820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x10
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00004020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x10
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00004000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_FIFO
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_NIOS2_GEN2


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x9050
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x9050
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x9050
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "NoC_QSYS"


/*
 * data_mem_10 configuration
 *
 */

#define ALT_MODULE_CLASS_data_mem_10 altera_avalon_onchip_memory2
#define DATA_MEM_10_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DATA_MEM_10_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DATA_MEM_10_BASE 0x4000
#define DATA_MEM_10_CONTENTS_INFO ""
#define DATA_MEM_10_DUAL_PORT 0
#define DATA_MEM_10_GUI_RAM_BLOCK_TYPE "AUTO"
#define DATA_MEM_10_INIT_CONTENTS_FILE "NoC_QSYS_data_mem_10"
#define DATA_MEM_10_INIT_MEM_CONTENT 1
#define DATA_MEM_10_INSTANCE_ID "NONE"
#define DATA_MEM_10_IRQ -1
#define DATA_MEM_10_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_MEM_10_NAME "/dev/data_mem_10"
#define DATA_MEM_10_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DATA_MEM_10_RAM_BLOCK_TYPE "AUTO"
#define DATA_MEM_10_READ_DURING_WRITE_MODE "DONT_CARE"
#define DATA_MEM_10_SINGLE_CLOCK_OP 0
#define DATA_MEM_10_SIZE_MULTIPLE 1
#define DATA_MEM_10_SIZE_VALUE 16384
#define DATA_MEM_10_SPAN 16384
#define DATA_MEM_10_TYPE "altera_avalon_onchip_memory2"
#define DATA_MEM_10_WRITABLE 1


/*
 * fifo_sink_10_in_csr configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_sink_10_in_csr altera_avalon_fifo
#define FIFO_SINK_10_IN_CSR_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_SINK_10_IN_CSR_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_SINK_10_IN_CSR_BASE 0x9020
#define FIFO_SINK_10_IN_CSR_BITS_PER_SYMBOL 8
#define FIFO_SINK_10_IN_CSR_CHANNEL_WIDTH 8
#define FIFO_SINK_10_IN_CSR_ERROR_WIDTH 8
#define FIFO_SINK_10_IN_CSR_FIFO_DEPTH 16
#define FIFO_SINK_10_IN_CSR_IRQ 0
#define FIFO_SINK_10_IN_CSR_IRQ_INTERRUPT_CONTROLLER_ID 0
#define FIFO_SINK_10_IN_CSR_NAME "/dev/fifo_sink_10_in_csr"
#define FIFO_SINK_10_IN_CSR_SINGLE_CLOCK_MODE 1
#define FIFO_SINK_10_IN_CSR_SPAN 32
#define FIFO_SINK_10_IN_CSR_SYMBOLS_PER_BEAT 4
#define FIFO_SINK_10_IN_CSR_TYPE "altera_avalon_fifo"
#define FIFO_SINK_10_IN_CSR_USE_AVALONMM_READ_SLAVE 1
#define FIFO_SINK_10_IN_CSR_USE_AVALONMM_WRITE_SLAVE 0
#define FIFO_SINK_10_IN_CSR_USE_AVALONST_SINK 1
#define FIFO_SINK_10_IN_CSR_USE_AVALONST_SOURCE 0
#define FIFO_SINK_10_IN_CSR_USE_BACKPRESSURE 1
#define FIFO_SINK_10_IN_CSR_USE_IRQ 1
#define FIFO_SINK_10_IN_CSR_USE_PACKET 0
#define FIFO_SINK_10_IN_CSR_USE_READ_CONTROL 0
#define FIFO_SINK_10_IN_CSR_USE_REGISTER 0
#define FIFO_SINK_10_IN_CSR_USE_WRITE_CONTROL 1


/*
 * fifo_sink_10_out configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_sink_10_out altera_avalon_fifo
#define FIFO_SINK_10_OUT_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_SINK_10_OUT_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_SINK_10_OUT_BASE 0x9040
#define FIFO_SINK_10_OUT_BITS_PER_SYMBOL 8
#define FIFO_SINK_10_OUT_CHANNEL_WIDTH 8
#define FIFO_SINK_10_OUT_ERROR_WIDTH 8
#define FIFO_SINK_10_OUT_FIFO_DEPTH 16
#define FIFO_SINK_10_OUT_IRQ -1
#define FIFO_SINK_10_OUT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_SINK_10_OUT_NAME "/dev/fifo_sink_10_out"
#define FIFO_SINK_10_OUT_SINGLE_CLOCK_MODE 1
#define FIFO_SINK_10_OUT_SPAN 8
#define FIFO_SINK_10_OUT_SYMBOLS_PER_BEAT 4
#define FIFO_SINK_10_OUT_TYPE "altera_avalon_fifo"
#define FIFO_SINK_10_OUT_USE_AVALONMM_READ_SLAVE 1
#define FIFO_SINK_10_OUT_USE_AVALONMM_WRITE_SLAVE 0
#define FIFO_SINK_10_OUT_USE_AVALONST_SINK 1
#define FIFO_SINK_10_OUT_USE_AVALONST_SOURCE 0
#define FIFO_SINK_10_OUT_USE_BACKPRESSURE 1
#define FIFO_SINK_10_OUT_USE_IRQ 1
#define FIFO_SINK_10_OUT_USE_PACKET 0
#define FIFO_SINK_10_OUT_USE_READ_CONTROL 0
#define FIFO_SINK_10_OUT_USE_REGISTER 0
#define FIFO_SINK_10_OUT_USE_WRITE_CONTROL 1


/*
 * fifo_source_10_in configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_source_10_in altera_avalon_fifo
#define FIFO_SOURCE_10_IN_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_SOURCE_10_IN_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_SOURCE_10_IN_BASE 0x9048
#define FIFO_SOURCE_10_IN_BITS_PER_SYMBOL 8
#define FIFO_SOURCE_10_IN_CHANNEL_WIDTH 8
#define FIFO_SOURCE_10_IN_ERROR_WIDTH 8
#define FIFO_SOURCE_10_IN_FIFO_DEPTH 16
#define FIFO_SOURCE_10_IN_IRQ -1
#define FIFO_SOURCE_10_IN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define FIFO_SOURCE_10_IN_NAME "/dev/fifo_source_10_in"
#define FIFO_SOURCE_10_IN_SINGLE_CLOCK_MODE 1
#define FIFO_SOURCE_10_IN_SPAN 8
#define FIFO_SOURCE_10_IN_SYMBOLS_PER_BEAT 4
#define FIFO_SOURCE_10_IN_TYPE "altera_avalon_fifo"
#define FIFO_SOURCE_10_IN_USE_AVALONMM_READ_SLAVE 0
#define FIFO_SOURCE_10_IN_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_SOURCE_10_IN_USE_AVALONST_SINK 0
#define FIFO_SOURCE_10_IN_USE_AVALONST_SOURCE 1
#define FIFO_SOURCE_10_IN_USE_BACKPRESSURE 1
#define FIFO_SOURCE_10_IN_USE_IRQ 1
#define FIFO_SOURCE_10_IN_USE_PACKET 0
#define FIFO_SOURCE_10_IN_USE_READ_CONTROL 0
#define FIFO_SOURCE_10_IN_USE_REGISTER 0
#define FIFO_SOURCE_10_IN_USE_WRITE_CONTROL 1


/*
 * fifo_source_10_in_csr configuration
 *
 */

#define ALT_MODULE_CLASS_fifo_source_10_in_csr altera_avalon_fifo
#define FIFO_SOURCE_10_IN_CSR_AVALONMM_AVALONMM_DATA_WIDTH 32
#define FIFO_SOURCE_10_IN_CSR_AVALONMM_AVALONST_DATA_WIDTH 32
#define FIFO_SOURCE_10_IN_CSR_BASE 0x9000
#define FIFO_SOURCE_10_IN_CSR_BITS_PER_SYMBOL 8
#define FIFO_SOURCE_10_IN_CSR_CHANNEL_WIDTH 8
#define FIFO_SOURCE_10_IN_CSR_ERROR_WIDTH 8
#define FIFO_SOURCE_10_IN_CSR_FIFO_DEPTH 16
#define FIFO_SOURCE_10_IN_CSR_IRQ 1
#define FIFO_SOURCE_10_IN_CSR_IRQ_INTERRUPT_CONTROLLER_ID 0
#define FIFO_SOURCE_10_IN_CSR_NAME "/dev/fifo_source_10_in_csr"
#define FIFO_SOURCE_10_IN_CSR_SINGLE_CLOCK_MODE 1
#define FIFO_SOURCE_10_IN_CSR_SPAN 32
#define FIFO_SOURCE_10_IN_CSR_SYMBOLS_PER_BEAT 4
#define FIFO_SOURCE_10_IN_CSR_TYPE "altera_avalon_fifo"
#define FIFO_SOURCE_10_IN_CSR_USE_AVALONMM_READ_SLAVE 0
#define FIFO_SOURCE_10_IN_CSR_USE_AVALONMM_WRITE_SLAVE 1
#define FIFO_SOURCE_10_IN_CSR_USE_AVALONST_SINK 0
#define FIFO_SOURCE_10_IN_CSR_USE_AVALONST_SOURCE 1
#define FIFO_SOURCE_10_IN_CSR_USE_BACKPRESSURE 1
#define FIFO_SOURCE_10_IN_CSR_USE_IRQ 1
#define FIFO_SOURCE_10_IN_CSR_USE_PACKET 0
#define FIFO_SOURCE_10_IN_CSR_USE_READ_CONTROL 0
#define FIFO_SOURCE_10_IN_CSR_USE_REGISTER 0
#define FIFO_SOURCE_10_IN_CSR_USE_WRITE_CONTROL 1


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x9050
#define JTAG_UART_0_IRQ 2
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8

#endif /* __SYSTEM_H_ */
