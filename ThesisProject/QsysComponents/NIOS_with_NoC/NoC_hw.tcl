# TCL File Generated by Component Editor 17.1
# Sun Jul 28 10:56:31 IRDT 2019
# DO NOT MODIFY


# 
# NoC "NoC" v1.0
#  2019.07.28.10:56:31
#  
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module NoC
# 
set_module_property DESCRIPTION ""
set_module_property NAME NoC
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "My Own IP Cores"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME NoC
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL wrapper
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file wrapper.v VERILOG PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/wrapper.v" TOP_LEVEL_FILE
add_fileset_file Computation.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Computation.vhd"
add_fileset_file ConnectionPack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/ConnectionPack.vhd"
add_fileset_file FilePack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/FilePack.vhd"
add_fileset_file NOC.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/NOC.vhd"
add_fileset_file Node.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Node.vhd"
add_fileset_file RouterA.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/RouterA.vhd"

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL wrapper
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file wrapper.v VERILOG PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/wrapper.v"
add_fileset_file Computation.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Computation.vhd"
add_fileset_file ConnectionPack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/ConnectionPack.vhd"
add_fileset_file FilePack.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/FilePack.vhd"
add_fileset_file NOC.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/NOC.vhd"
add_fileset_file Node.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/Node.vhd"
add_fileset_file RouterA.vhd VHDL PATH "../../NoC/Persian.NoC/VHDL-proj/MeshMxN-Det - Manual/RouterA.vhd"


# 
# parameters
# 
add_parameter PackWidth INTEGER 8
set_parameter_property PackWidth DEFAULT_VALUE 8
set_parameter_property PackWidth DISPLAY_NAME PackWidth
set_parameter_property PackWidth TYPE INTEGER
set_parameter_property PackWidth UNITS None
set_parameter_property PackWidth HDL_PARAMETER true
add_parameter DataWidth INTEGER 8
set_parameter_property DataWidth DEFAULT_VALUE 8
set_parameter_property DataWidth DISPLAY_NAME DataWidth
set_parameter_property DataWidth TYPE INTEGER
set_parameter_property DataWidth UNITS None
set_parameter_property DataWidth HDL_PARAMETER true
add_parameter AddrWidth INTEGER 2
set_parameter_property AddrWidth DEFAULT_VALUE 2
set_parameter_property AddrWidth DISPLAY_NAME AddrWidth
set_parameter_property AddrWidth TYPE INTEGER
set_parameter_property AddrWidth UNITS None
set_parameter_property AddrWidth HDL_PARAMETER true
add_parameter RoChAddr INTEGER 1
set_parameter_property RoChAddr DEFAULT_VALUE 1
set_parameter_property RoChAddr DISPLAY_NAME RoChAddr
set_parameter_property RoChAddr TYPE INTEGER
set_parameter_property RoChAddr UNITS None
set_parameter_property RoChAddr HDL_PARAMETER true
add_parameter PhyChAddr INTEGER 2
set_parameter_property PhyChAddr DEFAULT_VALUE 2
set_parameter_property PhyChAddr DISPLAY_NAME PhyChAddr
set_parameter_property PhyChAddr TYPE INTEGER
set_parameter_property PhyChAddr UNITS None
set_parameter_property PhyChAddr HDL_PARAMETER true
add_parameter ViChAddr INTEGER 1
set_parameter_property ViChAddr DEFAULT_VALUE 1
set_parameter_property ViChAddr DISPLAY_NAME ViChAddr
set_parameter_property ViChAddr TYPE INTEGER
set_parameter_property ViChAddr UNITS None
set_parameter_property ViChAddr HDL_PARAMETER true
add_parameter PhyRoChAddr INTEGER 3
set_parameter_property PhyRoChAddr DEFAULT_VALUE 3
set_parameter_property PhyRoChAddr DISPLAY_NAME PhyRoChAddr
set_parameter_property PhyRoChAddr TYPE INTEGER
set_parameter_property PhyRoChAddr UNITS None
set_parameter_property PhyRoChAddr HDL_PARAMETER true
add_parameter RoCh INTEGER 1
set_parameter_property RoCh DEFAULT_VALUE 1
set_parameter_property RoCh DISPLAY_NAME RoCh
set_parameter_property RoCh TYPE INTEGER
set_parameter_property RoCh UNITS None
set_parameter_property RoCh HDL_PARAMETER true
add_parameter PhyCh INTEGER 4
set_parameter_property PhyCh DEFAULT_VALUE 4
set_parameter_property PhyCh DISPLAY_NAME PhyCh
set_parameter_property PhyCh TYPE INTEGER
set_parameter_property PhyCh UNITS None
set_parameter_property PhyCh HDL_PARAMETER true
add_parameter ViCh INTEGER 1
set_parameter_property ViCh DEFAULT_VALUE 1
set_parameter_property ViCh DISPLAY_NAME ViCh
set_parameter_property ViCh TYPE INTEGER
set_parameter_property ViCh UNITS None
set_parameter_property ViCh HDL_PARAMETER true
add_parameter PhyRoCh INTEGER 5
set_parameter_property PhyRoCh DEFAULT_VALUE 5
set_parameter_property PhyRoCh DISPLAY_NAME PhyRoCh
set_parameter_property PhyRoCh TYPE INTEGER
set_parameter_property PhyRoCh UNITS None
set_parameter_property PhyRoCh HDL_PARAMETER true


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point sink_00
# 
add_interface sink_00 avalon_streaming end
set_interface_property sink_00 associatedClock clock
set_interface_property sink_00 associatedReset reset
set_interface_property sink_00 dataBitsPerSymbol 8
set_interface_property sink_00 errorDescriptor ""
set_interface_property sink_00 firstSymbolInHighOrderBits true
set_interface_property sink_00 maxChannel 0
set_interface_property sink_00 readyLatency 0
set_interface_property sink_00 ENABLED true
set_interface_property sink_00 EXPORT_OF ""
set_interface_property sink_00 PORT_NAME_MAP ""
set_interface_property sink_00 CMSIS_SVD_VARIABLES ""
set_interface_property sink_00 SVD_ADDRESS_GROUP ""

add_interface_port sink_00 PE00_OutpData data Input DataWidth
add_interface_port sink_00 PE00_OutpEn valid Input 1
add_interface_port sink_00 PE00_OutpReady ready Output 1
add_interface_port sink_00 PE00_OutpSel channel Input 1


# 
# connection point sink_01
# 
add_interface sink_01 avalon_streaming end
set_interface_property sink_01 associatedClock clock
set_interface_property sink_01 associatedReset reset
set_interface_property sink_01 dataBitsPerSymbol 8
set_interface_property sink_01 errorDescriptor ""
set_interface_property sink_01 firstSymbolInHighOrderBits true
set_interface_property sink_01 maxChannel 0
set_interface_property sink_01 readyLatency 0
set_interface_property sink_01 ENABLED true
set_interface_property sink_01 EXPORT_OF ""
set_interface_property sink_01 PORT_NAME_MAP ""
set_interface_property sink_01 CMSIS_SVD_VARIABLES ""
set_interface_property sink_01 SVD_ADDRESS_GROUP ""

add_interface_port sink_01 PE01_OutpData data Input DataWidth
add_interface_port sink_01 PE01_OutpEn valid Input 1
add_interface_port sink_01 PE01_OutpReady ready Output 1
add_interface_port sink_01 PE01_OutpSel channel Input ViChAddr


# 
# connection point sink_10
# 
add_interface sink_10 avalon_streaming end
set_interface_property sink_10 associatedClock clock
set_interface_property sink_10 associatedReset reset
set_interface_property sink_10 dataBitsPerSymbol 8
set_interface_property sink_10 errorDescriptor ""
set_interface_property sink_10 firstSymbolInHighOrderBits true
set_interface_property sink_10 maxChannel 0
set_interface_property sink_10 readyLatency 0
set_interface_property sink_10 ENABLED true
set_interface_property sink_10 EXPORT_OF ""
set_interface_property sink_10 PORT_NAME_MAP ""
set_interface_property sink_10 CMSIS_SVD_VARIABLES ""
set_interface_property sink_10 SVD_ADDRESS_GROUP ""

add_interface_port sink_10 PE10_OutpData data Input DataWidth
add_interface_port sink_10 PE10_OutpEn valid Input 1
add_interface_port sink_10 PE10_OutpReady ready Output 1
add_interface_port sink_10 PE10_OutpSel channel Input ViChAddr


# 
# connection point sink_11
# 
add_interface sink_11 avalon_streaming end
set_interface_property sink_11 associatedClock clock
set_interface_property sink_11 associatedReset reset
set_interface_property sink_11 dataBitsPerSymbol 8
set_interface_property sink_11 errorDescriptor ""
set_interface_property sink_11 firstSymbolInHighOrderBits true
set_interface_property sink_11 maxChannel 0
set_interface_property sink_11 readyLatency 0
set_interface_property sink_11 ENABLED true
set_interface_property sink_11 EXPORT_OF ""
set_interface_property sink_11 PORT_NAME_MAP ""
set_interface_property sink_11 CMSIS_SVD_VARIABLES ""
set_interface_property sink_11 SVD_ADDRESS_GROUP ""

add_interface_port sink_11 PE11_OutpData data Input DataWidth
add_interface_port sink_11 PE11_OutpEn valid Input 1
add_interface_port sink_11 PE11_OutpReady ready Output 1
add_interface_port sink_11 PE11_OutpSel channel Input ViChAddr


# 
# connection point source_00
# 
add_interface source_00 avalon_streaming start
set_interface_property source_00 associatedClock clock
set_interface_property source_00 associatedReset reset
set_interface_property source_00 dataBitsPerSymbol 8
set_interface_property source_00 errorDescriptor ""
set_interface_property source_00 firstSymbolInHighOrderBits true
set_interface_property source_00 maxChannel 0
set_interface_property source_00 readyLatency 0
set_interface_property source_00 ENABLED true
set_interface_property source_00 EXPORT_OF ""
set_interface_property source_00 PORT_NAME_MAP ""
set_interface_property source_00 CMSIS_SVD_VARIABLES ""
set_interface_property source_00 SVD_ADDRESS_GROUP ""

add_interface_port source_00 PE00_InpData data Output DataWidth
add_interface_port source_00 PE00_InpEn valid Output 1
add_interface_port source_00 PE00_InpReady ready Input 1
add_interface_port source_00 PE00_InpSel channel Output ViChAddr


# 
# connection point source_01
# 
add_interface source_01 avalon_streaming start
set_interface_property source_01 associatedClock clock
set_interface_property source_01 associatedReset reset
set_interface_property source_01 dataBitsPerSymbol 8
set_interface_property source_01 errorDescriptor ""
set_interface_property source_01 firstSymbolInHighOrderBits true
set_interface_property source_01 maxChannel 0
set_interface_property source_01 readyLatency 0
set_interface_property source_01 ENABLED true
set_interface_property source_01 EXPORT_OF ""
set_interface_property source_01 PORT_NAME_MAP ""
set_interface_property source_01 CMSIS_SVD_VARIABLES ""
set_interface_property source_01 SVD_ADDRESS_GROUP ""

add_interface_port source_01 PE01_InpData data Output DataWidth
add_interface_port source_01 PE01_InpEn valid Output 1
add_interface_port source_01 PE01_InpReady ready Input 1
add_interface_port source_01 PE01_InpSel channel Output ViChAddr


# 
# connection point source_10
# 
add_interface source_10 avalon_streaming start
set_interface_property source_10 associatedClock clock
set_interface_property source_10 associatedReset reset
set_interface_property source_10 dataBitsPerSymbol 8
set_interface_property source_10 errorDescriptor ""
set_interface_property source_10 firstSymbolInHighOrderBits true
set_interface_property source_10 maxChannel 0
set_interface_property source_10 readyLatency 0
set_interface_property source_10 ENABLED true
set_interface_property source_10 EXPORT_OF ""
set_interface_property source_10 PORT_NAME_MAP ""
set_interface_property source_10 CMSIS_SVD_VARIABLES ""
set_interface_property source_10 SVD_ADDRESS_GROUP ""

add_interface_port source_10 PE10_InpData data Output DataWidth
add_interface_port source_10 PE10_InpEn valid Output 1
add_interface_port source_10 PE10_InpReady ready Input 1
add_interface_port source_10 PE10_InpSel channel Output ViChAddr


# 
# connection point source_11
# 
add_interface source_11 avalon_streaming start
set_interface_property source_11 associatedClock clock
set_interface_property source_11 associatedReset reset
set_interface_property source_11 dataBitsPerSymbol 8
set_interface_property source_11 errorDescriptor ""
set_interface_property source_11 firstSymbolInHighOrderBits true
set_interface_property source_11 maxChannel 0
set_interface_property source_11 readyLatency 0
set_interface_property source_11 ENABLED true
set_interface_property source_11 EXPORT_OF ""
set_interface_property source_11 PORT_NAME_MAP ""
set_interface_property source_11 CMSIS_SVD_VARIABLES ""
set_interface_property source_11 SVD_ADDRESS_GROUP ""

add_interface_port source_11 PE11_InpData data Output DataWidth
add_interface_port source_11 PE11_InpEn valid Output 1
add_interface_port source_11 PE11_InpReady ready Input 1
add_interface_port source_11 PE11_InpSel channel Output ViChAddr


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clock clk Input 1
