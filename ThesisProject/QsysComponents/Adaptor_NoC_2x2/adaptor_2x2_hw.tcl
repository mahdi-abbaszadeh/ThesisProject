# TCL File Generated by Component Editor 17.1
# Sun Jul 21 09:50:58 IRDT 2019
# DO NOT MODIFY


# 
# adaptor_2x2 "adaptor_2x2" v1.0
#  2019.07.21.09:50:58
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module adaptor_2x2
# 
set_module_property DESCRIPTION ""
set_module_property NAME adaptor_2x2
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "My Own IP Cores"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME adaptor_2x2
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL adaptor
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file adaptor.v VERILOG PATH adaptor.v TOP_LEVEL_FILE
add_fileset_file ram_dp_ar_aw.v VERILOG PATH ram_dp_ar_aw.v
add_fileset_file syn_fifo.v VERILOG PATH syn_fifo.v
add_fileset_file Computation.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Computation.vhd"
add_fileset_file ConnectionPack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/ConnectionPack.vhd"
add_fileset_file FilePack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/FilePack.vhd"
add_fileset_file NOC.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/NOC.vhd"
add_fileset_file Node.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Node.vhd"
add_fileset_file RouterA.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/RouterA.vhd"

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL adaptor
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file adaptor.v VERILOG PATH adaptor.v
add_fileset_file ram_dp_ar_aw.v VERILOG PATH ram_dp_ar_aw.v
add_fileset_file syn_fifo.v VERILOG PATH syn_fifo.v
add_fileset_file Computation.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Computation.vhd"
add_fileset_file ConnectionPack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/ConnectionPack.vhd"
add_fileset_file FilePack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/FilePack.vhd"
add_fileset_file NOC.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/NOC.vhd"
add_fileset_file Node.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Node.vhd"
add_fileset_file RouterA.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/RouterA.vhd"


# 
# parameters
# 
add_parameter DataWidth INTEGER 8
set_parameter_property DataWidth DEFAULT_VALUE 8
set_parameter_property DataWidth DISPLAY_NAME DataWidth
set_parameter_property DataWidth TYPE INTEGER
set_parameter_property DataWidth UNITS None
set_parameter_property DataWidth HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clock clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink reset reset Input 1


# 
# connection point Input_00
# 
add_interface Input_00 avalon end
set_interface_property Input_00 addressUnits WORDS
set_interface_property Input_00 associatedClock clock_sink
set_interface_property Input_00 associatedReset reset_sink
set_interface_property Input_00 bitsPerSymbol 8
set_interface_property Input_00 burstOnBurstBoundariesOnly false
set_interface_property Input_00 burstcountUnits WORDS
set_interface_property Input_00 explicitAddressSpan 0
set_interface_property Input_00 holdTime 0
set_interface_property Input_00 linewrapBursts false
set_interface_property Input_00 maximumPendingReadTransactions 0
set_interface_property Input_00 maximumPendingWriteTransactions 0
set_interface_property Input_00 readLatency 0
set_interface_property Input_00 readWaitStates 0
set_interface_property Input_00 readWaitTime 0
set_interface_property Input_00 setupTime 0
set_interface_property Input_00 timingUnits Cycles
set_interface_property Input_00 writeWaitTime 0
set_interface_property Input_00 ENABLED true
set_interface_property Input_00 EXPORT_OF ""
set_interface_property Input_00 PORT_NAME_MAP ""
set_interface_property Input_00 CMSIS_SVD_VARIABLES ""
set_interface_property Input_00 SVD_ADDRESS_GROUP ""

add_interface_port Input_00 reaData_00 readdata Output DataWidth
add_interface_port Input_00 read_00 read Input 1
set_interface_assignment Input_00 embeddedsw.configuration.isFlash 0
set_interface_assignment Input_00 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Input_00 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Input_00 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Input_01
# 
add_interface Input_01 avalon end
set_interface_property Input_01 addressUnits WORDS
set_interface_property Input_01 associatedClock clock_sink
set_interface_property Input_01 associatedReset reset_sink
set_interface_property Input_01 bitsPerSymbol 8
set_interface_property Input_01 burstOnBurstBoundariesOnly false
set_interface_property Input_01 burstcountUnits WORDS
set_interface_property Input_01 explicitAddressSpan 0
set_interface_property Input_01 holdTime 0
set_interface_property Input_01 linewrapBursts false
set_interface_property Input_01 maximumPendingReadTransactions 0
set_interface_property Input_01 maximumPendingWriteTransactions 0
set_interface_property Input_01 readLatency 0
set_interface_property Input_01 readWaitStates 0
set_interface_property Input_01 readWaitTime 0
set_interface_property Input_01 setupTime 0
set_interface_property Input_01 timingUnits Cycles
set_interface_property Input_01 writeWaitTime 0
set_interface_property Input_01 ENABLED true
set_interface_property Input_01 EXPORT_OF ""
set_interface_property Input_01 PORT_NAME_MAP ""
set_interface_property Input_01 CMSIS_SVD_VARIABLES ""
set_interface_property Input_01 SVD_ADDRESS_GROUP ""

add_interface_port Input_01 reaData_01 readdata Output DataWidth
add_interface_port Input_01 read_01 read Input 1
set_interface_assignment Input_01 embeddedsw.configuration.isFlash 0
set_interface_assignment Input_01 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Input_01 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Input_01 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Input_10
# 
add_interface Input_10 avalon end
set_interface_property Input_10 addressUnits WORDS
set_interface_property Input_10 associatedClock clock_sink
set_interface_property Input_10 associatedReset reset_sink
set_interface_property Input_10 bitsPerSymbol 8
set_interface_property Input_10 burstOnBurstBoundariesOnly false
set_interface_property Input_10 burstcountUnits WORDS
set_interface_property Input_10 explicitAddressSpan 0
set_interface_property Input_10 holdTime 0
set_interface_property Input_10 linewrapBursts false
set_interface_property Input_10 maximumPendingReadTransactions 0
set_interface_property Input_10 maximumPendingWriteTransactions 0
set_interface_property Input_10 readLatency 0
set_interface_property Input_10 readWaitStates 0
set_interface_property Input_10 readWaitTime 0
set_interface_property Input_10 setupTime 0
set_interface_property Input_10 timingUnits Cycles
set_interface_property Input_10 writeWaitTime 0
set_interface_property Input_10 ENABLED true
set_interface_property Input_10 EXPORT_OF ""
set_interface_property Input_10 PORT_NAME_MAP ""
set_interface_property Input_10 CMSIS_SVD_VARIABLES ""
set_interface_property Input_10 SVD_ADDRESS_GROUP ""

add_interface_port Input_10 read_10 read Input 1
add_interface_port Input_10 reaData_10 readdata Output DataWidth
set_interface_assignment Input_10 embeddedsw.configuration.isFlash 0
set_interface_assignment Input_10 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Input_10 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Input_10 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Input_11
# 
add_interface Input_11 avalon end
set_interface_property Input_11 addressUnits WORDS
set_interface_property Input_11 associatedClock clock_sink
set_interface_property Input_11 associatedReset reset_sink
set_interface_property Input_11 bitsPerSymbol 8
set_interface_property Input_11 burstOnBurstBoundariesOnly false
set_interface_property Input_11 burstcountUnits WORDS
set_interface_property Input_11 explicitAddressSpan 0
set_interface_property Input_11 holdTime 0
set_interface_property Input_11 linewrapBursts false
set_interface_property Input_11 maximumPendingReadTransactions 0
set_interface_property Input_11 maximumPendingWriteTransactions 0
set_interface_property Input_11 readLatency 0
set_interface_property Input_11 readWaitStates 0
set_interface_property Input_11 readWaitTime 0
set_interface_property Input_11 setupTime 0
set_interface_property Input_11 timingUnits Cycles
set_interface_property Input_11 writeWaitTime 0
set_interface_property Input_11 ENABLED true
set_interface_property Input_11 EXPORT_OF ""
set_interface_property Input_11 PORT_NAME_MAP ""
set_interface_property Input_11 CMSIS_SVD_VARIABLES ""
set_interface_property Input_11 SVD_ADDRESS_GROUP ""

add_interface_port Input_11 reaData_11 readdata Output DataWidth
add_interface_port Input_11 read_11 read Input 1
set_interface_assignment Input_11 embeddedsw.configuration.isFlash 0
set_interface_assignment Input_11 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Input_11 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Input_11 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Output_00
# 
add_interface Output_00 avalon end
set_interface_property Output_00 addressUnits WORDS
set_interface_property Output_00 associatedClock clock_sink
set_interface_property Output_00 associatedReset reset_sink
set_interface_property Output_00 bitsPerSymbol 8
set_interface_property Output_00 burstOnBurstBoundariesOnly false
set_interface_property Output_00 burstcountUnits WORDS
set_interface_property Output_00 explicitAddressSpan 0
set_interface_property Output_00 holdTime 0
set_interface_property Output_00 linewrapBursts false
set_interface_property Output_00 maximumPendingReadTransactions 0
set_interface_property Output_00 maximumPendingWriteTransactions 0
set_interface_property Output_00 readLatency 0
set_interface_property Output_00 readWaitStates 0
set_interface_property Output_00 readWaitTime 0
set_interface_property Output_00 setupTime 0
set_interface_property Output_00 timingUnits Cycles
set_interface_property Output_00 writeWaitTime 0
set_interface_property Output_00 ENABLED true
set_interface_property Output_00 EXPORT_OF ""
set_interface_property Output_00 PORT_NAME_MAP ""
set_interface_property Output_00 CMSIS_SVD_VARIABLES ""
set_interface_property Output_00 SVD_ADDRESS_GROUP ""

add_interface_port Output_00 writeData_00 writedata Input DataWidth
add_interface_port Output_00 write_00 write Input 1
add_interface_port Output_00 waiteRequest_00 waitrequest Output 1
set_interface_assignment Output_00 embeddedsw.configuration.isFlash 0
set_interface_assignment Output_00 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Output_00 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Output_00 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Output_01
# 
add_interface Output_01 avalon end
set_interface_property Output_01 addressUnits WORDS
set_interface_property Output_01 associatedClock clock_sink
set_interface_property Output_01 associatedReset reset_sink
set_interface_property Output_01 bitsPerSymbol 8
set_interface_property Output_01 burstOnBurstBoundariesOnly false
set_interface_property Output_01 burstcountUnits WORDS
set_interface_property Output_01 explicitAddressSpan 0
set_interface_property Output_01 holdTime 0
set_interface_property Output_01 linewrapBursts false
set_interface_property Output_01 maximumPendingReadTransactions 0
set_interface_property Output_01 maximumPendingWriteTransactions 0
set_interface_property Output_01 readLatency 0
set_interface_property Output_01 readWaitStates 0
set_interface_property Output_01 readWaitTime 0
set_interface_property Output_01 setupTime 0
set_interface_property Output_01 timingUnits Cycles
set_interface_property Output_01 writeWaitTime 0
set_interface_property Output_01 ENABLED true
set_interface_property Output_01 EXPORT_OF ""
set_interface_property Output_01 PORT_NAME_MAP ""
set_interface_property Output_01 CMSIS_SVD_VARIABLES ""
set_interface_property Output_01 SVD_ADDRESS_GROUP ""

add_interface_port Output_01 writeData_01 writedata Input DataWidth
add_interface_port Output_01 write_01 write Input 1
add_interface_port Output_01 waiteRequest_01 waitrequest Output 1
set_interface_assignment Output_01 embeddedsw.configuration.isFlash 0
set_interface_assignment Output_01 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Output_01 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Output_01 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Output_10
# 
add_interface Output_10 avalon end
set_interface_property Output_10 addressUnits WORDS
set_interface_property Output_10 associatedClock clock_sink
set_interface_property Output_10 associatedReset reset_sink
set_interface_property Output_10 bitsPerSymbol 8
set_interface_property Output_10 burstOnBurstBoundariesOnly false
set_interface_property Output_10 burstcountUnits WORDS
set_interface_property Output_10 explicitAddressSpan 0
set_interface_property Output_10 holdTime 0
set_interface_property Output_10 linewrapBursts false
set_interface_property Output_10 maximumPendingReadTransactions 0
set_interface_property Output_10 maximumPendingWriteTransactions 0
set_interface_property Output_10 readLatency 0
set_interface_property Output_10 readWaitStates 0
set_interface_property Output_10 readWaitTime 0
set_interface_property Output_10 setupTime 0
set_interface_property Output_10 timingUnits Cycles
set_interface_property Output_10 writeWaitTime 0
set_interface_property Output_10 ENABLED true
set_interface_property Output_10 EXPORT_OF ""
set_interface_property Output_10 PORT_NAME_MAP ""
set_interface_property Output_10 CMSIS_SVD_VARIABLES ""
set_interface_property Output_10 SVD_ADDRESS_GROUP ""

add_interface_port Output_10 writeData_10 writedata Input DataWidth
add_interface_port Output_10 write_10 write Input 1
add_interface_port Output_10 waiteRequest_10 waitrequest Output 1
set_interface_assignment Output_10 embeddedsw.configuration.isFlash 0
set_interface_assignment Output_10 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Output_10 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Output_10 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point Output_11
# 
add_interface Output_11 avalon end
set_interface_property Output_11 addressUnits WORDS
set_interface_property Output_11 associatedClock clock_sink
set_interface_property Output_11 associatedReset reset_sink
set_interface_property Output_11 bitsPerSymbol 8
set_interface_property Output_11 burstOnBurstBoundariesOnly false
set_interface_property Output_11 burstcountUnits WORDS
set_interface_property Output_11 explicitAddressSpan 0
set_interface_property Output_11 holdTime 0
set_interface_property Output_11 linewrapBursts false
set_interface_property Output_11 maximumPendingReadTransactions 0
set_interface_property Output_11 maximumPendingWriteTransactions 0
set_interface_property Output_11 readLatency 0
set_interface_property Output_11 readWaitStates 0
set_interface_property Output_11 readWaitTime 0
set_interface_property Output_11 setupTime 0
set_interface_property Output_11 timingUnits Cycles
set_interface_property Output_11 writeWaitTime 0
set_interface_property Output_11 ENABLED true
set_interface_property Output_11 EXPORT_OF ""
set_interface_property Output_11 PORT_NAME_MAP ""
set_interface_property Output_11 CMSIS_SVD_VARIABLES ""
set_interface_property Output_11 SVD_ADDRESS_GROUP ""

add_interface_port Output_11 writeData_11 writedata Input DataWidth
add_interface_port Output_11 write_11 write Input 1
add_interface_port Output_11 waiteRequest_11 waitrequest Output 1
set_interface_assignment Output_11 embeddedsw.configuration.isFlash 0
set_interface_assignment Output_11 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment Output_11 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment Output_11 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point interrupt_sender_00
# 
add_interface interrupt_sender_00 interrupt end
set_interface_property interrupt_sender_00 associatedAddressablePoint Input_00
set_interface_property interrupt_sender_00 associatedClock clock_sink
set_interface_property interrupt_sender_00 bridgedReceiverOffset ""
set_interface_property interrupt_sender_00 bridgesToReceiver ""
set_interface_property interrupt_sender_00 ENABLED true
set_interface_property interrupt_sender_00 EXPORT_OF ""
set_interface_property interrupt_sender_00 PORT_NAME_MAP ""
set_interface_property interrupt_sender_00 CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender_00 SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender_00 irq_00 irq Output 1


# 
# connection point interrupt_sender_01
# 
add_interface interrupt_sender_01 interrupt end
set_interface_property interrupt_sender_01 associatedAddressablePoint Input_01
set_interface_property interrupt_sender_01 associatedClock clock_sink
set_interface_property interrupt_sender_01 bridgedReceiverOffset ""
set_interface_property interrupt_sender_01 bridgesToReceiver ""
set_interface_property interrupt_sender_01 ENABLED true
set_interface_property interrupt_sender_01 EXPORT_OF ""
set_interface_property interrupt_sender_01 PORT_NAME_MAP ""
set_interface_property interrupt_sender_01 CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender_01 SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender_01 irq_01 irq Output 1


# 
# connection point interrupt_sender_10
# 
add_interface interrupt_sender_10 interrupt end
set_interface_property interrupt_sender_10 associatedAddressablePoint Input_10
set_interface_property interrupt_sender_10 associatedClock clock_sink
set_interface_property interrupt_sender_10 bridgedReceiverOffset ""
set_interface_property interrupt_sender_10 bridgesToReceiver ""
set_interface_property interrupt_sender_10 ENABLED true
set_interface_property interrupt_sender_10 EXPORT_OF ""
set_interface_property interrupt_sender_10 PORT_NAME_MAP ""
set_interface_property interrupt_sender_10 CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender_10 SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender_10 irq_10 irq Output 1


# 
# connection point interrupt_sender_11
# 
add_interface interrupt_sender_11 interrupt end
set_interface_property interrupt_sender_11 associatedAddressablePoint Output_11
set_interface_property interrupt_sender_11 associatedClock clock_sink
set_interface_property interrupt_sender_11 bridgedReceiverOffset ""
set_interface_property interrupt_sender_11 bridgesToReceiver ""
set_interface_property interrupt_sender_11 ENABLED true
set_interface_property interrupt_sender_11 EXPORT_OF ""
set_interface_property interrupt_sender_11 PORT_NAME_MAP ""
set_interface_property interrupt_sender_11 CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender_11 SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender_11 irq_11 irq Output 1
