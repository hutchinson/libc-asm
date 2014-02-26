#!/usr/bin/env bash

# Runs build instructions for a given function within a given header.
function Build() {
  echo "	Building" $1

  #TODO: Find out what rules determine which OS/Compiler variants
  # need leading underscores.
  if [ ${OS} == "Linux" ]; then
    FUNCTION_NAME=$1"_asm"
  elif [ ${OS} == "Darwin" ]; then
    FUNCTION_NAME="_"$1"_asm"
  fi

  FOLDER=$2
  DRIVER_PROGRAM=$3".c"

  CMD="find . -name $1_v[0-9]*_${ARCH}.s"
  SOURCES=`$CMD`

  OBJECT_FILES=""
  for version in $SOURCES
  do
    CMD="basename ${version}"
    ASSEMBLY_FILE=`$CMD`
    OUTPUT_FILE=${ASSEMBLY_FILE/.s/.o}

    # Get the right symbol version.
    VERSION_STR=${ASSEMBLY_FILE/$1_/}
    VERSION_STR=${VERSION_STR/_${ARCH}.s/}

    ${AS} -f ${OBJ_FORMAT} ${FOLDER}/${ASSEMBLY_FILE} -o${BUILD_DIR}/${OUTPUT_FILE} -dSYM_NAME=${FUNCTION_NAME}_${VERSION_STR}
    OBJECT_FILES+=${BUILD_DIR}/${OUTPUT_FILE}" "
  done

  DRIVER_OUTPUT_UNIT=${DRIVER_PROGRAM/.c/.o}

  # Build the driver program
  ${CC} ${OPTIONS} -c tests/${DRIVER_PROGRAM} -o ${TEST_DIR}/${DRIVER_OUTPUT_UNIT}

  # Link together
  DRIVER_OUTPUT=${DRIVER_PROGRAM/.c/}
  ${CC} ${OPTIONS} ${TEST_DIR}/${DRIVER_OUTPUT_UNIT} ${OBJECT_FILES} -o ${DRIVER_DIR}/${DRIVER_OUTPUT}
}

echo "Building"

OS=`uname`
ARCH="x86"

# Setup some options
AS="nasm"
CC="clang"

if [ ${OS} == "Darwin" ]; then
  echo "Building for Mac OS X"
  OBJ_FORMAT="macho "
elif [ ${OS} == "Linux" ]; then
  echo "Building for GNU/Linux"
  OBJ_FORMAT="elf "
fi

OPTIONS="-O3 "
if [ ${ARCH} == "x86" ]; then
  OPTIONS+="-m32 "
elif [ ${ARCH} == "x86_64" ]; then
  OPTIONS+="-m64 "
fi

echo "Build options: " ${OPTIONS}

BUILD_DIR="out"
TEST_DIR=${BUILD_DIR}/tests
DRIVER_DIR=${BUILD_DIR}/drivers

mkdir -pv ${TEST_DIR}
mkdir -pv ${DRIVER_DIR}

# Compile each function into output folder and create the driver program
# strlen
Build "strlen" "string" "strlen_driver"

