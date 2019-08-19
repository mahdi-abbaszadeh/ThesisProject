# -----------------------------------------------------------------
# de0_nano/cyclone4/share/scripts/constraints.tcl
#
# 4/20/2012 D. W. Hawkins (dwh@ovro.caltech.edu)
#
# Terasic DE0-nano Cyclone IV kit constraints.
#
# The Tcl procedures in this constraints file can be used by
# project synthesis files to setup the default device constraints
# and pinout.
#
# -----------------------------------------------------------------
# References
# ----------
#
# [1] Terasic, "DE0-nano schematic", 2011.
#
# -----------------------------------------------------------------

# -----------------------------------------------------------------
# Device assignment
# -----------------------------------------------------------------
#
proc set_device_assignment {} {

	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE EP4CE22F17C6

}

# -----------------------------------------------------------------
# Default assignments
# -----------------------------------------------------------------
#
proc set_default_assignments {} {

	# Tri-state unused pins
#	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED WITH WEAK PULL-UP"

	# Set the default I/O logic standard to 3.3V
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
#	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVCMOS"

	# JTAG IDCODE (so that its not the default FFFFFFFF)
	set_global_assignment -name STRATIX_JTAG_USER_CODE DEADBEEF

	# Dual purpose pins
	#
	# * nCEO (F16) is used for gpio_c[9] (p6 [1])
	set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
	#
	# * DCLK (H1) can be used for EPCS access (p8 [1])
	set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"
	#
	# * DATA0 (H2) can be used for EPCS access (p8 [1])
	set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
	#
	# * DATA1/ASDO (C1) can be used for EPCS access (p8 [1])
	set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
	#
	# * FLASH_nCE/nCSO (D2) can be used for EPCS access (p8 [1])
	set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"

	return
}

# -----------------------------------------------------------------
# Pin constraints
# -----------------------------------------------------------------
#
# The pin constraints can be displayed in Tcl using;
#
# tcl> get_pin_constraints pin
# tcl> parray pin
#
# The pin constraints for each pin (port) on the design are
# specified as a comma separated list of {key = value} pairs.
# The procedure set_pin_constraints converts those pairs
# into Altera Tcl constraints.
#
proc get_pin_constraints {arg} {

	# Make the input argument 'arg' visible as pin
	upvar $arg pin
	
	# -------------------------------------------------------------
	# Global Clocks
	# -------------------------------------------------------------
	#
	# Input
	set pin(clkin_50MHz) {PIN = R8, IOSTD = "3.3-V LVTTL"}

	# -------------------------------------------------------------
	# Push buttons
	# -------------------------------------------------------------
	#
	# Reset (KEY0, DEV_CLRn)
	set pin(ext_rstN)	{PIN = J15, IOSTD = "3.3-V LVTTL"}

	# Push button (KEY1)
	set pin(pb) 		{PIN = E1 , IOSTD = "3.3-V LVTTL"}

	# -------------------------------------------------------------
	# Switches
	# -------------------------------------------------------------
	#
	# Inputs
	set pin(sw[0])    {PIN = M1 , IOSTD = "3.3-V LVTTL"}
	set pin(sw[1])    {PIN = T8 , IOSTD = "3.3-V LVTTL"}
	set pin(sw[2])    {PIN = B9 , IOSTD = "3.3-V LVTTL"}
	set pin(sw[3])    {PIN = M15, IOSTD = "3.3-V LVTTL"}

	# -------------------------------------------------------------
	# LEDs
	# -------------------------------------------------------------
	#
	# The LEDs use "3.3-V LVTTL" rather than "3.3-V LVCMOS" as 
	# the Pin Planner shows that LVTTL has 8mA maximum current,
	# whereas LVCMOS is only 2mA.
	#
	# Outputs
	set pin(led[0])	{PIN = A15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[1])	{PIN = A13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[2])	{PIN = B13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[3])	{PIN = A11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[4])	{PIN = D1 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[5])	{PIN = F3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[6])	{PIN = B1 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(led[7])	{PIN = L3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	# -------------------------------------------------------------
	# Accelerometer and I2C EEPROM
	# -------------------------------------------------------------
	#
	# The accelerometer can be accessed in I2C mode (csN high),
	# or in 3-wire SPI mode (csN, sck, sdio).
	#

	# Accelerometer
	set pin(accel_csN)		{PIN = G5, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(accel_int)		{PIN = M2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	
	# I2C clk/data or 3-wire SPI clk/data
	set pin(i2c_sck)		{PIN = F2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(i2c_sda)		{PIN = F1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	
	# -------------------------------------------------------------
	# ADC
	# -------------------------------------------------------------
	#
	set pin(adc_csN)		{PIN = A10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(adc_sck)		{PIN = B14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(adc_mosi)		{PIN = B10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(adc_miso)		{PIN = A9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	# -------------------------------------------------------------
	# EPCS
	# -------------------------------------------------------------
	#
	# These pin assignments require the these dual-purpose pins be
	# configured for use as "Use as regular I/O".
	#
	set pin(epcs_csN)		{PIN = D2, IOSTD = "3.3-V LVTTL", DRIVE = "DEFAULT"}
	set pin(epcs_sck)		{PIN = H1, IOSTD = "3.3-V LVTTL", DRIVE = "DEFAULT"}
	set pin(epcs_mosi)		{PIN = C1, IOSTD = "3.3-V LVTTL", DRIVE = "DEFAULT"}
	set pin(epcs_miso)		{PIN = H2, IOSTD = "3.3-V LVTTL"}

	# -------------------------------------------------------------
	# SDR SDRAM
	# -------------------------------------------------------------
	#
	# Clock
	set pin(sdram_clk)		{PIN = R4, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	
	# Controls
	set pin(sdram_cke)		{PIN = L7, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_csN)		{PIN = P6, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_rasN)		{PIN = L2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_casN)		{PIN = L1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_weN)		{PIN = C2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dqm[0])	{PIN = R6, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dqm[1])	{PIN = T5, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	
	# Address
	set pin(sdram_ba[0])	{PIN = M7, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_ba[1])	{PIN = M6, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[0])	{PIN = P2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[1])	{PIN = N5, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[2])	{PIN = N6, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[3])	{PIN = M8, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[4])	{PIN = P8, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[5])	{PIN = T7, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[6])	{PIN = N8, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[7])	{PIN = T6, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[8])	{PIN = R1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[9])	{PIN = P1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[10])	{PIN = N2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[11])	{PIN = N1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_addr[12])	{PIN = L4, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	
	# Data
	set pin(sdram_dq[0])	{PIN = G2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[1])	{PIN = G1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[2])	{PIN = L8, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[3])	{PIN = K5, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[4])	{PIN = K2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[5])	{PIN = J2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[6])	{PIN = J1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[7])	{PIN = R7, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[8])	{PIN = T4, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[9])	{PIN = T2, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[10])	{PIN = T3, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[11])	{PIN = R3, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[12])	{PIN = R5, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[13])	{PIN = P3, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[14])	{PIN = N3, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(sdram_dq[15])	{PIN = K1, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	# -------------------------------------------------------------
	# GPIO-A
	# -------------------------------------------------------------
	#
	# Input-only
	set pin(gpin_a[0])		{PIN = A8 , IOSTD = "3.3-V LVTTL"}
	set pin(gpin_a[1])		{PIN = B8 , IOSTD = "3.3-V LVTTL"}

	# Input/Output
	set pin(gpio_a[0])		{PIN = D3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[1])		{PIN = C3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[2])		{PIN = A2 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[3])		{PIN = A3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[4])		{PIN = B3 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[5])		{PIN = B4 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[6])		{PIN = A4 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[7])		{PIN = B5 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[8])		{PIN = A5 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[9])		{PIN = D5 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[10])		{PIN = B6 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[11])		{PIN = A6 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[12])		{PIN = B7 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[13])		{PIN = D6 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[14])		{PIN = A7 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[15])		{PIN = C6 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[16])		{PIN = C8 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[17])		{PIN = E6 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[18])		{PIN = E7 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[19])		{PIN = D8 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[20])		{PIN = E8 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[21])		{PIN = F8 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[22])		{PIN = F9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[23])		{PIN = E9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[24])		{PIN = C9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[25])		{PIN = D9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[26])		{PIN = E11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[27])		{PIN = E10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[28])		{PIN = C11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[29])		{PIN = B11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[30])		{PIN = A12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[31])		{PIN = D11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[32])		{PIN = D12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_a[33])		{PIN = B12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	# -------------------------------------------------------------
	# GPIO-B
	# -------------------------------------------------------------
	#
	# Input-only
	set pin(gpin_b[0])		{PIN = T9 , IOSTD = "3.3-V LVTTL"}
	set pin(gpin_b[1])		{PIN = R9 , IOSTD = "3.3-V LVTTL"}

	# Input/Output
	set pin(gpio_b[0])		{PIN = F13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[1])		{PIN = T15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[2])		{PIN = T14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[3])		{PIN = T13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[4])		{PIN = R13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[5])		{PIN = T12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[6])		{PIN = R12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[7])		{PIN = T11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[8])		{PIN = T10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[9])		{PIN = R11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[10])		{PIN = P11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[11])		{PIN = R10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[12])		{PIN = N12, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[13])		{PIN = P9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[14])		{PIN = N9 , IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[15])		{PIN = N11, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[16])		{PIN = L16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[17])		{PIN = K16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[18])		{PIN = R16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[19])		{PIN = L15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[20])		{PIN = P15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[21])		{PIN = P16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[22])		{PIN = R14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[23])		{PIN = N16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[24])		{PIN = N15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[25])		{PIN = P14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[26])		{PIN = L14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[27])		{PIN = N14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[28])		{PIN = M10, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[29])		{PIN = L13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[30])		{PIN = J16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[31])		{PIN = K15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[32])		{PIN = J13, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_b[33])		{PIN = J14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	# -------------------------------------------------------------
	# GPIO-C (2x13 header)
	# -------------------------------------------------------------
	#
	# Input-only
	set pin(gpin_c[0])		{PIN = E15, IOSTD = "3.3-V LVTTL"}
	set pin(gpin_c[1])		{PIN = E16, IOSTD = "3.3-V LVTTL"}
	set pin(gpin_c[2])		{PIN = M16, IOSTD = "3.3-V LVTTL"}

	# Input/Output
	set pin(gpio_c[0])		{PIN = A14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[1])		{PIN = B16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[2])		{PIN = C14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[3])		{PIN = C16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[4])		{PIN = C15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[5])		{PIN = D16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[6])		{PIN = D15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[7])		{PIN = D14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[8])		{PIN = F15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[9])		{PIN = F16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[10])		{PIN = F14, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[11])		{PIN = G16, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}
	set pin(gpio_c[12])		{PIN = G15, IOSTD = "3.3-V LVTTL", DRIVE = "MAXIMUM CURRENT", SLEW = 2}

	return
}

# -----------------------------------------------------------------
# Set Quartus pin assignments
# -----------------------------------------------------------------
#
# This procedure parses the entries in the Tcl pin constraints
# array and issues Quartus Tcl constraints commands.
#
proc set_pin_constraints {} {

	# Get the pin and I/O standard assignments
	get_pin_constraints pin
	
	# Loop over each pin in the design
	foreach port [array names pin] {
	
		# Convert the pin assignments into an options list, 
		# eg., {PIN = AV22} { IOSTD = LVDS}
		set options [split $pin($port) ,]
		foreach option $options {
		
			# Split each option into a key/value pair
			set keyval [split $option =]
			set key [lindex $keyval 0]
			set val [lindex $keyval 1]
				
			# Strip leading and trailing whitespace
			# and force to uppercase
			set key [string toupper [string trim $key]]
			set val [string toupper [string trim $val]]
	
			# Make the Quartus assignments
			#
			# The keys used in the assignments list are an abbreviation of
			# the Quartus setting name. The abbreviations supported are;
			#
			#   DRIVE   = drive current
			#   HOLD    = bus hold (ON/OFF)
			#   IOSTD   = I/O standard
			#   PIN     = pin number/name
			#   PULLUP  = weak pull-up (ON/OFF)
			#   SLEW    = slew rate (a number between 0 and 3)
			#   TERMIN  = input termination (string value)
			#   TERMOUT = output termination (string value)
			#
			switch $key {
				DRIVE   {set_instance_assignment -name CURRENT_STRENGTH_NEW $val -to $port}
				HOLD    {set_instance_assignment -name ENABLE_BUS_HOLD_CIRCUITRY $val -to $port}				
				IOSTD   {set_instance_assignment -name IO_STANDARD $val -to $port}
				PIN     {set_location_assignment -to $port "Pin_$val"}
				PULLUP  {set_instance_assignment -name WEAK_PULL_UP_RESISTOR $val -to $port}				
				SLEW    {set_instance_assignment -name SLEW_RATE $val -to $port}
				TERMIN  {set_instance_assignment -name INPUT_TERMINATION $val -to $port}
				TERMOUT {set_instance_assignment -name OUTPUT_TERMINATION $val -to $port}				
				default {error "Unknown setting: KEY = '$key', VALUE = '$val'"}
			}
		}
	}
}

# -----------------------------------------------------------------
# Set the default constraints
# -----------------------------------------------------------------
#
proc set_default_constraints {} {
	set_device_assignment
	set_default_assignments
	set_pin_constraints
}

