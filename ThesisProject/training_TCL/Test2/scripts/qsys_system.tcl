# -----------------------------------------------------------------
# qsys_system.tcl
#
#
# This Tcl script is used to generate the Quartus II version
# specific XML file qsys_system.qsys via
#
#    qsys-script \
#      --cmd="set quartus_version 14.0" \
#      --script=qsys_system.tcl
#
# -----------------------------------------------------------------
# Tcl->Qsys Script Creation
# --------------------------
#
# Qsys systems can be converted to, or generated from, Tcl
# scripts via the qsys-script procedure which is briefly descibed
# on the AlteraWiki
#
#  http://www.alterawiki.com/wiki/Qsys_Scripts
#
# The Qsys to Tcl generation script from the Wiki was modified to
# use qsys 14.0 and to generate the connections in alphabetical
# order (making file-differencing easier).
#
# The Tcl script generation procedure is as follows;
#
# 1. Create the Qsys system via the Qsys GUI and save
#    the XML file, eg., qsys_system.sys
#
# 2. Convert the .qsys file to .tcl via
#
#    qsys-script \
#      --cmd="set system_name qsys_system" \
#      --script=save_script.tcl \
#      --system-file=qsys_system.qsys
#
# 3. Conversely, you can convert .tcl to .qsys via
#
#    qsys-script --script=qsys_system.tcl
#
# The .qsys file can be edited in the GUI, and then converted
# to Tcl, and any changes used to update the .tcl file.
#
# This Tcl script was created by first creating a Qsys system
# in Quartus 14.0 and then converting that to .tcl. The generation
# script was then tested under 14.0, 13.0sp1, and 12.0.
#
# The qsys-script application is not a "true" Tcl application
# (its likely a Java Jacl-based implementation). The tool
# does not report its name via the Tcl command
# [info nameofexecutable], packages are not available,
# eg., "package require hdl" does not work, and the global variable
# quartus does not exist, so $quartus(version) cannot be used.
# For these reasons, the script parameters are passed via the
# qsys-script --cmd= option.
#
# -----------------------------------------------------------------
# Notes
# -----
#
# 1. add_instance version numbers
#
#    The add_instance procedure takes an optional version
#    parameter. Unfortunately the version number does not match
#    the Quartus version, so its not possible to simply pass
#    $quartus_version for the parameter, eg., under 13.0sp1
#    the SDRAM controller version is 13.0.1.99.2, whereas the
#    clock source and JTAG master versions are 13.0.
#
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# Script Arguments/Defaults
# -----------------------------------------------------------------
#
if {![info exists quartus_version]} {
	set quartus_version 14.0
}

# -----------------------------------------------------------------
# Tcl Packages
# -----------------------------------------------------------------
#
package require -exact qsys $quartus_version

# -----------------------------------------------------------------
# Qsys system
# -----------------------------------------------------------------
#
# Module properties
# -----------------
set_module_property NAME {qsys_system}

# Project properties
# ------------------
set_project_property DEVICE_FAMILY {Cyclone V}
set_project_property DEVICE {5CSEMA4U23C6}
set_project_property HIDE_FROM_IP_CATALOG {false}

# Components
# ----------
#
# The order the components are created here, matches the order
# they are displayed in the Qsys GUI.
#
# Instances and instance parameters
# (disabled instances are intentionally culled)
	add_instance NoC NoC 1.0
	set_instance_parameter_value NoC {RowNo} {2}
	set_instance_parameter_value NoC {ColNo} {2}
	set_instance_parameter_value NoC {AddrWidth} {2}
	set_instance_parameter_value NoC {DataWidth} {8}
	set_instance_parameter_value NoC {PackWidth} {8}
	set_instance_parameter_value NoC {PhyCh} {4}
	set_instance_parameter_value NoC {PhyChAddr} {2}
	set_instance_parameter_value NoC {PhyRoCh} {5}
	set_instance_parameter_value NoC {PhyRoChAddr} {3}
	set_instance_parameter_value NoC {RoCh} {1}
	set_instance_parameter_value NoC {RoChAddr} {1}
	set_instance_parameter_value NoC {ViCh} {1}
	set_instance_parameter_value NoC {ViChAddr} {1}

	add_instance clk_0 clock_source 17.1
	set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
	set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
	set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}

	add_instance data_mem_00 altera_avalon_onchip_memory2 17.1
	set_instance_parameter_value data_mem_00 {allowInSystemMemoryContentEditor} {0}
	set_instance_parameter_value data_mem_00 {blockType} {AUTO}
	set_instance_parameter_value data_mem_00 {copyInitFile} {0}
	set_instance_parameter_value data_mem_00 {dataWidth} {32}
	set_instance_parameter_value data_mem_00 {dataWidth2} {32}
	set_instance_parameter_value data_mem_00 {dualPort} {0}
	set_instance_parameter_value data_mem_00 {ecc_enabled} {0}
	set_instance_parameter_value data_mem_00 {enPRInitMode} {0}
	set_instance_parameter_value data_mem_00 {enableDiffWidth} {0}
	set_instance_parameter_value data_mem_00 {initMemContent} {1}
	set_instance_parameter_value data_mem_00 {initializationFileName} {onchip_mem.hex}
	set_instance_parameter_value data_mem_00 {instanceID} {NONE}
	set_instance_parameter_value data_mem_00 {memorySize} {16384.0}
	set_instance_parameter_value data_mem_00 {readDuringWriteMode} {DONT_CARE}
	set_instance_parameter_value data_mem_00 {resetrequest_enabled} {1}
	set_instance_parameter_value data_mem_00 {simAllowMRAMContentsFile} {0}
	set_instance_parameter_value data_mem_00 {simMemInitOnlyFilename} {0}
	set_instance_parameter_value data_mem_00 {singleClockOperation} {0}
	set_instance_parameter_value data_mem_00 {slave1Latency} {1}
	set_instance_parameter_value data_mem_00 {slave2Latency} {1}
	set_instance_parameter_value data_mem_00 {useNonDefaultInitFile} {0}
	set_instance_parameter_value data_mem_00 {useShallowMemBlocks} {0}
	set_instance_parameter_value data_mem_00 {writable} {1}

	add_instance data_mem_01 altera_avalon_onchip_memory2 17.1
	set_instance_parameter_value data_mem_01 {allowInSystemMemoryContentEditor} {0}
	set_instance_parameter_value data_mem_01 {blockType} {AUTO}
	set_instance_parameter_value data_mem_01 {copyInitFile} {0}
	set_instance_parameter_value data_mem_01 {dataWidth} {32}
	set_instance_parameter_value data_mem_01 {dataWidth2} {32}
	set_instance_parameter_value data_mem_01 {dualPort} {0}
	set_instance_parameter_value data_mem_01 {ecc_enabled} {0}
	set_instance_parameter_value data_mem_01 {enPRInitMode} {0}
	set_instance_parameter_value data_mem_01 {enableDiffWidth} {0}
	set_instance_parameter_value data_mem_01 {initMemContent} {1}
	set_instance_parameter_value data_mem_01 {initializationFileName} {onchip_mem.hex}
	set_instance_parameter_value data_mem_01 {instanceID} {NONE}
	set_instance_parameter_value data_mem_01 {memorySize} {16384.0}
	set_instance_parameter_value data_mem_01 {readDuringWriteMode} {DONT_CARE}
	set_instance_parameter_value data_mem_01 {resetrequest_enabled} {1}
	set_instance_parameter_value data_mem_01 {simAllowMRAMContentsFile} {0}
	set_instance_parameter_value data_mem_01 {simMemInitOnlyFilename} {0}
	set_instance_parameter_value data_mem_01 {singleClockOperation} {0}
	set_instance_parameter_value data_mem_01 {slave1Latency} {1}
	set_instance_parameter_value data_mem_01 {slave2Latency} {1}
	set_instance_parameter_value data_mem_01 {useNonDefaultInitFile} {0}
	set_instance_parameter_value data_mem_01 {useShallowMemBlocks} {0}
	set_instance_parameter_value data_mem_01 {writable} {1}

	add_instance data_mem_10 altera_avalon_onchip_memory2 17.1
	set_instance_parameter_value data_mem_10 {allowInSystemMemoryContentEditor} {0}
	set_instance_parameter_value data_mem_10 {blockType} {AUTO}
	set_instance_parameter_value data_mem_10 {copyInitFile} {0}
	set_instance_parameter_value data_mem_10 {dataWidth} {32}
	set_instance_parameter_value data_mem_10 {dataWidth2} {32}
	set_instance_parameter_value data_mem_10 {dualPort} {0}
	set_instance_parameter_value data_mem_10 {ecc_enabled} {0}
	set_instance_parameter_value data_mem_10 {enPRInitMode} {0}
	set_instance_parameter_value data_mem_10 {enableDiffWidth} {0}
	set_instance_parameter_value data_mem_10 {initMemContent} {1}
	set_instance_parameter_value data_mem_10 {initializationFileName} {onchip_mem.hex}
	set_instance_parameter_value data_mem_10 {instanceID} {NONE}
	set_instance_parameter_value data_mem_10 {memorySize} {16384.0}
	set_instance_parameter_value data_mem_10 {readDuringWriteMode} {DONT_CARE}
	set_instance_parameter_value data_mem_10 {resetrequest_enabled} {1}
	set_instance_parameter_value data_mem_10 {simAllowMRAMContentsFile} {0}
	set_instance_parameter_value data_mem_10 {simMemInitOnlyFilename} {0}
	set_instance_parameter_value data_mem_10 {singleClockOperation} {0}
	set_instance_parameter_value data_mem_10 {slave1Latency} {1}
	set_instance_parameter_value data_mem_10 {slave2Latency} {1}
	set_instance_parameter_value data_mem_10 {useNonDefaultInitFile} {0}
	set_instance_parameter_value data_mem_10 {useShallowMemBlocks} {0}
	set_instance_parameter_value data_mem_10 {writable} {1}

	add_instance data_mem_11 altera_avalon_onchip_memory2 17.1
	set_instance_parameter_value data_mem_11 {allowInSystemMemoryContentEditor} {0}
	set_instance_parameter_value data_mem_11 {blockType} {AUTO}
	set_instance_parameter_value data_mem_11 {copyInitFile} {0}
	set_instance_parameter_value data_mem_11 {dataWidth} {32}
	set_instance_parameter_value data_mem_11 {dataWidth2} {32}
	set_instance_parameter_value data_mem_11 {dualPort} {0}
	set_instance_parameter_value data_mem_11 {ecc_enabled} {0}
	set_instance_parameter_value data_mem_11 {enPRInitMode} {0}
	set_instance_parameter_value data_mem_11 {enableDiffWidth} {0}
	set_instance_parameter_value data_mem_11 {initMemContent} {1}
	set_instance_parameter_value data_mem_11 {initializationFileName} {onchip_mem.hex}
	set_instance_parameter_value data_mem_11 {instanceID} {NONE}
	set_instance_parameter_value data_mem_11 {memorySize} {16384.0}
	set_instance_parameter_value data_mem_11 {readDuringWriteMode} {DONT_CARE}
	set_instance_parameter_value data_mem_11 {resetrequest_enabled} {1}
	set_instance_parameter_value data_mem_11 {simAllowMRAMContentsFile} {0}
	set_instance_parameter_value data_mem_11 {simMemInitOnlyFilename} {0}
	set_instance_parameter_value data_mem_11 {singleClockOperation} {0}
	set_instance_parameter_value data_mem_11 {slave1Latency} {1}
	set_instance_parameter_value data_mem_11 {slave2Latency} {1}
	set_instance_parameter_value data_mem_11 {useNonDefaultInitFile} {0}
	set_instance_parameter_value data_mem_11 {useShallowMemBlocks} {0}
	set_instance_parameter_value data_mem_11 {writable} {1}

	add_instance fifo_sink_00 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_sink_00 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_sink_00 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_sink_00 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_sink_00 {channelWidth} {8}
	set_instance_parameter_value fifo_sink_00 {errorWidth} {8}
	set_instance_parameter_value fifo_sink_00 {fifoDepth} {16}
	set_instance_parameter_value fifo_sink_00 {fifoInputInterfaceOptions} {AVALONST_SINK}
	set_instance_parameter_value fifo_sink_00 {fifoOutputInterfaceOptions} {AVALONMM_READ}
	set_instance_parameter_value fifo_sink_00 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_sink_00 {singleClockMode} {1}
	set_instance_parameter_value fifo_sink_00 {singleResetMode} {0}
	set_instance_parameter_value fifo_sink_00 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_sink_00 {useBackpressure} {1}
	set_instance_parameter_value fifo_sink_00 {useIRQ} {1}
	set_instance_parameter_value fifo_sink_00 {usePacket} {0}
	set_instance_parameter_value fifo_sink_00 {useReadControl} {0}
	set_instance_parameter_value fifo_sink_00 {useRegister} {0}
	set_instance_parameter_value fifo_sink_00 {useWriteControl} {1}
 
	add_instance fifo_sink_01 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_sink_01 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_sink_01 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_sink_01 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_sink_01 {channelWidth} {8}
	set_instance_parameter_value fifo_sink_01 {errorWidth} {8}
	set_instance_parameter_value fifo_sink_01 {fifoDepth} {16}
	set_instance_parameter_value fifo_sink_01 {fifoInputInterfaceOptions} {AVALONST_SINK}
	set_instance_parameter_value fifo_sink_01 {fifoOutputInterfaceOptions} {AVALONMM_READ}
	set_instance_parameter_value fifo_sink_01 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_sink_01 {singleClockMode} {1}
	set_instance_parameter_value fifo_sink_01 {singleResetMode} {0}
	set_instance_parameter_value fifo_sink_01 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_sink_01 {useBackpressure} {1}
	set_instance_parameter_value fifo_sink_01 {useIRQ} {1}
	set_instance_parameter_value fifo_sink_01 {usePacket} {0}
	set_instance_parameter_value fifo_sink_01 {useReadControl} {0}
	set_instance_parameter_value fifo_sink_01 {useRegister} {0}
	set_instance_parameter_value fifo_sink_01 {useWriteControl} {1}

	add_instance fifo_sink_10 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_sink_10 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_sink_10 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_sink_10 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_sink_10 {channelWidth} {8}
	set_instance_parameter_value fifo_sink_10 {errorWidth} {8}
	set_instance_parameter_value fifo_sink_10 {fifoDepth} {16}
	set_instance_parameter_value fifo_sink_10 {fifoInputInterfaceOptions} {AVALONST_SINK}
	set_instance_parameter_value fifo_sink_10 {fifoOutputInterfaceOptions} {AVALONMM_READ}
	set_instance_parameter_value fifo_sink_10 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_sink_10 {singleClockMode} {1}
	set_instance_parameter_value fifo_sink_10 {singleResetMode} {0}
	set_instance_parameter_value fifo_sink_10 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_sink_10 {useBackpressure} {1}
	set_instance_parameter_value fifo_sink_10 {useIRQ} {1}
	set_instance_parameter_value fifo_sink_10 {usePacket} {0}
	set_instance_parameter_value fifo_sink_10 {useReadControl} {0}
	set_instance_parameter_value fifo_sink_10 {useRegister} {0}
	set_instance_parameter_value fifo_sink_10 {useWriteControl} {1}

	add_instance fifo_sink_11 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_sink_11 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_sink_11 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_sink_11 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_sink_11 {channelWidth} {8}
	set_instance_parameter_value fifo_sink_11 {errorWidth} {8}
	set_instance_parameter_value fifo_sink_11 {fifoDepth} {16}
	set_instance_parameter_value fifo_sink_11 {fifoInputInterfaceOptions} {AVALONST_SINK}
	set_instance_parameter_value fifo_sink_11 {fifoOutputInterfaceOptions} {AVALONMM_READ}
	set_instance_parameter_value fifo_sink_11 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_sink_11 {singleClockMode} {1}
	set_instance_parameter_value fifo_sink_11 {singleResetMode} {0}
	set_instance_parameter_value fifo_sink_11 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_sink_11 {useBackpressure} {1}
	set_instance_parameter_value fifo_sink_11 {useIRQ} {1}
	set_instance_parameter_value fifo_sink_11 {usePacket} {0}
	set_instance_parameter_value fifo_sink_11 {useReadControl} {0}
	set_instance_parameter_value fifo_sink_11 {useRegister} {0}
	set_instance_parameter_value fifo_sink_11 {useWriteControl} {1}

	add_instance fifo_source_00 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_source_00 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_source_00 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_source_00 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_source_00 {channelWidth} {8}
	set_instance_parameter_value fifo_source_00 {errorWidth} {8}
	set_instance_parameter_value fifo_source_00 {fifoDepth} {16}
	set_instance_parameter_value fifo_source_00 {fifoInputInterfaceOptions} {AVALONMM_WRITE}
	set_instance_parameter_value fifo_source_00 {fifoOutputInterfaceOptions} {AVALONST_SOURCE}
	set_instance_parameter_value fifo_source_00 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_source_00 {singleClockMode} {1}
	set_instance_parameter_value fifo_source_00 {singleResetMode} {0}
	set_instance_parameter_value fifo_source_00 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_source_00 {useBackpressure} {1}
	set_instance_parameter_value fifo_source_00 {useIRQ} {1}
	set_instance_parameter_value fifo_source_00 {usePacket} {0}
	set_instance_parameter_value fifo_source_00 {useReadControl} {0}
	set_instance_parameter_value fifo_source_00 {useRegister} {0}
	set_instance_parameter_value fifo_source_00 {useWriteControl} {1}

	add_instance fifo_source_01 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_source_01 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_source_01 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_source_01 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_source_01 {channelWidth} {8}
	set_instance_parameter_value fifo_source_01 {errorWidth} {8}
	set_instance_parameter_value fifo_source_01 {fifoDepth} {16}
	set_instance_parameter_value fifo_source_01 {fifoInputInterfaceOptions} {AVALONMM_WRITE}
	set_instance_parameter_value fifo_source_01 {fifoOutputInterfaceOptions} {AVALONST_SOURCE}
	set_instance_parameter_value fifo_source_01 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_source_01 {singleClockMode} {1}
	set_instance_parameter_value fifo_source_01 {singleResetMode} {0}
	set_instance_parameter_value fifo_source_01 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_source_01 {useBackpressure} {1}
	set_instance_parameter_value fifo_source_01 {useIRQ} {1}
	set_instance_parameter_value fifo_source_01 {usePacket} {0}
	set_instance_parameter_value fifo_source_01 {useReadControl} {0}
	set_instance_parameter_value fifo_source_01 {useRegister} {0}
	set_instance_parameter_value fifo_source_01 {useWriteControl} {1}

	add_instance fifo_source_10 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_source_10 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_source_10 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_source_10 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_source_10 {channelWidth} {8}
	set_instance_parameter_value fifo_source_10 {errorWidth} {8}
	set_instance_parameter_value fifo_source_10 {fifoDepth} {16}
	set_instance_parameter_value fifo_source_10 {fifoInputInterfaceOptions} {AVALONMM_WRITE}
	set_instance_parameter_value fifo_source_10 {fifoOutputInterfaceOptions} {AVALONST_SOURCE}
	set_instance_parameter_value fifo_source_10 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_source_10 {singleClockMode} {1}
	set_instance_parameter_value fifo_source_10 {singleResetMode} {0}
	set_instance_parameter_value fifo_source_10 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_source_10 {useBackpressure} {1}
	set_instance_parameter_value fifo_source_10 {useIRQ} {1}
	set_instance_parameter_value fifo_source_10 {usePacket} {0}
	set_instance_parameter_value fifo_source_10 {useReadControl} {0}
	set_instance_parameter_value fifo_source_10 {useRegister} {0}
	set_instance_parameter_value fifo_source_10 {useWriteControl} {1}

	add_instance fifo_source_11 altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_source_11 {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_source_11 {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_source_11 {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_source_11 {channelWidth} {8}
	set_instance_parameter_value fifo_source_11 {errorWidth} {8}
	set_instance_parameter_value fifo_source_11 {fifoDepth} {16}
	set_instance_parameter_value fifo_source_11 {fifoInputInterfaceOptions} {AVALONMM_WRITE}
	set_instance_parameter_value fifo_source_11 {fifoOutputInterfaceOptions} {AVALONST_SOURCE}
	set_instance_parameter_value fifo_source_11 {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_source_11 {singleClockMode} {1}
	set_instance_parameter_value fifo_source_11 {singleResetMode} {0}
	set_instance_parameter_value fifo_source_11 {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_source_11 {useBackpressure} {1}
	set_instance_parameter_value fifo_source_11 {useIRQ} {1}
	set_instance_parameter_value fifo_source_11 {usePacket} {0}
	set_instance_parameter_value fifo_source_11 {useReadControl} {0}
	set_instance_parameter_value fifo_source_11 {useRegister} {0}
	set_instance_parameter_value fifo_source_11 {useWriteControl} {1}

	add_instance jtag_uart_0 altera_avalon_jtag_uart 17.1
	set_instance_parameter_value jtag_uart_0 {allowMultipleConnections} {0}
	set_instance_parameter_value jtag_uart_0 {hubInstanceID} {0}
	set_instance_parameter_value jtag_uart_0 {readBufferDepth} {64}
	set_instance_parameter_value jtag_uart_0 {readIRQThreshold} {8}
	set_instance_parameter_value jtag_uart_0 {simInputCharacterStream} {}
	set_instance_parameter_value jtag_uart_0 {simInteractiveOptions} {NO_INTERACTIVE_WINDOWS}
	set_instance_parameter_value jtag_uart_0 {useRegistersForReadBuffer} {0}
	set_instance_parameter_value jtag_uart_0 {useRegistersForWriteBuffer} {0}
	set_instance_parameter_value jtag_uart_0 {useRelativePathForSimFile} {0}
	set_instance_parameter_value jtag_uart_0 {writeBufferDepth} {64}
	set_instance_parameter_value jtag_uart_0 {writeIRQThreshold} {8}

	add_instance nios2_00 altera_nios2_gen2 17.1
	set_instance_parameter_value nios2_00 {bht_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {breakOffset} {32}
	set_instance_parameter_value nios2_00 {breakSlave} {None}
	set_instance_parameter_value nios2_00 {cdx_enabled} {0}
	set_instance_parameter_value nios2_00 {cpuArchRev} {1}
	set_instance_parameter_value nios2_00 {cpuID} {0}
	set_instance_parameter_value nios2_00 {cpuReset} {0}
	set_instance_parameter_value nios2_00 {data_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_00 {data_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {data_master_paddr_base} {0}
	set_instance_parameter_value nios2_00 {data_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {dcache_bursts} {false}
	set_instance_parameter_value nios2_00 {dcache_numTCDM} {0}
	set_instance_parameter_value nios2_00 {dcache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {dcache_size} {2048}
	set_instance_parameter_value nios2_00 {dcache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {dcache_victim_buf_impl} {ram}
	set_instance_parameter_value nios2_00 {debug_OCIOnchipTrace} {_128}
	set_instance_parameter_value nios2_00 {debug_assignJtagInstanceID} {0}
	set_instance_parameter_value nios2_00 {debug_datatrigger} {0}
	set_instance_parameter_value nios2_00 {debug_debugReqSignals} {0}
	set_instance_parameter_value nios2_00 {debug_enabled} {1}
	set_instance_parameter_value nios2_00 {debug_hwbreakpoint} {0}
	set_instance_parameter_value nios2_00 {debug_jtagInstanceID} {0}
	set_instance_parameter_value nios2_00 {debug_traceStorage} {onchip_trace}
	set_instance_parameter_value nios2_00 {debug_traceType} {none}
	set_instance_parameter_value nios2_00 {debug_triggerArming} {1}
	set_instance_parameter_value nios2_00 {dividerType} {no_div}
	set_instance_parameter_value nios2_00 {exceptionOffset} {32}
	set_instance_parameter_value nios2_00 {exceptionSlave} {data_mem_00.s1}
	set_instance_parameter_value nios2_00 {fa_cache_line} {2}
	set_instance_parameter_value nios2_00 {fa_cache_linesize} {0}
	set_instance_parameter_value nios2_00 {flash_instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_00 {flash_instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {icache_burstType} {None}
	set_instance_parameter_value nios2_00 {icache_numTCIM} {0}
	set_instance_parameter_value nios2_00 {icache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {icache_size} {4096}
	set_instance_parameter_value nios2_00 {icache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {impl} {Tiny}
	set_instance_parameter_value nios2_00 {instruction_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_00 {instruction_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_00 {instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {io_regionbase} {0}
	set_instance_parameter_value nios2_00 {io_regionsize} {0}
	set_instance_parameter_value nios2_00 {master_addr_map} {0}
	set_instance_parameter_value nios2_00 {mmu_TLBMissExcOffset} {0}
	set_instance_parameter_value nios2_00 {mmu_TLBMissExcSlave} {None}
	set_instance_parameter_value nios2_00 {mmu_autoAssignTlbPtrSz} {1}
	set_instance_parameter_value nios2_00 {mmu_enabled} {0}
	set_instance_parameter_value nios2_00 {mmu_processIDNumBits} {8}
	set_instance_parameter_value nios2_00 {mmu_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {mmu_tlbNumWays} {16}
	set_instance_parameter_value nios2_00 {mmu_tlbPtrSz} {7}
	set_instance_parameter_value nios2_00 {mmu_udtlbNumEntries} {6}
	set_instance_parameter_value nios2_00 {mmu_uitlbNumEntries} {4}
	set_instance_parameter_value nios2_00 {mpu_enabled} {0}
	set_instance_parameter_value nios2_00 {mpu_minDataRegionSize} {12}
	set_instance_parameter_value nios2_00 {mpu_minInstRegionSize} {12}
	set_instance_parameter_value nios2_00 {mpu_numOfDataRegion} {8}
	set_instance_parameter_value nios2_00 {mpu_numOfInstRegion} {8}
	set_instance_parameter_value nios2_00 {mpu_useLimit} {0}
	set_instance_parameter_value nios2_00 {mpx_enabled} {0}
	set_instance_parameter_value nios2_00 {mul_32_impl} {2}
	set_instance_parameter_value nios2_00 {mul_64_impl} {0}
	set_instance_parameter_value nios2_00 {mul_shift_choice} {0}
	set_instance_parameter_value nios2_00 {ocimem_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {ocimem_ramInit} {0}
	set_instance_parameter_value nios2_00 {regfile_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_00 {register_file_por} {0}
	set_instance_parameter_value nios2_00 {resetOffset} {0}
	set_instance_parameter_value nios2_00 {resetSlave} {data_mem_00.s1}
	set_instance_parameter_value nios2_00 {resetrequest_enabled} {1}
	set_instance_parameter_value nios2_00 {setting_HBreakTest} {0}
	set_instance_parameter_value nios2_00 {setting_HDLSimCachesCleared} {1}
	set_instance_parameter_value nios2_00 {setting_activateMonitors} {1}
	set_instance_parameter_value nios2_00 {setting_activateTestEndChecker} {0}
	set_instance_parameter_value nios2_00 {setting_activateTrace} {0}
	set_instance_parameter_value nios2_00 {setting_allow_break_inst} {0}
	set_instance_parameter_value nios2_00 {setting_alwaysEncrypt} {1}
	set_instance_parameter_value nios2_00 {setting_asic_add_scan_mode_input} {0}
	set_instance_parameter_value nios2_00 {setting_asic_enabled} {0}
	set_instance_parameter_value nios2_00 {setting_asic_synopsys_translate_on_off} {0}
	set_instance_parameter_value nios2_00 {setting_asic_third_party_synthesis} {0}
	set_instance_parameter_value nios2_00 {setting_avalonDebugPortPresent} {0}
	set_instance_parameter_value nios2_00 {setting_bhtPtrSz} {8}
	set_instance_parameter_value nios2_00 {setting_bigEndian} {0}
	set_instance_parameter_value nios2_00 {setting_branchpredictiontype} {Dynamic}
	set_instance_parameter_value nios2_00 {setting_breakslaveoveride} {0}
	set_instance_parameter_value nios2_00 {setting_clearXBitsLDNonBypass} {1}
	set_instance_parameter_value nios2_00 {setting_dc_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_disable_tmr_inj} {0}
	set_instance_parameter_value nios2_00 {setting_disableocitrace} {0}
	set_instance_parameter_value nios2_00 {setting_dtcm_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_ecc_present} {0}
	set_instance_parameter_value nios2_00 {setting_ecc_sim_test_ports} {0}
	set_instance_parameter_value nios2_00 {setting_exportHostDebugPort} {0}
	set_instance_parameter_value nios2_00 {setting_exportPCB} {0}
	set_instance_parameter_value nios2_00 {setting_export_large_RAMs} {0}
	set_instance_parameter_value nios2_00 {setting_exportdebuginfo} {0}
	set_instance_parameter_value nios2_00 {setting_exportvectors} {0}
	set_instance_parameter_value nios2_00 {setting_fast_register_read} {0}
	set_instance_parameter_value nios2_00 {setting_ic_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_interruptControllerType} {Internal}
	set_instance_parameter_value nios2_00 {setting_itcm_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_mmu_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_oci_export_jtag_signals} {0}
	set_instance_parameter_value nios2_00 {setting_oci_version} {1}
	set_instance_parameter_value nios2_00 {setting_preciseIllegalMemAccessException} {0}
	set_instance_parameter_value nios2_00 {setting_removeRAMinit} {0}
	set_instance_parameter_value nios2_00 {setting_rf_ecc_present} {1}
	set_instance_parameter_value nios2_00 {setting_shadowRegisterSets} {0}
	set_instance_parameter_value nios2_00 {setting_showInternalSettings} {0}
	set_instance_parameter_value nios2_00 {setting_showUnpublishedSettings} {0}
	set_instance_parameter_value nios2_00 {setting_support31bitdcachebypass} {1}
	set_instance_parameter_value nios2_00 {setting_tmr_output_disable} {0}
	set_instance_parameter_value nios2_00 {setting_usedesignware} {0}
	set_instance_parameter_value nios2_00 {shift_rot_impl} {1}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_data_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_00 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_00 {tmr_enabled} {0}
	set_instance_parameter_value nios2_00 {tracefilename} {}
	set_instance_parameter_value nios2_00 {userDefinedSettings} {}

	add_instance nios2_01 altera_nios2_gen2 17.1
	set_instance_parameter_value nios2_01 {bht_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {breakOffset} {32}
	set_instance_parameter_value nios2_01 {breakSlave} {None}
	set_instance_parameter_value nios2_01 {cdx_enabled} {0}
	set_instance_parameter_value nios2_01 {cpuArchRev} {1}
	set_instance_parameter_value nios2_01 {cpuID} {0}
	set_instance_parameter_value nios2_01 {cpuReset} {0}
	set_instance_parameter_value nios2_01 {data_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_01 {data_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {data_master_paddr_base} {0}
	set_instance_parameter_value nios2_01 {data_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {dcache_bursts} {false}
	set_instance_parameter_value nios2_01 {dcache_numTCDM} {0}
	set_instance_parameter_value nios2_01 {dcache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {dcache_size} {2048}
	set_instance_parameter_value nios2_01 {dcache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {dcache_victim_buf_impl} {ram}
	set_instance_parameter_value nios2_01 {debug_OCIOnchipTrace} {_128}
	set_instance_parameter_value nios2_01 {debug_assignJtagInstanceID} {0}
	set_instance_parameter_value nios2_01 {debug_datatrigger} {0}
	set_instance_parameter_value nios2_01 {debug_debugReqSignals} {0}
	set_instance_parameter_value nios2_01 {debug_enabled} {1}
	set_instance_parameter_value nios2_01 {debug_hwbreakpoint} {0}
	set_instance_parameter_value nios2_01 {debug_jtagInstanceID} {0}
	set_instance_parameter_value nios2_01 {debug_traceStorage} {onchip_trace}
	set_instance_parameter_value nios2_01 {debug_traceType} {none}
	set_instance_parameter_value nios2_01 {debug_triggerArming} {1}
	set_instance_parameter_value nios2_01 {dividerType} {no_div}
	set_instance_parameter_value nios2_01 {exceptionOffset} {32}
	set_instance_parameter_value nios2_01 {exceptionSlave} {data_mem_01.s1}
	set_instance_parameter_value nios2_01 {fa_cache_line} {2}
	set_instance_parameter_value nios2_01 {fa_cache_linesize} {0}
	set_instance_parameter_value nios2_01 {flash_instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_01 {flash_instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {icache_burstType} {None}
	set_instance_parameter_value nios2_01 {icache_numTCIM} {0}
	set_instance_parameter_value nios2_01 {icache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {icache_size} {4096}
	set_instance_parameter_value nios2_01 {icache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {impl} {Tiny}
	set_instance_parameter_value nios2_01 {instruction_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_01 {instruction_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_01 {instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {io_regionbase} {0}
	set_instance_parameter_value nios2_01 {io_regionsize} {0}
	set_instance_parameter_value nios2_01 {master_addr_map} {0}
	set_instance_parameter_value nios2_01 {mmu_TLBMissExcOffset} {0}
	set_instance_parameter_value nios2_01 {mmu_TLBMissExcSlave} {None}
	set_instance_parameter_value nios2_01 {mmu_autoAssignTlbPtrSz} {1}
	set_instance_parameter_value nios2_01 {mmu_enabled} {0}
	set_instance_parameter_value nios2_01 {mmu_processIDNumBits} {8}
	set_instance_parameter_value nios2_01 {mmu_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {mmu_tlbNumWays} {16}
	set_instance_parameter_value nios2_01 {mmu_tlbPtrSz} {7}
	set_instance_parameter_value nios2_01 {mmu_udtlbNumEntries} {6}
	set_instance_parameter_value nios2_01 {mmu_uitlbNumEntries} {4}
	set_instance_parameter_value nios2_01 {mpu_enabled} {0}
	set_instance_parameter_value nios2_01 {mpu_minDataRegionSize} {12}
	set_instance_parameter_value nios2_01 {mpu_minInstRegionSize} {12}
	set_instance_parameter_value nios2_01 {mpu_numOfDataRegion} {8}
	set_instance_parameter_value nios2_01 {mpu_numOfInstRegion} {8}
	set_instance_parameter_value nios2_01 {mpu_useLimit} {0}
	set_instance_parameter_value nios2_01 {mpx_enabled} {0}
	set_instance_parameter_value nios2_01 {mul_32_impl} {2}
	set_instance_parameter_value nios2_01 {mul_64_impl} {0}
	set_instance_parameter_value nios2_01 {mul_shift_choice} {0}
	set_instance_parameter_value nios2_01 {ocimem_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {ocimem_ramInit} {0}
	set_instance_parameter_value nios2_01 {regfile_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_01 {register_file_por} {0}
	set_instance_parameter_value nios2_01 {resetOffset} {0}
	set_instance_parameter_value nios2_01 {resetSlave} {data_mem_01.s1}
	set_instance_parameter_value nios2_01 {resetrequest_enabled} {1}
	set_instance_parameter_value nios2_01 {setting_HBreakTest} {0}
	set_instance_parameter_value nios2_01 {setting_HDLSimCachesCleared} {1}
	set_instance_parameter_value nios2_01 {setting_activateMonitors} {1}
	set_instance_parameter_value nios2_01 {setting_activateTestEndChecker} {0}
	set_instance_parameter_value nios2_01 {setting_activateTrace} {0}
	set_instance_parameter_value nios2_01 {setting_allow_break_inst} {0}
	set_instance_parameter_value nios2_01 {setting_alwaysEncrypt} {1}
	set_instance_parameter_value nios2_01 {setting_asic_add_scan_mode_input} {0}
	set_instance_parameter_value nios2_01 {setting_asic_enabled} {0}
	set_instance_parameter_value nios2_01 {setting_asic_synopsys_translate_on_off} {0}
	set_instance_parameter_value nios2_01 {setting_asic_third_party_synthesis} {0}
	set_instance_parameter_value nios2_01 {setting_avalonDebugPortPresent} {0}
	set_instance_parameter_value nios2_01 {setting_bhtPtrSz} {8}
	set_instance_parameter_value nios2_01 {setting_bigEndian} {0}
	set_instance_parameter_value nios2_01 {setting_branchpredictiontype} {Dynamic}
	set_instance_parameter_value nios2_01 {setting_breakslaveoveride} {0}
	set_instance_parameter_value nios2_01 {setting_clearXBitsLDNonBypass} {1}
	set_instance_parameter_value nios2_01 {setting_dc_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_disable_tmr_inj} {0}
	set_instance_parameter_value nios2_01 {setting_disableocitrace} {0}
	set_instance_parameter_value nios2_01 {setting_dtcm_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_ecc_present} {0}
	set_instance_parameter_value nios2_01 {setting_ecc_sim_test_ports} {0}
	set_instance_parameter_value nios2_01 {setting_exportHostDebugPort} {0}
	set_instance_parameter_value nios2_01 {setting_exportPCB} {0}
	set_instance_parameter_value nios2_01 {setting_export_large_RAMs} {0}
	set_instance_parameter_value nios2_01 {setting_exportdebuginfo} {0}
	set_instance_parameter_value nios2_01 {setting_exportvectors} {0}
	set_instance_parameter_value nios2_01 {setting_fast_register_read} {0}
	set_instance_parameter_value nios2_01 {setting_ic_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_interruptControllerType} {Internal}
	set_instance_parameter_value nios2_01 {setting_itcm_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_mmu_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_oci_export_jtag_signals} {0}
	set_instance_parameter_value nios2_01 {setting_oci_version} {1}
	set_instance_parameter_value nios2_01 {setting_preciseIllegalMemAccessException} {0}
	set_instance_parameter_value nios2_01 {setting_removeRAMinit} {0}
	set_instance_parameter_value nios2_01 {setting_rf_ecc_present} {1}
	set_instance_parameter_value nios2_01 {setting_shadowRegisterSets} {0}
	set_instance_parameter_value nios2_01 {setting_showInternalSettings} {0}
	set_instance_parameter_value nios2_01 {setting_showUnpublishedSettings} {0}
	set_instance_parameter_value nios2_01 {setting_support31bitdcachebypass} {1}
	set_instance_parameter_value nios2_01 {setting_tmr_output_disable} {0}
	set_instance_parameter_value nios2_01 {setting_usedesignware} {0}
	set_instance_parameter_value nios2_01 {shift_rot_impl} {1}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_data_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_01 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_01 {tmr_enabled} {0}
	set_instance_parameter_value nios2_01 {tracefilename} {}
	set_instance_parameter_value nios2_01 {userDefinedSettings} {}

	add_instance nios2_10 altera_nios2_gen2 17.1
	set_instance_parameter_value nios2_10 {bht_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {breakOffset} {32}
	set_instance_parameter_value nios2_10 {breakSlave} {None}
	set_instance_parameter_value nios2_10 {cdx_enabled} {0}
	set_instance_parameter_value nios2_10 {cpuArchRev} {1}
	set_instance_parameter_value nios2_10 {cpuID} {0}
	set_instance_parameter_value nios2_10 {cpuReset} {0}
	set_instance_parameter_value nios2_10 {data_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_10 {data_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {data_master_paddr_base} {0}
	set_instance_parameter_value nios2_10 {data_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {dcache_bursts} {false}
	set_instance_parameter_value nios2_10 {dcache_numTCDM} {0}
	set_instance_parameter_value nios2_10 {dcache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {dcache_size} {2048}
	set_instance_parameter_value nios2_10 {dcache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {dcache_victim_buf_impl} {ram}
	set_instance_parameter_value nios2_10 {debug_OCIOnchipTrace} {_128}
	set_instance_parameter_value nios2_10 {debug_assignJtagInstanceID} {0}
	set_instance_parameter_value nios2_10 {debug_datatrigger} {0}
	set_instance_parameter_value nios2_10 {debug_debugReqSignals} {0}
	set_instance_parameter_value nios2_10 {debug_enabled} {1}
	set_instance_parameter_value nios2_10 {debug_hwbreakpoint} {0}
	set_instance_parameter_value nios2_10 {debug_jtagInstanceID} {0}
	set_instance_parameter_value nios2_10 {debug_traceStorage} {onchip_trace}
	set_instance_parameter_value nios2_10 {debug_traceType} {none}
	set_instance_parameter_value nios2_10 {debug_triggerArming} {1}
	set_instance_parameter_value nios2_10 {dividerType} {no_div}
	set_instance_parameter_value nios2_10 {exceptionOffset} {32}
	set_instance_parameter_value nios2_10 {exceptionSlave} {data_mem_10.s1}
	set_instance_parameter_value nios2_10 {fa_cache_line} {2}
	set_instance_parameter_value nios2_10 {fa_cache_linesize} {0}
	set_instance_parameter_value nios2_10 {flash_instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_10 {flash_instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {icache_burstType} {None}
	set_instance_parameter_value nios2_10 {icache_numTCIM} {0}
	set_instance_parameter_value nios2_10 {icache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {icache_size} {4096}
	set_instance_parameter_value nios2_10 {icache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {impl} {Tiny}
	set_instance_parameter_value nios2_10 {instruction_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_10 {instruction_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_10 {instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {io_regionbase} {0}
	set_instance_parameter_value nios2_10 {io_regionsize} {0}
	set_instance_parameter_value nios2_10 {master_addr_map} {0}
	set_instance_parameter_value nios2_10 {mmu_TLBMissExcOffset} {0}
	set_instance_parameter_value nios2_10 {mmu_TLBMissExcSlave} {None}
	set_instance_parameter_value nios2_10 {mmu_autoAssignTlbPtrSz} {1}
	set_instance_parameter_value nios2_10 {mmu_enabled} {0}
	set_instance_parameter_value nios2_10 {mmu_processIDNumBits} {8}
	set_instance_parameter_value nios2_10 {mmu_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {mmu_tlbNumWays} {16}
	set_instance_parameter_value nios2_10 {mmu_tlbPtrSz} {7}
	set_instance_parameter_value nios2_10 {mmu_udtlbNumEntries} {6}
	set_instance_parameter_value nios2_10 {mmu_uitlbNumEntries} {4}
	set_instance_parameter_value nios2_10 {mpu_enabled} {0}
	set_instance_parameter_value nios2_10 {mpu_minDataRegionSize} {12}
	set_instance_parameter_value nios2_10 {mpu_minInstRegionSize} {12}
	set_instance_parameter_value nios2_10 {mpu_numOfDataRegion} {8}
	set_instance_parameter_value nios2_10 {mpu_numOfInstRegion} {8}
	set_instance_parameter_value nios2_10 {mpu_useLimit} {0}
	set_instance_parameter_value nios2_10 {mpx_enabled} {0}
	set_instance_parameter_value nios2_10 {mul_32_impl} {2}
	set_instance_parameter_value nios2_10 {mul_64_impl} {0}
	set_instance_parameter_value nios2_10 {mul_shift_choice} {0}
	set_instance_parameter_value nios2_10 {ocimem_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {ocimem_ramInit} {0}
	set_instance_parameter_value nios2_10 {regfile_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_10 {register_file_por} {0}
	set_instance_parameter_value nios2_10 {resetOffset} {0}
	set_instance_parameter_value nios2_10 {resetSlave} {data_mem_10.s1}
	set_instance_parameter_value nios2_10 {resetrequest_enabled} {1}
	set_instance_parameter_value nios2_10 {setting_HBreakTest} {0}
	set_instance_parameter_value nios2_10 {setting_HDLSimCachesCleared} {1}
	set_instance_parameter_value nios2_10 {setting_activateMonitors} {1}
	set_instance_parameter_value nios2_10 {setting_activateTestEndChecker} {0}
	set_instance_parameter_value nios2_10 {setting_activateTrace} {0}
	set_instance_parameter_value nios2_10 {setting_allow_break_inst} {0}
	set_instance_parameter_value nios2_10 {setting_alwaysEncrypt} {1}
	set_instance_parameter_value nios2_10 {setting_asic_add_scan_mode_input} {0}
	set_instance_parameter_value nios2_10 {setting_asic_enabled} {0}
	set_instance_parameter_value nios2_10 {setting_asic_synopsys_translate_on_off} {0}
	set_instance_parameter_value nios2_10 {setting_asic_third_party_synthesis} {0}
	set_instance_parameter_value nios2_10 {setting_avalonDebugPortPresent} {0}
	set_instance_parameter_value nios2_10 {setting_bhtPtrSz} {8}
	set_instance_parameter_value nios2_10 {setting_bigEndian} {0}
	set_instance_parameter_value nios2_10 {setting_branchpredictiontype} {Dynamic}
	set_instance_parameter_value nios2_10 {setting_breakslaveoveride} {0}
	set_instance_parameter_value nios2_10 {setting_clearXBitsLDNonBypass} {1}
	set_instance_parameter_value nios2_10 {setting_dc_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_disable_tmr_inj} {0}
	set_instance_parameter_value nios2_10 {setting_disableocitrace} {0}
	set_instance_parameter_value nios2_10 {setting_dtcm_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_ecc_present} {0}
	set_instance_parameter_value nios2_10 {setting_ecc_sim_test_ports} {0}
	set_instance_parameter_value nios2_10 {setting_exportHostDebugPort} {0}
	set_instance_parameter_value nios2_10 {setting_exportPCB} {0}
	set_instance_parameter_value nios2_10 {setting_export_large_RAMs} {0}
	set_instance_parameter_value nios2_10 {setting_exportdebuginfo} {0}
	set_instance_parameter_value nios2_10 {setting_exportvectors} {0}
	set_instance_parameter_value nios2_10 {setting_fast_register_read} {0}
	set_instance_parameter_value nios2_10 {setting_ic_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_interruptControllerType} {Internal}
	set_instance_parameter_value nios2_10 {setting_itcm_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_mmu_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_oci_export_jtag_signals} {0}
	set_instance_parameter_value nios2_10 {setting_oci_version} {1}
	set_instance_parameter_value nios2_10 {setting_preciseIllegalMemAccessException} {0}
	set_instance_parameter_value nios2_10 {setting_removeRAMinit} {0}
	set_instance_parameter_value nios2_10 {setting_rf_ecc_present} {1}
	set_instance_parameter_value nios2_10 {setting_shadowRegisterSets} {0}
	set_instance_parameter_value nios2_10 {setting_showInternalSettings} {0}
	set_instance_parameter_value nios2_10 {setting_showUnpublishedSettings} {0}
	set_instance_parameter_value nios2_10 {setting_support31bitdcachebypass} {1}
	set_instance_parameter_value nios2_10 {setting_tmr_output_disable} {0}
	set_instance_parameter_value nios2_10 {setting_usedesignware} {0}
	set_instance_parameter_value nios2_10 {shift_rot_impl} {1}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_data_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_10 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_10 {tmr_enabled} {0}
	set_instance_parameter_value nios2_10 {tracefilename} {}
	set_instance_parameter_value nios2_10 {userDefinedSettings} {}

	add_instance nios2_11 altera_nios2_gen2 17.1
	set_instance_parameter_value nios2_11 {bht_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {breakOffset} {32}
	set_instance_parameter_value nios2_11 {breakSlave} {None}
	set_instance_parameter_value nios2_11 {cdx_enabled} {0}
	set_instance_parameter_value nios2_11 {cpuArchRev} {1}
	set_instance_parameter_value nios2_11 {cpuID} {0}
	set_instance_parameter_value nios2_11 {cpuReset} {0}
	set_instance_parameter_value nios2_11 {data_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_11 {data_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {data_master_paddr_base} {0}
	set_instance_parameter_value nios2_11 {data_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {dcache_bursts} {false}
	set_instance_parameter_value nios2_11 {dcache_numTCDM} {0}
	set_instance_parameter_value nios2_11 {dcache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {dcache_size} {2048}
	set_instance_parameter_value nios2_11 {dcache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {dcache_victim_buf_impl} {ram}
	set_instance_parameter_value nios2_11 {debug_OCIOnchipTrace} {_128}
	set_instance_parameter_value nios2_11 {debug_assignJtagInstanceID} {0}
	set_instance_parameter_value nios2_11 {debug_datatrigger} {0}
	set_instance_parameter_value nios2_11 {debug_debugReqSignals} {0}
	set_instance_parameter_value nios2_11 {debug_enabled} {1}
	set_instance_parameter_value nios2_11 {debug_hwbreakpoint} {0}
	set_instance_parameter_value nios2_11 {debug_jtagInstanceID} {0}
	set_instance_parameter_value nios2_11 {debug_traceStorage} {onchip_trace}
	set_instance_parameter_value nios2_11 {debug_traceType} {none}
	set_instance_parameter_value nios2_11 {debug_triggerArming} {1}
	set_instance_parameter_value nios2_11 {dividerType} {no_div}
	set_instance_parameter_value nios2_11 {exceptionOffset} {32}
	set_instance_parameter_value nios2_11 {exceptionSlave} {data_mem_11.s1}
	set_instance_parameter_value nios2_11 {fa_cache_line} {2}
	set_instance_parameter_value nios2_11 {fa_cache_linesize} {0}
	set_instance_parameter_value nios2_11 {flash_instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_11 {flash_instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {icache_burstType} {None}
	set_instance_parameter_value nios2_11 {icache_numTCIM} {0}
	set_instance_parameter_value nios2_11 {icache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {icache_size} {4096}
	set_instance_parameter_value nios2_11 {icache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {impl} {Tiny}
	set_instance_parameter_value nios2_11 {instruction_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_11 {instruction_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_11 {instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {io_regionbase} {0}
	set_instance_parameter_value nios2_11 {io_regionsize} {0}
	set_instance_parameter_value nios2_11 {master_addr_map} {0}
	set_instance_parameter_value nios2_11 {mmu_TLBMissExcOffset} {0}
	set_instance_parameter_value nios2_11 {mmu_TLBMissExcSlave} {None}
	set_instance_parameter_value nios2_11 {mmu_autoAssignTlbPtrSz} {1}
	set_instance_parameter_value nios2_11 {mmu_enabled} {0}
	set_instance_parameter_value nios2_11 {mmu_processIDNumBits} {8}
	set_instance_parameter_value nios2_11 {mmu_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {mmu_tlbNumWays} {16}
	set_instance_parameter_value nios2_11 {mmu_tlbPtrSz} {7}
	set_instance_parameter_value nios2_11 {mmu_udtlbNumEntries} {6}
	set_instance_parameter_value nios2_11 {mmu_uitlbNumEntries} {4}
	set_instance_parameter_value nios2_11 {mpu_enabled} {0}
	set_instance_parameter_value nios2_11 {mpu_minDataRegionSize} {12}
	set_instance_parameter_value nios2_11 {mpu_minInstRegionSize} {12}
	set_instance_parameter_value nios2_11 {mpu_numOfDataRegion} {8}
	set_instance_parameter_value nios2_11 {mpu_numOfInstRegion} {8}
	set_instance_parameter_value nios2_11 {mpu_useLimit} {0}
	set_instance_parameter_value nios2_11 {mpx_enabled} {0}
	set_instance_parameter_value nios2_11 {mul_32_impl} {2}
	set_instance_parameter_value nios2_11 {mul_64_impl} {0}
	set_instance_parameter_value nios2_11 {mul_shift_choice} {0}
	set_instance_parameter_value nios2_11 {ocimem_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {ocimem_ramInit} {0}
	set_instance_parameter_value nios2_11 {regfile_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_11 {register_file_por} {0}
	set_instance_parameter_value nios2_11 {resetOffset} {0}
	set_instance_parameter_value nios2_11 {resetSlave} {data_mem_11.s1}
	set_instance_parameter_value nios2_11 {resetrequest_enabled} {1}
	set_instance_parameter_value nios2_11 {setting_HBreakTest} {0}
	set_instance_parameter_value nios2_11 {setting_HDLSimCachesCleared} {1}
	set_instance_parameter_value nios2_11 {setting_activateMonitors} {1}
	set_instance_parameter_value nios2_11 {setting_activateTestEndChecker} {0}
	set_instance_parameter_value nios2_11 {setting_activateTrace} {0}
	set_instance_parameter_value nios2_11 {setting_allow_break_inst} {0}
	set_instance_parameter_value nios2_11 {setting_alwaysEncrypt} {1}
	set_instance_parameter_value nios2_11 {setting_asic_add_scan_mode_input} {0}
	set_instance_parameter_value nios2_11 {setting_asic_enabled} {0}
	set_instance_parameter_value nios2_11 {setting_asic_synopsys_translate_on_off} {0}
	set_instance_parameter_value nios2_11 {setting_asic_third_party_synthesis} {0}
	set_instance_parameter_value nios2_11 {setting_avalonDebugPortPresent} {0}
	set_instance_parameter_value nios2_11 {setting_bhtPtrSz} {8}
	set_instance_parameter_value nios2_11 {setting_bigEndian} {0}
	set_instance_parameter_value nios2_11 {setting_branchpredictiontype} {Dynamic}
	set_instance_parameter_value nios2_11 {setting_breakslaveoveride} {0}
	set_instance_parameter_value nios2_11 {setting_clearXBitsLDNonBypass} {1}
	set_instance_parameter_value nios2_11 {setting_dc_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_disable_tmr_inj} {0}
	set_instance_parameter_value nios2_11 {setting_disableocitrace} {0}
	set_instance_parameter_value nios2_11 {setting_dtcm_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_ecc_present} {0}
	set_instance_parameter_value nios2_11 {setting_ecc_sim_test_ports} {0}
	set_instance_parameter_value nios2_11 {setting_exportHostDebugPort} {0}
	set_instance_parameter_value nios2_11 {setting_exportPCB} {0}
	set_instance_parameter_value nios2_11 {setting_export_large_RAMs} {0}
	set_instance_parameter_value nios2_11 {setting_exportdebuginfo} {0}
	set_instance_parameter_value nios2_11 {setting_exportvectors} {0}
	set_instance_parameter_value nios2_11 {setting_fast_register_read} {0}
	set_instance_parameter_value nios2_11 {setting_ic_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_interruptControllerType} {Internal}
	set_instance_parameter_value nios2_11 {setting_itcm_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_mmu_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_oci_export_jtag_signals} {0}
	set_instance_parameter_value nios2_11 {setting_oci_version} {1}
	set_instance_parameter_value nios2_11 {setting_preciseIllegalMemAccessException} {0}
	set_instance_parameter_value nios2_11 {setting_removeRAMinit} {0}
	set_instance_parameter_value nios2_11 {setting_rf_ecc_present} {1}
	set_instance_parameter_value nios2_11 {setting_shadowRegisterSets} {0}
	set_instance_parameter_value nios2_11 {setting_showInternalSettings} {0}
	set_instance_parameter_value nios2_11 {setting_showUnpublishedSettings} {0}
	set_instance_parameter_value nios2_11 {setting_support31bitdcachebypass} {1}
	set_instance_parameter_value nios2_11 {setting_tmr_output_disable} {0}
	set_instance_parameter_value nios2_11 {setting_usedesignware} {0}
	set_instance_parameter_value nios2_11 {shift_rot_impl} {1}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_data_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_11 {tightly_coupled_instruction_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_11 {tmr_enabled} {0}
	set_instance_parameter_value nios2_11 {tracefilename} {}
	set_instance_parameter_value nios2_11 {userDefinedSettings} {}

# Connections
# -----------
	add_connection NoC.source_00 fifo_sink_00.in avalon_streaming

	add_connection NoC.source_01 fifo_sink_01.in avalon_streaming

	add_connection NoC.source_10 fifo_sink_10.in avalon_streaming

	add_connection NoC.source_11 fifo_sink_11.in avalon_streaming

	add_connection clk_0.clk NoC.clock clock

	add_connection clk_0.clk data_mem_00.clk1 clock

	add_connection clk_0.clk data_mem_01.clk1 clock

	add_connection clk_0.clk data_mem_10.clk1 clock

	add_connection clk_0.clk data_mem_11.clk1 clock

	add_connection clk_0.clk fifo_sink_00.clk_in clock

	add_connection clk_0.clk fifo_sink_01.clk_in clock

	add_connection clk_0.clk fifo_sink_10.clk_in clock

	add_connection clk_0.clk fifo_sink_11.clk_in clock

	add_connection clk_0.clk fifo_source_00.clk_in clock

	add_connection clk_0.clk fifo_source_01.clk_in clock

	add_connection clk_0.clk fifo_source_10.clk_in clock

	add_connection clk_0.clk fifo_source_11.clk_in clock

	add_connection clk_0.clk jtag_uart_0.clk clock

	add_connection clk_0.clk nios2_00.clk clock

	add_connection clk_0.clk nios2_01.clk clock

	add_connection clk_0.clk nios2_10.clk clock

	add_connection clk_0.clk nios2_11.clk clock

	add_connection clk_0.clk_reset NoC.reset reset

	add_connection clk_0.clk_reset data_mem_00.reset1 reset

	add_connection clk_0.clk_reset data_mem_01.reset1 reset

	add_connection clk_0.clk_reset data_mem_10.reset1 reset

	add_connection clk_0.clk_reset data_mem_11.reset1 reset

	add_connection clk_0.clk_reset fifo_sink_00.reset_in reset

	add_connection clk_0.clk_reset fifo_sink_01.reset_in reset

	add_connection clk_0.clk_reset fifo_sink_10.reset_in reset

	add_connection clk_0.clk_reset fifo_sink_11.reset_in reset

	add_connection clk_0.clk_reset fifo_source_00.reset_in reset

	add_connection clk_0.clk_reset fifo_source_01.reset_in reset

	add_connection clk_0.clk_reset fifo_source_10.reset_in reset

	add_connection clk_0.clk_reset fifo_source_11.reset_in reset

	add_connection clk_0.clk_reset jtag_uart_0.reset reset

	add_connection clk_0.clk_reset nios2_00.reset reset

	add_connection clk_0.clk_reset nios2_01.reset reset

	add_connection clk_0.clk_reset nios2_10.reset reset

	add_connection clk_0.clk_reset nios2_11.reset reset

	add_connection fifo_source_00.out NoC.sink_00 avalon_streaming

	add_connection fifo_source_01.out NoC.sink_01 avalon_streaming

	add_connection fifo_source_10.out NoC.sink_10 avalon_streaming

	add_connection fifo_source_11.out NoC.sink_11 avalon_streaming

	add_connection nios2_00.data_master data_mem_00.s1 avalon
	set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 defaultConnection {0}

	add_connection nios2_00.data_master fifo_sink_00.in_csr avalon
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr baseAddress {0x9020}
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr defaultConnection {0}

	add_connection nios2_00.data_master fifo_sink_00.out avalon
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out baseAddress {0x9040}
	set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out defaultConnection {0}

	add_connection nios2_00.data_master fifo_source_00.in avalon
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in baseAddress {0x9048}
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in defaultConnection {0}

	add_connection nios2_00.data_master fifo_source_00.in_csr avalon
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr baseAddress {0x9000}
	set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr defaultConnection {0}

	add_connection nios2_00.data_master jtag_uart_0.avalon_jtag_slave avalon
	set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	add_connection nios2_00.data_master nios2_00.debug_mem_slave avalon
	set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave defaultConnection {0}

	add_connection nios2_00.debug_reset_request clk_0.clk_in_reset reset

	add_connection nios2_00.instruction_master data_mem_00.s1 avalon
	set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 defaultConnection {0}

	add_connection nios2_00.instruction_master nios2_00.debug_mem_slave avalon
	set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave defaultConnection {0}

	add_connection nios2_00.irq fifo_sink_00.in_irq interrupt
	set_connection_parameter_value nios2_00.irq/fifo_sink_00.in_irq irqNumber {0}

	add_connection nios2_00.irq fifo_source_00.in_irq interrupt
	set_connection_parameter_value nios2_00.irq/fifo_source_00.in_irq irqNumber {1}

	add_connection nios2_00.irq jtag_uart_0.irq interrupt
	set_connection_parameter_value nios2_00.irq/jtag_uart_0.irq irqNumber {2}

	add_connection nios2_01.data_master data_mem_01.s1 avalon
	set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 defaultConnection {0}

	add_connection nios2_01.data_master fifo_sink_01.in_csr avalon
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr baseAddress {0x9020}
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr defaultConnection {0}

	add_connection nios2_01.data_master fifo_sink_01.out avalon
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out baseAddress {0x9040}
	set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out defaultConnection {0}

	add_connection nios2_01.data_master fifo_source_01.in avalon
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in baseAddress {0x9048}
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in defaultConnection {0}

	add_connection nios2_01.data_master fifo_source_01.in_csr avalon
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr baseAddress {0x9000}
	set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr defaultConnection {0}

	add_connection nios2_01.data_master jtag_uart_0.avalon_jtag_slave avalon
	set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	add_connection nios2_01.data_master nios2_01.debug_mem_slave avalon
	set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave defaultConnection {0}

	add_connection nios2_01.debug_reset_request clk_0.clk_in_reset reset

	add_connection nios2_01.instruction_master data_mem_01.s1 avalon
	set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 defaultConnection {0}

	add_connection nios2_01.instruction_master nios2_01.debug_mem_slave avalon
	set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave defaultConnection {0}

	add_connection nios2_01.irq fifo_sink_01.in_irq interrupt
	set_connection_parameter_value nios2_01.irq/fifo_sink_01.in_irq irqNumber {0}

	add_connection nios2_01.irq fifo_source_01.in_irq interrupt
	set_connection_parameter_value nios2_01.irq/fifo_source_01.in_irq irqNumber {1}

	add_connection nios2_01.irq jtag_uart_0.irq interrupt
	set_connection_parameter_value nios2_01.irq/jtag_uart_0.irq irqNumber {2}

	add_connection nios2_10.data_master data_mem_10.s1 avalon
	set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 defaultConnection {0}

	add_connection nios2_10.data_master fifo_sink_10.in_csr avalon
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr baseAddress {0x9020}
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr defaultConnection {0}

	add_connection nios2_10.data_master fifo_sink_10.out avalon
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out baseAddress {0x9040}
	set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out defaultConnection {0}

	add_connection nios2_10.data_master fifo_source_10.in avalon
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in baseAddress {0x9048}
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in defaultConnection {0}

	add_connection nios2_10.data_master fifo_source_10.in_csr avalon
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr baseAddress {0x9000}
	set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr defaultConnection {0}

	add_connection nios2_10.data_master jtag_uart_0.avalon_jtag_slave avalon
	set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	add_connection nios2_10.data_master nios2_10.debug_mem_slave avalon
	set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave defaultConnection {0}

	add_connection nios2_10.debug_reset_request clk_0.clk_in_reset reset

	add_connection nios2_10.instruction_master data_mem_10.s1 avalon
	set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 defaultConnection {0}

	add_connection nios2_10.instruction_master nios2_10.debug_mem_slave avalon
	set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave defaultConnection {0}

	add_connection nios2_10.irq fifo_sink_10.in_irq interrupt
	set_connection_parameter_value nios2_10.irq/fifo_sink_10.in_irq irqNumber {0}

	add_connection nios2_10.irq fifo_source_10.in_irq interrupt
	set_connection_parameter_value nios2_10.irq/fifo_source_10.in_irq irqNumber {1}

	add_connection nios2_10.irq jtag_uart_0.irq interrupt
	set_connection_parameter_value nios2_10.irq/jtag_uart_0.irq irqNumber {2}

	add_connection nios2_11.data_master data_mem_11.s1 avalon
	set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 defaultConnection {0}

	add_connection nios2_11.data_master fifo_sink_11.in_csr avalon
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr baseAddress {0x9020}
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr defaultConnection {0}

	add_connection nios2_11.data_master fifo_sink_11.out avalon
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out baseAddress {0x9040}
	set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out defaultConnection {0}

	add_connection nios2_11.data_master fifo_source_11.in avalon
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in baseAddress {0x9048}
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in defaultConnection {0}

	add_connection nios2_11.data_master fifo_source_11.in_csr avalon
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr baseAddress {0x9000}
	set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr defaultConnection {0}

	add_connection nios2_11.data_master jtag_uart_0.avalon_jtag_slave avalon
	set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	add_connection nios2_11.data_master nios2_11.debug_mem_slave avalon
	set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave defaultConnection {0}

	add_connection nios2_11.debug_reset_request clk_0.clk_in_reset reset

	add_connection nios2_11.instruction_master data_mem_11.s1 avalon
	set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 defaultConnection {0}

	add_connection nios2_11.instruction_master nios2_11.debug_mem_slave avalon
	set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave defaultConnection {0}

	add_connection nios2_11.irq fifo_sink_11.in_irq interrupt
	set_connection_parameter_value nios2_11.irq/fifo_sink_11.in_irq irqNumber {0}

	add_connection nios2_11.irq fifo_source_11.in_irq interrupt
	set_connection_parameter_value nios2_11.irq/fifo_source_11.in_irq irqNumber {1}

	add_connection nios2_11.irq jtag_uart_0.irq interrupt
	set_connection_parameter_value nios2_11.irq/jtag_uart_0.irq irqNumber {2}

# Exported interfaces
# -------------------
#
# Top-level entity ports
#
	add_interface clk clock sink
	set_interface_property clk EXPORT_OF clk_0.clk_in

# interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}

# Save the system
# ---------------
save_system "qsys_system.qsys"
