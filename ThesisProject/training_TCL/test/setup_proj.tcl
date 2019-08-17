# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "myproj"]} {
		puts "Project myproj is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists myproj]} {
		project_open -revision mytop myproj
	} else {
		project_new -revision mytop myproj
	}
	set need_to_close_project 1
}


# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE "5csema4u23c6"
	# set_global_assignment -name BDF_FILE "mytop.bdf"
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 17.1.0
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim (Verilog)"
	set_global_assignment -name EDA_NETLIST_WRITER_OUTPUT_DIR simulation/modelsim -section_id eda_simulation
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation

# Convert qsys_system.tcl to qsys_system.qsys
	proc qsys_create {} {
		global scripts 17.1 quartus

		puts "   * Tcl-to-Qsys generation for Quartus version 17.1"
		set arg_list [list]
		set cmd "set quartus_version 17.1"
		lappend arg_list --cmd=$cmd
		lappend arg_list --search-path="C:/Users/Mahdi2016/Desktop/ThesisProject/ThesisProject/training_TCL/test,$"
		lappend arg_list --script=NoC_QSYS_hw.tcl
		catch { eval [concat [list exec D:/intelFPGA/17.1/quartus/sopc_builder/bin/qsys-script] $arg_list] } temp

		

		# Create a timestamp file
		close [open "qsys_system.timestamp" w]

		return
	}
	puts "   * creating the Qsys file in the work directory"
	#qsys_createIP
	qsys_create

	#generating the qsys
	exec D:/intelFPGA/17.1/quartus/sopc_builder/bin/ip-generate --report-file=qip:usaved.qip --component-file=unsaved.qsys 

	#add qip to project
	set_global_assignment -name QIP_FILE unsaved.qip

	set_global_assignment -name TOP_LEVEL_ENTITY unsaved
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
