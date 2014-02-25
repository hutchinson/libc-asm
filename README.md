libc-asm
========

This is an educational project which implements functions from the C standard library using assemlber.

The aim is to build a better understanding of how higher level constructs are best represented at the machine level.

Structure
=========
For a given libc header e.g. <string.h> there will be a corresponding folder.

Within each folder will be one or more files with the following format:

<function_name>_<unique_approach_version>_<arch>.s

Where:
  - function_name -> the function name e.g. strlen
  
  - unique_approach_version -> v1, v2, ..., vX where the version number represents a unique approach to implementing
  the function. e.g. v1 may represent the naive approach with subsequent revisions building upon it.
  
  - arch -> architecture it will run on, x86 for the moment.
  
Within a given source file the symbol name is automatically generated and passed in using the macro:

SYM_NAME

and currently has the format:

<symbol_name>_asm_<unique_approach_version>

This is simply to make it easy to test various implementations in the associated driver programs and at the same time
make it easy enough, if at some point, it gets converted to a full libc implementation.
