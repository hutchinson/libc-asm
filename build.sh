#!/usr/bin/env bash -v

echo "Building"

# Setup some options
AS="nasm"
CC="clang"

#TODO: Determine based on operating system.
OBJ_FORMAT="macho"

OPTIONS="-m32 -O3"

BUILD_DIR="out"
TEST_DIR=${BUILD_DIR}/tests
DRIVER_DIR=${BUILD_DIR}/drivers

mkdir -pv ${TEST_DIR}
mkdir -pv ${DRIVER_DIR}

# Compile each function into output folder and create the driver program
# strlen
${AS} -f ${OBJ_FORMAT} string/strlen.s -o${BUILD_DIR}/strlen.o
${CC} ${OPTIONS} -c tests/strlen_driver.c -o ${TEST_DIR}/strlen_driver.o
${CC} ${OPTIONS} ${TEST_DIR}/strlen_driver.o ${BUILD_DIR}/strlen.o -o ${DRIVER_DIR}/strlen_driver