# -----------------------------------------------------------------
# qsys_system.tcl
#
# 8/19/2014 D. W. Hawkins (dwh@ovro.caltech.edu)
#
# DE0-nano SDRAM controller example Qsys system generation script.
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
set_project_property DEVICE_FAMILY {Cyclone IV E}
set_project_property DEVICE {EP4CE22F17C6}

# Components
# ----------
#
# The order the components are created here, matches the order
# they are displayed in the Qsys GUI.
#
add_instance clk_100MHz clock_source
set_instance_parameter_value clk_100MHz clockFrequency {100000000.0}
set_instance_parameter_value clk_100MHz clockFrequencyKnown {1}
set_instance_parameter_value clk_100MHz inputClockFrequency {0.0}
set_instance_parameter_value clk_100MHz resetSynchronousEdges {DEASSERT}

add_instance jtag_master altera_jtag_avalon_master
set_instance_parameter_value jtag_master USE_PLI {0}
set_instance_parameter_value jtag_master PLI_PORT {50000}
set_instance_parameter_value jtag_master COMPONENT_CLOCK {0}
set_instance_parameter_value jtag_master FAST_VER {0}
set_instance_parameter_value jtag_master FIFO_DEPTHS {2}
set_instance_parameter_value jtag_master AUTO_DEVICE_FAMILY {Cyclone IV E}
set_instance_parameter_value jtag_master AUTO_DEVICE {EP4CE22F17C6}

add_instance sdram altera_avalon_new_sdram_controller
set_instance_parameter_value sdram TAC {5.5}
set_instance_parameter_value sdram TMRD {3.0}
set_instance_parameter_value sdram TRCD {20.0}
set_instance_parameter_value sdram TRFC {70.0}
set_instance_parameter_value sdram TRP {20.0}
set_instance_parameter_value sdram TWR {14.0}
set_instance_parameter_value sdram casLatency {3}
set_instance_parameter_value sdram clockRate {100000000.0}
set_instance_parameter_value sdram columnWidth {9}
set_instance_parameter_value sdram dataWidth {16}
set_instance_parameter_value sdram generateSimulationModel {0}
set_instance_parameter_value sdram initNOPDelay {0.0}
set_instance_parameter_value sdram initRefreshCommands {8}
set_instance_parameter_value sdram masteredTristateBridgeSlave {0}
set_instance_parameter_value sdram model {custom}
set_instance_parameter_value sdram numberOfBanks {4}
set_instance_parameter_value sdram numberOfChipSelects {1}
set_instance_parameter_value sdram pinsSharedViaTriState {0}
set_instance_parameter_value sdram powerUpDelay {200.0}
set_instance_parameter_value sdram refreshPeriod {7.8125}
set_instance_parameter_value sdram registerDataIn {1}
set_instance_parameter_value sdram rowWidth {13}
set_instance_parameter_value sdram size {33554432.0}

if {$quartus_version > 12.1} {
	# Additional parameters on the SDRAM controller in
	# Quartus version 13.0, 13.1, and 14.0, but not on
	# the controller in Quartus version 12.1
	set_instance_parameter_value sdram addressWidth {24}
	set_instance_parameter_value sdram bankWidth {2}
	set_instance_parameter_value sdram componentName {$${FILENAME}_sdram}
}

# Connections
# -----------
add_connection clk_100MHz.clk jtag_master.clk

add_connection clk_100MHz.clk sdram.clk

add_connection clk_100MHz.clk_reset jtag_master.clk_reset

add_connection clk_100MHz.clk_reset sdram.reset

add_connection jtag_master.master sdram.s1
set_connection_parameter_value jtag_master.master/sdram.s1 arbitrationPriority {1}
set_connection_parameter_value jtag_master.master/sdram.s1 baseAddress {0x0000}
set_connection_parameter_value jtag_master.master/sdram.s1 defaultConnection {0}

# Exported interfaces
# -------------------
#
# Top-level entity ports
#
add_interface          clk clock sink
set_interface_property clk EXPORT_OF clk_100MHz.clk_in

add_interface          reset reset sink
set_interface_property reset EXPORT_OF clk_100MHz.clk_in_reset

add_interface          sdram conduit end
set_interface_property sdram EXPORT_OF sdram.wire

# Save the system
# ---------------
save_system "qsys_system.qsys"
