# Define user definitions
PROJECT_NAME=test
SAMPLE_TYPE=hello_world_small
SOPCINFO_DIR=./../quartus
SOPCINFO_FILE=qsys_system.sopcinfo
CPU_NAME=nios2_00
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
cp ../../../NewFolder/code_00.c code_00.c

# generate make file for new source file
nios2-app-generate-makefile --bsp-dir=../$BSP_NAME \
--src-files=code_00.c
make

#build again
./create-this-app


#Download .sof file on board
cd ../../
nios2-configure-sof -d 2

#Download .elf file on processor
cd software/$APP_NAME
nios2-download -g code_00.elf --instance 0