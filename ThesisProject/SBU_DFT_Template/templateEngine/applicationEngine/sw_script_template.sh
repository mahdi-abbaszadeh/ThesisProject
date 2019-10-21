# Define user definitions
#for @sw in @sw_scripts:
PROJECT_NAME=@sw.nodeName
SAMPLE_TYPE=hello_world_small
SOPCINFO_DIR=./../quartus
SOPCINFO_FILE=qsys_system.sopcinfo
CPU_NAME=@sw.cpuName
# Define internal symbols
BSP_STR=_bsp
APP_NAME=$PROJECT_NAME
BSP_NAME=$PROJECT_NAME$BSP_STR
APP_DIR=$SOPCINFO_DIR/software/$APP_NAME
BSP_DIR=$SOPCINFO_DIR/software/$BSP_NAME
# Create create-this-app and create-this-bsp script
nios2-swexample-create --name=$PROJECT_NAME \
--type=$SAMPLE_TYPE \
--sopc-file=$SOPCINFO_DIR/$SOPCINFO_FILE \
--app-dir=$APP_DIR \
--bsp-dir=$BSP_DIR \
--cpu-name=$CPU_NAME

# Build Application and BSP
cd $APP_DIR
./create-this-app

cd ../$BSP_NAME
./create-this-bsp

# Add source file and remove default one
cd ../$APP_NAME
rm hello_world_small.c
rm $PROJECT_NAME.elf
rm $PROJECT_NAME.map
rm $PROJECT_NAME.objdump
rm obj/default/hello_world_small.d
rm obj/default/hello_world_small.o
cp ../../../sw_sources/@sw.sourceFileName @sw.sourceFileName
cp ../../../packet_transaction_lib/inc/header_@{sw.index}/packet_transaction_util.h packet_transaction_util.h
cp ../../../packet_transaction_lib/inc/packet_transaction.h packet_transaction.h
cp ../../../packet_transaction_lib/src/packet_transaction_util.c packet_transaction_util.c

# generate make file for new source file
nios2-app-generate-makefile --bsp-dir=../$BSP_NAME \
--src-files=@sw.sourceFileName
make

# build again
./create-this-app
#end
