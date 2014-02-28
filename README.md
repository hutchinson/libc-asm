libc-asm
========

This is an educational project which implements functions from the C standard library using assembler.

The aim is to build a better understanding of how higher level constructs are best represented at the machine level.

See http://en.wikipedia.org/wiki/C_standard_library

Building and Running
=====================
Just run ./build.sh to build all the example code and drivers.
Known success with:
	- nasm 2.11.02
	- clang (Apple version 5.0) LLVM version 3.3svn

Binaries are output to ./out/drivers the naming convention is:

function-name\_driver

Structure
=========
For a given libc header e.g. <string.h> there will be a corresponding folder.

Within each folder will be one or more files with the following format:

function-name\_unique-approach-version\_arch.s

Where:
  - function-name -> the function name e.g. strlen
  
  - unique-approach-version -> v1, v2, ..., vX where the version number represents a unique approach to implementing
  the function. e.g. v1 may represent the naive approach with subsequent revisions building upon it.
  
  - arch -> architecture it will run on, x86 for the moment.
  
Within a given source file the symbol name is automatically generated and passed in using the macro:

SYM\_NAME

and currently has the format:

symbol-name\_asm\_unique-approach-version

This is simply to make it easy to test various implementations in the associated driver programs and at the same time
make it easy enough, if at some point, it gets converted to a full libc implementation.


Timing Scores (Rough and Ready)
===============================

Following timing scores are taken on a Mac Pro 4-core (2.2Ghz Intel i7) and measure only time inside
function using Instruments with profiling frequency of 1us.

strlen_driver
system - 0.6ms
v1 - [incoherent scores, investigating further]
v2 - 5.0ms
v3 - 0.2ms

