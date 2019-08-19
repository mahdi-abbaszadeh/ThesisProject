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

# Build BSP and Application
cd $APP_DIR
./create-this-app

cd ../$BSP_NAME
./create-this-bsp

# cd ../../../NewFolder
# nios2-app-update-makefile --app-dir=$APP_DIR \
# --add-src-files=code_00.c \
# --no-src

# cd $APP_DIR
# ./create-this-app


#Download .sof file on board
cd ../../
nios2-configure-sof -d 2

#Download .elf file on processor
cd software/$APP_NAME
nios2-download -g $PROJECT_NAME.elf --instance 0