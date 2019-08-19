# -----------------------------------------------------------------
# jtag_cmds_sc.tcl
#
# 2/20/2012 D. W. Hawkins (dwh@ovro.caltech.edu)
#
# SystemConsole commands for the DE0-nano 'sdram' design.
#
# -----------------------------------------------------------------

# =================================================================
# Master access
# =================================================================
#
# -----------------------------------------------------------------
# Open the JTAG master service
# -----------------------------------------------------------------

# Open the first Avalon-MM master service
proc jtag_open {} {
	global jtag

	# Close any open service
	if {[info exists jtag(master)]} {
		jtag_close
	}

	set master_paths [get_service_paths master]
	if {[llength $master_paths] == 0} {
		puts "Sorry, no master nodes found"
		return
	}

	# Select the first master service
	set jtag(master) [lindex $master_paths 0]

	open_service master $jtag(master)

	return
}

# -----------------------------------------------------------------
# Close the JTAG master service
# -----------------------------------------------------------------
#
proc jtag_close {} {
	global jtag

	if {[info exists jtag(master)]} {
		close_service master $jtag(master)
		unset jtag(master)
	}
	return
}

# -----------------------------------------------------------------
# JTAG-to-Avalon-MM bridge read/write
# -----------------------------------------------------------------
#
proc jtag_read {addr} {
	global jtag
	if {[info exists jtag(bytestream)]} {
		jtag_bytestream_close
	}
	if {![info exists jtag(master)]} {
		jtag_open
	}

	# Read 32-bits
	set data [master_read_32 $jtag(master) $addr 1]
	return $data
}

proc jtag_write {addr data} {
	global jtag
	if {[info exists jtag(bytestream)]} {
		jtag_bytestream_close
	}
	if {![info exists jtag(master)]} {
		jtag_open
	}

	# Write 32-bits
	master_write_32 $jtag(master) $addr [list $data]
	return
}

# -----------------------------------------------------------------
# SDRAM test
# -----------------------------------------------------------------
#
# A very basic test to confirm that the SDRAM is working.
# A more complete test would add pattern generators and checkers
# to the Qsys system and ensure that there are burst transactions
# to the SDRAM.
#
proc sdram_test {{len 0x100}} {

	puts [format "Writing to %d SDRAM locations" $len]
	for {set i 0} {$i < $len} {incr i} {
		set addr [expr {4*$i}]
		set data [expr {0x12340000 + $i}]
		jtag_write $addr $data
	}

	puts [format "Reading from %d SDRAM locations" $len]
	set pass 1
	for {set i 0} {$i < $len} {incr i} {
		set addr [expr {4*$i}]
		set data [expr {0x12340000 + $i}]
		set val [jtag_read $addr]
		if {$val != $data} {
			puts "Error: read mismatch at $addr, read $val, expected $data!"
			set pass 0
		}
	}
	if {$pass} {
		puts "SDRAM write/read checks passed!"
	}
	return
}

