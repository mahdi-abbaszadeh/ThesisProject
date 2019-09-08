# -----------------------------------------------------------------
# qsys_system.tcl


# This Tcl script is used to generate the Quartus II version
# specific XML file qsys_system.qsys via

#    qsys-script \
#      --cmd="set quartus_version 14.0" \
#      --script=qsys_system.tcl

# -----------------------------------------------------------------
# Tcl->Qsys Script Creation
# --------------------------

# Qsys systems can be converted to, or generated from, Tcl
# scripts via the qsys-script procedure which is briefly descibed
# on the AlteraWiki

#  http://www.alterawiki.com/wiki/Qsys_Scripts

# The Qsys to Tcl generation script from the Wiki was modified to
# use qsys 14.0 and to generate the connections in alphabetical
# order (making file-differencing easier).

# The Tcl script generation procedure is as follows;

# 1. Create the Qsys system via the Qsys GUI and save
#    the XML file, eg., qsys_system.sys

# 2. Convert the .qsys file to .tcl via

#    qsys-script \
#      --cmd="set system_name qsys_system" \
#      --script=save_script.tcl \
#      --system-file=qsys_system.qsys

# 3. Conversely, you can convert .tcl to .qsys via

#    qsys-script --script=qsys_system.tcl

# The .qsys file can be edited in the GUI, and then converted
# to Tcl, and any changes used to update the .tcl file.

# This Tcl script was created by first creating a Qsys system
# in Quartus 14.0 and then converting that to .tcl. The generation
# script was then tested under 14.0, 13.0sp1, and 12.0.

# The qsys-script application is not a "true" Tcl application
# (its likely a Java Jacl-based implementation). The tool
# does not report its name via the Tcl command
# [info nameofexecutable], packages are not available,
# eg., "package require hdl" does not work, and the global variable
# quartus does not exist, so $quartus(version) cannot be used.
# For these reasons, the script parameters are passed via the
# qsys-script --cmd= option.

# -----------------------------------------------------------------
# Notes
# -----

# 1. add_instance version numbers

#    The add_instance procedure takes an optional version
#    parameter. Unfortunately the version number does not match
#    the Quartus version, so its not possible to simply pass
#    $quartus_version for the parameter, eg., under 13.0sp1
#    the SDRAM controller version is 13.0.1.99.2, whereas the
#    clock source and JTAG master versions are 13.0.

# -----------------------------------------------------------------

# -----------------------------------------------------------------
# Script Arguments/Defaults
# -----------------------------------------------------------------

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
set_project_property DEVICE_FAMILY {@project_properties.DEVICE_FAMILY}
set_project_property DEVICE {@project_properties.DEVICE}
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
	set_instance_parameter_value NoC {AddrWidth} {@NoC.AddrWidth}
	set_instance_parameter_value NoC {DataWidth} {@NoC.DataWidth}
	set_instance_parameter_value NoC {PackWidth} {@NoC.PackWidth}
	set_instance_parameter_value NoC {PhyCh} {@NoC.PhyCh}
	set_instance_parameter_value NoC {PhyChAddr} {@NoC.PhyChAddr}
	set_instance_parameter_value NoC {PhyRoCh} {@NoC.PhyRoCh}
	set_instance_parameter_value NoC {PhyRoChAddr} {@NoC.PhyRoChAddr}
	set_instance_parameter_value NoC {RoCh} {@NoC.RoCh}
	set_instance_parameter_value NoC {RoChAddr} {@NoC.RoChAddr}
	set_instance_parameter_value NoC {ViCh} {@NoC.ViCh}
	set_instance_parameter_value NoC {ViChAddr} {@NoC.ViChAddr}

	add_instance clk_0 clock_source 17.1
	set_instance_parameter_value clk_0 {clockFrequency} {50000000.0}
	set_instance_parameter_value clk_0 {clockFrequencyKnown} {1}
	set_instance_parameter_value clk_0 {resetSynchronousEdges} {NONE}


	#for @tile in @tiles:

	add_instance data_mem_@tile.name altera_avalon_onchip_memory2 17.1
	set_instance_parameter_value data_mem_@tile.name {allowInSystemMemoryContentEditor} {0}
	set_instance_parameter_value data_mem_@tile.name {blockType} {AUTO}
	set_instance_parameter_value data_mem_@tile.name {copyInitFile} {0}
	set_instance_parameter_value data_mem_@tile.name {dataWidth} {32}
	set_instance_parameter_value data_mem_@tile.name {dataWidth2} {32}
	set_instance_parameter_value data_mem_@tile.name {dualPort} {0}
	set_instance_parameter_value data_mem_@tile.name {ecc_enabled} {0}
	set_instance_parameter_value data_mem_@tile.name {enPRInitMode} {0}
	set_instance_parameter_value data_mem_@tile.name {enableDiffWidth} {0}
	set_instance_parameter_value data_mem_@tile.name {initMemContent} {1}
	set_instance_parameter_value data_mem_@tile.name {initializationFileName} {onchip_mem.hex}
	set_instance_parameter_value data_mem_@tile.name {instanceID} {NONE}
	set_instance_parameter_value data_mem_@tile.name {memorySize} {@tile.memory_size}
	set_instance_parameter_value data_mem_@tile.name {readDuringWriteMode} {DONT_CARE}
	set_instance_parameter_value data_mem_@tile.name {resetrequest_enabled} {1}
	set_instance_parameter_value data_mem_@tile.name {simAllowMRAMContentsFile} {0}
	set_instance_parameter_value data_mem_@tile.name {simMemInitOnlyFilename} {0}
	set_instance_parameter_value data_mem_@tile.name {singleClockOperation} {0}
	set_instance_parameter_value data_mem_@tile.name {slave1Latency} {1}
	set_instance_parameter_value data_mem_@tile.name {slave2Latency} {1}
	set_instance_parameter_value data_mem_@tile.name {useNonDefaultInitFile} {0}
	set_instance_parameter_value data_mem_@tile.name {useShallowMemBlocks} {0}
	set_instance_parameter_value data_mem_@tile.name {writable} {1}

	#end

	#for @tile in @tiles:
	
	add_instance fifo_sink_@tile.name altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_sink_@tile.name {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_sink_@tile.name {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_sink_@tile.name {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_sink_@tile.name {channelWidth} {8}
	set_instance_parameter_value fifo_sink_@tile.name {errorWidth} {8}
	set_instance_parameter_value fifo_sink_@tile.name {fifoDepth} {@tile.fifo_out_depth}
	set_instance_parameter_value fifo_sink_@tile.name {fifoInputInterfaceOptions} {AVALONST_SINK}
	set_instance_parameter_value fifo_sink_@tile.name {fifoOutputInterfaceOptions} {AVALONMM_READ}
	set_instance_parameter_value fifo_sink_@tile.name {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_sink_@tile.name {singleClockMode} {1}
	set_instance_parameter_value fifo_sink_@tile.name {singleResetMode} {0}
	set_instance_parameter_value fifo_sink_@tile.name {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_sink_@tile.name {useBackpressure} {1}
	set_instance_parameter_value fifo_sink_@tile.name {useIRQ} {1}
	set_instance_parameter_value fifo_sink_@tile.name {usePacket} {0}
	set_instance_parameter_value fifo_sink_@tile.name {useReadControl} {0}
	set_instance_parameter_value fifo_sink_@tile.name {useRegister} {0}
	set_instance_parameter_value fifo_sink_@tile.name {useWriteControl} {1}

	#end


	#for @tile in @tiles:

	add_instance fifo_source_@tile.name altera_avalon_fifo 17.1
	set_instance_parameter_value fifo_source_@tile.name {avalonMMAvalonMMDataWidth} {32}
	set_instance_parameter_value fifo_source_@tile.name {avalonMMAvalonSTDataWidth} {32}
	set_instance_parameter_value fifo_source_@tile.name {bitsPerSymbol} {8}
	set_instance_parameter_value fifo_source_@tile.name {channelWidth} {8}
	set_instance_parameter_value fifo_source_@tile.name {errorWidth} {8}
	set_instance_parameter_value fifo_source_@tile.name {fifoDepth} {@tile.fifo_in_depth}
	set_instance_parameter_value fifo_source_@tile.name {fifoInputInterfaceOptions} {AVALONMM_WRITE}
	set_instance_parameter_value fifo_source_@tile.name {fifoOutputInterfaceOptions} {AVALONST_SOURCE}
	set_instance_parameter_value fifo_source_@tile.name {showHiddenFeatures} {0}
	set_instance_parameter_value fifo_source_@tile.name {singleClockMode} {1}
	set_instance_parameter_value fifo_source_@tile.name {singleResetMode} {0}
	set_instance_parameter_value fifo_source_@tile.name {symbolsPerBeat} {4}
	set_instance_parameter_value fifo_source_@tile.name {useBackpressure} {1}
	set_instance_parameter_value fifo_source_@tile.name {useIRQ} {1}
	set_instance_parameter_value fifo_source_@tile.name {usePacket} {0}
	set_instance_parameter_value fifo_source_@tile.name {useReadControl} {0}
	set_instance_parameter_value fifo_source_@tile.name {useRegister} {0}
	set_instance_parameter_value fifo_source_@tile.name {useWriteControl} {1}

	#end

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

	## must be completed......................
	## I have to compare both the economy and fast properties
	## write an if statement to determine whether the NIOS is fast or economy

	#for @tile in @tiles:


	add_instance nios2_@tile.name altera_nios2_gen2 17.1
	set_instance_parameter_value nios2_@tile.name {bht_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {breakOffset} {32}
	set_instance_parameter_value nios2_@tile.name {breakSlave} {None}
	set_instance_parameter_value nios2_@tile.name {cdx_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {cpuArchRev} {1}
	set_instance_parameter_value nios2_@tile.name {cpuID} {0}
	set_instance_parameter_value nios2_@tile.name {cpuReset} {0}
	set_instance_parameter_value nios2_@tile.name {data_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {data_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {data_master_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {data_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {dcache_bursts} {false}
	set_instance_parameter_value nios2_@tile.name {dcache_numTCDM} {0}
	set_instance_parameter_value nios2_@tile.name {dcache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {dcache_size} {2048}
	set_instance_parameter_value nios2_@tile.name {dcache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {dcache_victim_buf_impl} {ram}
	set_instance_parameter_value nios2_@tile.name {debug_OCIOnchipTrace} {_128}
	set_instance_parameter_value nios2_@tile.name {debug_assignJtagInstanceID} {0}
	set_instance_parameter_value nios2_@tile.name {debug_datatrigger} {0}
	set_instance_parameter_value nios2_@tile.name {debug_debugReqSignals} {0}
	set_instance_parameter_value nios2_@tile.name {debug_enabled} {1}
	set_instance_parameter_value nios2_@tile.name {debug_hwbreakpoint} {0}
	set_instance_parameter_value nios2_@tile.name {debug_jtagInstanceID} {0}
	set_instance_parameter_value nios2_@tile.name {debug_traceStorage} {onchip_trace}
	set_instance_parameter_value nios2_@tile.name {debug_traceType} {none}
	set_instance_parameter_value nios2_@tile.name {debug_triggerArming} {1}
	set_instance_parameter_value nios2_@tile.name {dividerType} {no_div}
	set_instance_parameter_value nios2_@tile.name {exceptionOffset} {32}
	set_instance_parameter_value nios2_@tile.name {exceptionSlave} {data_mem_@{tile.name}.s1}
	set_instance_parameter_value nios2_@tile.name {fa_cache_line} {2}
	set_instance_parameter_value nios2_@tile.name {fa_cache_linesize} {0}
	set_instance_parameter_value nios2_@tile.name {flash_instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {flash_instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {icache_burstType} {None}
	set_instance_parameter_value nios2_@tile.name {icache_numTCIM} {0}
	set_instance_parameter_value nios2_@tile.name {icache_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {icache_size} {4096}
	set_instance_parameter_value nios2_@tile.name {icache_tagramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {impl} {Tiny}
	set_instance_parameter_value nios2_@tile.name {instruction_master_high_performance_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {instruction_master_high_performance_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {instruction_master_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {instruction_master_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {io_regionbase} {0}
	set_instance_parameter_value nios2_@tile.name {io_regionsize} {0}
	set_instance_parameter_value nios2_@tile.name {master_addr_map} {0}
	set_instance_parameter_value nios2_@tile.name {mmu_TLBMissExcOffset} {0}
	set_instance_parameter_value nios2_@tile.name {mmu_TLBMissExcSlave} {None}
	set_instance_parameter_value nios2_@tile.name {mmu_autoAssignTlbPtrSz} {1}
	set_instance_parameter_value nios2_@tile.name {mmu_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {mmu_processIDNumBits} {8}
	set_instance_parameter_value nios2_@tile.name {mmu_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {mmu_tlbNumWays} {16}
	set_instance_parameter_value nios2_@tile.name {mmu_tlbPtrSz} {7}
	set_instance_parameter_value nios2_@tile.name {mmu_udtlbNumEntries} {6}
	set_instance_parameter_value nios2_@tile.name {mmu_uitlbNumEntries} {4}
	set_instance_parameter_value nios2_@tile.name {mpu_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {mpu_minDataRegionSize} {12}
	set_instance_parameter_value nios2_@tile.name {mpu_minInstRegionSize} {12}
	set_instance_parameter_value nios2_@tile.name {mpu_numOfDataRegion} {8}
	set_instance_parameter_value nios2_@tile.name {mpu_numOfInstRegion} {8}
	set_instance_parameter_value nios2_@tile.name {mpu_useLimit} {0}
	set_instance_parameter_value nios2_@tile.name {mpx_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {mul_32_impl} {2}
	set_instance_parameter_value nios2_@tile.name {mul_64_impl} {0}
	set_instance_parameter_value nios2_@tile.name {mul_shift_choice} {0}
	set_instance_parameter_value nios2_@tile.name {ocimem_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {ocimem_ramInit} {0}
	set_instance_parameter_value nios2_@tile.name {regfile_ramBlockType} {Automatic}
	set_instance_parameter_value nios2_@tile.name {register_file_por} {0}
	set_instance_parameter_value nios2_@tile.name {resetOffset} {0}
	set_instance_parameter_value nios2_@tile.name {resetSlave} {data_mem_@{tile.name}.s1}
	set_instance_parameter_value nios2_@tile.name {resetrequest_enabled} {1}
	set_instance_parameter_value nios2_@tile.name {setting_HBreakTest} {0}
	set_instance_parameter_value nios2_@tile.name {setting_HDLSimCachesCleared} {1}
	set_instance_parameter_value nios2_@tile.name {setting_activateMonitors} {1}
	set_instance_parameter_value nios2_@tile.name {setting_activateTestEndChecker} {0}
	set_instance_parameter_value nios2_@tile.name {setting_activateTrace} {0}
	set_instance_parameter_value nios2_@tile.name {setting_allow_break_inst} {0}
	set_instance_parameter_value nios2_@tile.name {setting_alwaysEncrypt} {1}
	set_instance_parameter_value nios2_@tile.name {setting_asic_add_scan_mode_input} {0}
	set_instance_parameter_value nios2_@tile.name {setting_asic_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {setting_asic_synopsys_translate_on_off} {0}
	set_instance_parameter_value nios2_@tile.name {setting_asic_third_party_synthesis} {0}
	set_instance_parameter_value nios2_@tile.name {setting_avalonDebugPortPresent} {0}
	set_instance_parameter_value nios2_@tile.name {setting_bhtPtrSz} {8}
	set_instance_parameter_value nios2_@tile.name {setting_bigEndian} {0}
	set_instance_parameter_value nios2_@tile.name {setting_branchpredictiontype} {Dynamic}
	set_instance_parameter_value nios2_@tile.name {setting_breakslaveoveride} {0}
	set_instance_parameter_value nios2_@tile.name {setting_clearXBitsLDNonBypass} {1}
	set_instance_parameter_value nios2_@tile.name {setting_dc_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_disable_tmr_inj} {0}
	set_instance_parameter_value nios2_@tile.name {setting_disableocitrace} {0}
	set_instance_parameter_value nios2_@tile.name {setting_dtcm_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_ecc_present} {0}
	set_instance_parameter_value nios2_@tile.name {setting_ecc_sim_test_ports} {0}
	set_instance_parameter_value nios2_@tile.name {setting_exportHostDebugPort} {0}
	set_instance_parameter_value nios2_@tile.name {setting_exportPCB} {0}
	set_instance_parameter_value nios2_@tile.name {setting_export_large_RAMs} {0}
	set_instance_parameter_value nios2_@tile.name {setting_exportdebuginfo} {0}
	set_instance_parameter_value nios2_@tile.name {setting_exportvectors} {0}
	set_instance_parameter_value nios2_@tile.name {setting_fast_register_read} {0}
	set_instance_parameter_value nios2_@tile.name {setting_ic_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_interruptControllerType} {Internal}
	set_instance_parameter_value nios2_@tile.name {setting_itcm_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_mmu_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_oci_export_jtag_signals} {0}
	set_instance_parameter_value nios2_@tile.name {setting_oci_version} {1}
	set_instance_parameter_value nios2_@tile.name {setting_preciseIllegalMemAccessException} {0}
	set_instance_parameter_value nios2_@tile.name {setting_removeRAMinit} {0}
	set_instance_parameter_value nios2_@tile.name {setting_rf_ecc_present} {1}
	set_instance_parameter_value nios2_@tile.name {setting_shadowRegisterSets} {0}
	set_instance_parameter_value nios2_@tile.name {setting_showInternalSettings} {0}
	set_instance_parameter_value nios2_@tile.name {setting_showUnpublishedSettings} {0}
	set_instance_parameter_value nios2_@tile.name {setting_support31bitdcachebypass} {1}
	set_instance_parameter_value nios2_@tile.name {setting_tmr_output_disable} {0}
	set_instance_parameter_value nios2_@tile.name {setting_usedesignware} {0}
	set_instance_parameter_value nios2_@tile.name {shift_rot_impl} {1}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_data_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_0_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_0_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_1_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_1_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_2_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_2_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_3_paddr_base} {0}
	set_instance_parameter_value nios2_@tile.name {tightly_coupled_instruction_master_3_paddr_size} {0.0}
	set_instance_parameter_value nios2_@tile.name {tmr_enabled} {0}
	set_instance_parameter_value nios2_@tile.name {tracefilename} {}
	set_instance_parameter_value nios2_@tile.name {userDefinedSettings} {}

	#end

	

# Connections
# -----------
	#for @tile in @tiles:
	add_connection NoC.source_@tile.name fifo_sink_@{tile.name}.in avalon_streaming
	#end

	add_connection clk_0.clk NoC.clock clock

	#for @tile in @tiles:
	add_connection clk_0.clk data_mem_@{tile.name}.clk1 clock
	#end

	#for @tile in @tiles:
	add_connection clk_0.clk fifo_sink_@{tile.name}.clk_in clock
	#end
	
	#for @tile in @tiles:
	add_connection clk_0.clk fifo_source_@{tile.name}.clk_in clock
	#end

	add_connection clk_0.clk jtag_uart_0.clk clock

	#for @tile in @tiles:
	add_connection clk_0.clk nios2_@{tile.name}.clk clock
	#end

	add_connection clk_0.clk_reset NoC.reset reset

	#for @tile in @tiles:
	add_connection clk_0.clk_reset data_mem_@{tile.name}.reset1 reset
	#end

	#for @tile in @tiles:
	add_connection clk_0.clk_reset fifo_sink_@{tile.name}.reset_in reset
	#end

	#for @tile in @tiles:
	add_connection clk_0.clk_reset fifo_source_@{tile.name}.reset_in reset
	#end

	add_connection clk_0.clk_reset jtag_uart_0.reset reset

	#for @tile in @tiles:
	add_connection clk_0.clk_reset nios2_@{tile.name}.reset reset
	#end

	#for @tile in @tiles:
	add_connection fifo_source_@{tile.name}.out NoC.sink_@{tile.name} avalon_streaming
	#end
	

	#for @tile in @tiles:
	add_connection nios2_@{tile.name}.data_master data_mem_@{tile.name}.s1 avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/data_mem_@{tile.name}.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/data_mem_@{tile.name}.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_@{tile.name}.data_master/data_mem_@{tile.name}.s1 defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master fifo_sink_@{tile.name}.in_csr avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.in_csr baseAddress {0x9020}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.in_csr defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master fifo_sink_@{tile.name}.out avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.out arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.out baseAddress {0x9040}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_sink_@{tile.name}.out defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master fifo_source_@{tile.name}.in avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in baseAddress {0x9048}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master fifo_source_@{tile.name}.in_csr avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in_csr arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in_csr baseAddress {0x9000}
	set_connection_parameter_value nios2_@{tile.name}.data_master/fifo_source_@{tile.name}.in_csr defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master jtag_uart_0.avalon_jtag_slave avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	set_connection_parameter_value nios2_@{tile.name}.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	add_connection nios2_@{tile.name}.data_master nios2_@{tile.name}.debug_mem_slave avalon
	set_connection_parameter_value nios2_@{tile.name}.data_master/nios2_@{tile.name}.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.data_master/nios2_@{tile.name}.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_@{tile.name}.data_master/nios2_@{tile.name}.debug_mem_slave defaultConnection {0}

	add_connection nios2_@{tile.name}.debug_reset_request clk_0.clk_in_reset reset

	add_connection nios2_@{tile.name}.instruction_master data_mem_@{tile.name}.s1 avalon
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/data_mem_@{tile.name}.s1 arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/data_mem_@{tile.name}.s1 baseAddress {0x4000}
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/data_mem_@{tile.name}.s1 defaultConnection {0}

	add_connection nios2_@{tile.name}.instruction_master nios2_@{tile.name}.debug_mem_slave avalon
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/nios2_@{tile.name}.debug_mem_slave arbitrationPriority {1}
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/nios2_@{tile.name}.debug_mem_slave baseAddress {0x8800}
	set_connection_parameter_value nios2_@{tile.name}.instruction_master/nios2_@{tile.name}.debug_mem_slave defaultConnection {0}

	add_connection nios2_@{tile.name}.irq fifo_sink_@{tile.name}.in_irq interrupt
	set_connection_parameter_value nios2_@{tile.name}.irq/fifo_sink_@{tile.name}.in_irq irqNumber {0}

	add_connection nios2_@{tile.name}.irq fifo_source_@{tile.name}.in_irq interrupt
	set_connection_parameter_value nios2_@{tile.name}.irq/fifo_source_@{tile.name}.in_irq irqNumber {1}

	add_connection nios2_@{tile.name}.irq jtag_uart_0.irq interrupt
	set_connection_parameter_value nios2_@{tile.name}.irq/jtag_uart_0.irq irqNumber {2}

	#end

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


	# add_connection NoC.source_00 fifo_sink_00.in avalon_streaming

	# add_connection NoC.source_01 fifo_sink_01.in avalon_streaming

	# add_connection NoC.source_10 fifo_sink_10.in avalon_streaming

	# add_connection NoC.source_11 fifo_sink_11.in avalon_streaming

	# add_connection clk_0.clk data_mem_00.clk1 clock

	# add_connection clk_0.clk data_mem_01.clk1 clock

	# add_connection clk_0.clk data_mem_10.clk1 clock

	# add_connection clk_0.clk data_mem_11.clk1 clock

	# add_connection clk_0.clk fifo_sink_00.clk_in clock

	# add_connection clk_0.clk fifo_sink_01.clk_in clock

	# add_connection clk_0.clk fifo_sink_10.clk_in clock

	# add_connection clk_0.clk fifo_sink_11.clk_in clock

	# add_connection clk_0.clk fifo_source_00.clk_in clock

	# add_connection clk_0.clk fifo_source_01.clk_in clock

	# add_connection clk_0.clk fifo_source_10.clk_in clock

	# add_connection clk_0.clk fifo_source_11.clk_in clock

	# add_connection clk_0.clk nios2_00.clk clock

	# add_connection clk_0.clk nios2_01.clk clock

	# add_connection clk_0.clk nios2_10.clk clock

	# add_connection clk_0.clk nios2_11.clk clock

	

	# add_connection clk_0.clk_reset data_mem_00.reset1 reset

	# add_connection clk_0.clk_reset data_mem_01.reset1 reset

	# add_connection clk_0.clk_reset data_mem_10.reset1 reset

	# add_connection clk_0.clk_reset data_mem_11.reset1 reset

	# add_connection clk_0.clk_reset fifo_sink_00.reset_in reset

	# add_connection clk_0.clk_reset fifo_sink_01.reset_in reset

	# add_connection clk_0.clk_reset fifo_sink_10.reset_in reset

	# add_connection clk_0.clk_reset fifo_sink_11.reset_in reset

	# add_connection clk_0.clk_reset fifo_source_00.reset_in reset

	# add_connection clk_0.clk_reset fifo_source_01.reset_in reset

	# add_connection clk_0.clk_reset fifo_source_10.reset_in reset

	# add_connection clk_0.clk_reset fifo_source_11.reset_in reset

	# add_connection clk_0.clk_reset nios2_00.reset reset

	# add_connection clk_0.clk_reset nios2_01.reset reset

	# add_connection clk_0.clk_reset nios2_10.reset reset

	# add_connection clk_0.clk_reset nios2_11.reset reset

	# add_connection fifo_source_00.out NoC.sink_00 avalon_streaming

	# add_connection fifo_source_01.out NoC.sink_01 avalon_streaming

	# add_connection fifo_source_10.out NoC.sink_10 avalon_streaming

	# add_connection fifo_source_11.out NoC.sink_11 avalon_streaming

	# add_connection nios2_00.data_master data_mem_00.s1 avalon
	# set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_00.data_master/data_mem_00.s1 defaultConnection {0}

	# add_connection nios2_00.data_master fifo_sink_00.in_csr avalon
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr baseAddress {0x9020}
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.in_csr defaultConnection {0}

	# add_connection nios2_00.data_master fifo_sink_00.out avalon
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out baseAddress {0x9040}
	# set_connection_parameter_value nios2_00.data_master/fifo_sink_00.out defaultConnection {0}

	# add_connection nios2_00.data_master fifo_source_00.in avalon
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in baseAddress {0x9048}
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in defaultConnection {0}

	# add_connection nios2_00.data_master fifo_source_00.in_csr avalon
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr baseAddress {0x9000}
	# set_connection_parameter_value nios2_00.data_master/fifo_source_00.in_csr defaultConnection {0}

	# add_connection nios2_00.data_master jtag_uart_0.avalon_jtag_slave avalon
	# set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	# set_connection_parameter_value nios2_00.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	# add_connection nios2_00.data_master nios2_00.debug_mem_slave avalon
	# set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_00.data_master/nios2_00.debug_mem_slave defaultConnection {0}

	# add_connection nios2_00.debug_reset_request clk_0.clk_in_reset reset

	# add_connection nios2_00.instruction_master data_mem_00.s1 avalon
	# set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_00.instruction_master/data_mem_00.s1 defaultConnection {0}

	# add_connection nios2_00.instruction_master nios2_00.debug_mem_slave avalon
	# set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_00.instruction_master/nios2_00.debug_mem_slave defaultConnection {0}

	# add_connection nios2_00.irq fifo_sink_00.in_irq interrupt
	# set_connection_parameter_value nios2_00.irq/fifo_sink_00.in_irq irqNumber {0}

	# add_connection nios2_00.irq fifo_source_00.in_irq interrupt
	# set_connection_parameter_value nios2_00.irq/fifo_source_00.in_irq irqNumber {1}

	# add_connection nios2_00.irq jtag_uart_0.irq interrupt
	# set_connection_parameter_value nios2_00.irq/jtag_uart_0.irq irqNumber {2}

	# add_connection nios2_01.data_master data_mem_01.s1 avalon
	# set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_01.data_master/data_mem_01.s1 defaultConnection {0}

	# add_connection nios2_01.data_master fifo_sink_01.in_csr avalon
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr baseAddress {0x9020}
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.in_csr defaultConnection {0}

	# add_connection nios2_01.data_master fifo_sink_01.out avalon
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out baseAddress {0x9040}
	# set_connection_parameter_value nios2_01.data_master/fifo_sink_01.out defaultConnection {0}

	# add_connection nios2_01.data_master fifo_source_01.in avalon
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in baseAddress {0x9048}
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in defaultConnection {0}

	# add_connection nios2_01.data_master fifo_source_01.in_csr avalon
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr baseAddress {0x9000}
	# set_connection_parameter_value nios2_01.data_master/fifo_source_01.in_csr defaultConnection {0}

	# add_connection nios2_01.data_master jtag_uart_0.avalon_jtag_slave avalon
	# set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	# set_connection_parameter_value nios2_01.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	# add_connection nios2_01.data_master nios2_01.debug_mem_slave avalon
	# set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_01.data_master/nios2_01.debug_mem_slave defaultConnection {0}

	# add_connection nios2_01.debug_reset_request clk_0.clk_in_reset reset

	# add_connection nios2_01.instruction_master data_mem_01.s1 avalon
	# set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_01.instruction_master/data_mem_01.s1 defaultConnection {0}

	# add_connection nios2_01.instruction_master nios2_01.debug_mem_slave avalon
	# set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_01.instruction_master/nios2_01.debug_mem_slave defaultConnection {0}

	# add_connection nios2_01.irq fifo_sink_01.in_irq interrupt
	# set_connection_parameter_value nios2_01.irq/fifo_sink_01.in_irq irqNumber {0}

	# add_connection nios2_01.irq fifo_source_01.in_irq interrupt
	# set_connection_parameter_value nios2_01.irq/fifo_source_01.in_irq irqNumber {1}

	# add_connection nios2_01.irq jtag_uart_0.irq interrupt
	# set_connection_parameter_value nios2_01.irq/jtag_uart_0.irq irqNumber {2}

	# add_connection nios2_10.data_master data_mem_10.s1 avalon
	# set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_10.data_master/data_mem_10.s1 defaultConnection {0}

	# add_connection nios2_10.data_master fifo_sink_10.in_csr avalon
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr baseAddress {0x9020}
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.in_csr defaultConnection {0}

	# add_connection nios2_10.data_master fifo_sink_10.out avalon
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out baseAddress {0x9040}
	# set_connection_parameter_value nios2_10.data_master/fifo_sink_10.out defaultConnection {0}

	# add_connection nios2_10.data_master fifo_source_10.in avalon
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in baseAddress {0x9048}
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in defaultConnection {0}

	# add_connection nios2_10.data_master fifo_source_10.in_csr avalon
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr baseAddress {0x9000}
	# set_connection_parameter_value nios2_10.data_master/fifo_source_10.in_csr defaultConnection {0}

	# add_connection nios2_10.data_master jtag_uart_0.avalon_jtag_slave avalon
	# set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	# set_connection_parameter_value nios2_10.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	# add_connection nios2_10.data_master nios2_10.debug_mem_slave avalon
	# set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_10.data_master/nios2_10.debug_mem_slave defaultConnection {0}

	# add_connection nios2_10.debug_reset_request clk_0.clk_in_reset reset

	# add_connection nios2_10.instruction_master data_mem_10.s1 avalon
	# set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_10.instruction_master/data_mem_10.s1 defaultConnection {0}

	# add_connection nios2_10.instruction_master nios2_10.debug_mem_slave avalon
	# set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_10.instruction_master/nios2_10.debug_mem_slave defaultConnection {0}

	# add_connection nios2_10.irq fifo_sink_10.in_irq interrupt
	# set_connection_parameter_value nios2_10.irq/fifo_sink_10.in_irq irqNumber {0}

	# add_connection nios2_10.irq fifo_source_10.in_irq interrupt
	# set_connection_parameter_value nios2_10.irq/fifo_source_10.in_irq irqNumber {1}

	# add_connection nios2_10.irq jtag_uart_0.irq interrupt
	# set_connection_parameter_value nios2_10.irq/jtag_uart_0.irq irqNumber {2}

	# add_connection nios2_11.data_master data_mem_11.s1 avalon
	# set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_11.data_master/data_mem_11.s1 defaultConnection {0}

	# add_connection nios2_11.data_master fifo_sink_11.in_csr avalon
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr baseAddress {0x9020}
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.in_csr defaultConnection {0}

	# add_connection nios2_11.data_master fifo_sink_11.out avalon
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out baseAddress {0x9040}
	# set_connection_parameter_value nios2_11.data_master/fifo_sink_11.out defaultConnection {0}

	# add_connection nios2_11.data_master fifo_source_11.in avalon
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in baseAddress {0x9048}
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in defaultConnection {0}

	# add_connection nios2_11.data_master fifo_source_11.in_csr avalon
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr baseAddress {0x9000}
	# set_connection_parameter_value nios2_11.data_master/fifo_source_11.in_csr defaultConnection {0}

	# add_connection nios2_11.data_master jtag_uart_0.avalon_jtag_slave avalon
	# set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave baseAddress {0x9050}
	# set_connection_parameter_value nios2_11.data_master/jtag_uart_0.avalon_jtag_slave defaultConnection {0}

	# add_connection nios2_11.data_master nios2_11.debug_mem_slave avalon
	# set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_11.data_master/nios2_11.debug_mem_slave defaultConnection {0}

	# add_connection nios2_11.debug_reset_request clk_0.clk_in_reset reset

	# add_connection nios2_11.instruction_master data_mem_11.s1 avalon
	# set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 baseAddress {0x4000}
	# set_connection_parameter_value nios2_11.instruction_master/data_mem_11.s1 defaultConnection {0}

	# add_connection nios2_11.instruction_master nios2_11.debug_mem_slave avalon
	# set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave arbitrationPriority {1}
	# set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave baseAddress {0x8800}
	# set_connection_parameter_value nios2_11.instruction_master/nios2_11.debug_mem_slave defaultConnection {0}

	# add_connection nios2_11.irq fifo_sink_11.in_irq interrupt
	# set_connection_parameter_value nios2_11.irq/fifo_sink_11.in_irq irqNumber {0}

	# add_connection nios2_11.irq fifo_source_11.in_irq interrupt
	# set_connection_parameter_value nios2_11.irq/fifo_source_11.in_irq irqNumber {1}

	# add_connection nios2_11.irq jtag_uart_0.irq interrupt
	# set_connection_parameter_value nios2_11.irq/jtag_uart_0.irq irqNumber {2}


