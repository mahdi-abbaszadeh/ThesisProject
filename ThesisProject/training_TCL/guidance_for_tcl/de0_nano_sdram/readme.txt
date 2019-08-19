DE0-nano 'sdram' design
-----------------------

8/19/2014 D. W. Hawkins (dwh@ovro.caltech.edu)

To synthesize the design, perform the following steps;

1) Unzip de0_nano_sdram.zip, eg., into your c:/temp directory.

2) Start Quartus II 

   This script was tested with versions 12.1, 13.0, 13.1, and 14.0.
   The SDRAM controller parameters changed slightly after
   Quartus 12.1, see scripts/qsys_system.tcl.

3) Select the Tcl console.

   If the Tcl console is not visible, use the menu option
   
   View->Utility Windows->Tcl Console
   
4) Use the Tcl console to change into the DE0-nano source folder.
   
   tcl> cd c:/temp/de0_nano_sdram

5) Issue the following command to source and run the synthesis script

   tcl> source scripts/synth.tcl

   The console will output the script progress.
   
   For example, under Quartus II 12.1sp1 (on Windows XP) the output was:

   Synthesizing the DE0-nano 'sdram' design
   ----------------------------------------
    - Quartus Version 12.1 Build 243 01/31/2013 Service Pack 1 SJ Full Version
    - Creating the Quartus work directory
      * C:/temp/de0_nano_sdram/qwork
    - Create the project 'de0_nano'
      * create a new de0_nano project
    - Applying constraints
    - Creating the VHDL files list
    - Generate the Qsys system
      * creating the Qsys file in the work directory
      * Tcl-to-Qsys generation for Quartus version 12.1
      * generating the Qsys system (please wait)
    - Processing the design
    - Processing completed

   and under Quartus II 14.0 (on Windows 7) the output was:

   Synthesizing the DE0-nano 'sdram' design
   ----------------------------------------
    - Quartus Version 14.0.0 Build 200 06/17/2014 SJ Full Version
    - Creating the Quartus work directory
      * C:/Temp/de0_nano_sdram/qwork
    - Create the project 'de0_nano'
      * create a new de0_nano project
    - Applying constraints
    - Creating the VHDL files list
    - Generate the Qsys system
      * creating the Qsys file in the work directory
      * Tcl-to-Qsys generation for Quartus version 14.0
      * generating the Qsys system (please wait)
    - Processing the design
    - Processing completed
   
   This design passes TimeQuest analysis, with no unconstrained paths.
   NOTE: The Altera SDRAM controller does not create an SDC constraints
   file. See scripts/de0_nano.sdc for appropriate SDRAM constraints.

   At this point, the design is ready to test in hardware.
  
   The Qsys system instantiated in the top-level design was created by the
   synthesis script (see scripts/synth.tcl for details). You can inspect
   the Qsys system by starting Qsys via Tools->Qsys, then open the file
   qsys_system.qsys, and look at the Qsys system settings, eg., the SDRAM
   controller parameters.
  
   If you repeat this sequence under Quartus 12.1, 13.0, 13.1 or 14.0, 
   you will see that although the Qsys GUI changes slightly, the Qsys
   SDRAM controller parameters remain correct.

6) Program your board

a) Plug the DE0-nano into your computer.

b) Open the Quartus programmer.

   In the main Quartus GUI, the programmer has a symbol on the top
   menu bar that looks like a cable going into a diamond,
   If you hover your mouse over it, the tooltip is "Programmer"
   
c) At the top-level of the programmer GUI, there is a button that says
   "Hardware Setup", to the right of that should be the text 
   "USB-Blaster [USB-0]". If you do not see the USB-Blaster text,
    click on the "Hardware Setup" program and see if its listed
    there, if it is, select it.
    
d) In the programmer GUI, you should see the file de0_nano.osf ready
   to be programmed into the single device in the JTAG chain.
   
   Press the "Start" button to download to the board.
   
e) The LEDs on the DE0-nano will then start counting.

   This indicates that the 100MHz PLL is operating correctly.
   
f) Start SystemConsole

   The GUI directions for starting SystemConsole change depending
   on the Quartus version. Under 12.1 you have to start Qsys
   and select it via Tools->System Console, under newer versions
   of Quartus, the main GUI Tools menu can be used, eg., under
   Quartus 14.0 use Tools->System Debugging Tools->System Console.
   
   Start SystemConsole and source the JTAG commands script, eg.,
   
   % source c:/temp/de0_nano_sdram/scripts/jtag_cmds.tcl
   
   Then run the (simple) SRAM test
   
   % sdram_test
   Writing to 256 SDRAM locations
   Reading from 256 SDRAM locations
   SDRAM write/read checks passed!

   You can pass the number of locations to test, eg., 
   
   % sdram_test 0x1000
   Writing to 4096 SDRAM locations
   Reading from 4096 SDRAM locations
   SDRAM write/read checks passed!

This design and the JTAG tests is extremely basic and simply shows that
the memory works. A more exhaustive memory test would create a Qsys
system with a pattern generator, DMA controller, and pattern checker,
and then use that to send burst data to and from the SDRAM controller.

Enjoy!

Cheers,
Dave


