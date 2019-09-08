#Download .sof file on board
#number 2 is for downloading .sof on fpga
cd quartus
nios2-configure-sof -d 2

#Download .elf file on processors
cd software/node_00
nios2-download -g code_00.elf --instance 0

cd ../node_01
nios2-download -g code_01.elf --instance 1

cd ../node_10
nios2-download -g code_10.elf --instance 2

cd ../node_11
nios2-download -g code_11.elf --instance 3