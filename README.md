# SpecuFlush

This is the repository/branch for the SpecuFlush project. This contains all the code contained to stop a Spectre v1 attack within gem5. 

SpecuFlush was created by a group of University of Michigan students for the EECS 573 Microarchitecture class. 

Authors: Biro Shin, Cameron Barbour, Dev Singhania, Lani Quach, Tong Sing Wu

## Spectre v1 Attack

A Spectre v1 attack is an attack where speculative states of programs allow side-channels to exist, allowing for their exploitation. 
This speculative execution in most modern day processors creates a security vulnerability. When a prediction for speculative execution is incorrect, the processor rolls back the architectural state. 
However, the cache retains traces of this speculative execution, thus allowing secret data that shouldn't have been accessed to be leaked through Cache timing side-channels. 

## Idea behind SpecuFlush

SpecuFlush was created to defend against Spectre v1 attacks by implementing a low architectural overhead solution. We add speculative branch tag bits into the cache in order to prevent speculative load data from being leaked. In normal operation, a speculative load occurs after we see a branch and continue to issue instructions. All the cache lines that are touched by a speculative load get marked. If a branch is correctly predicted and resolves, we clear the speculative bits from the cache. If a branch is mispredicted, we clear the speculative bits and invalidate the cache lines to prevent that data from being leaked. Currently, SpecuFlush supports up to 2 branches, but this can always be expanded to support deeper speculation. 

## Building SpecuFlush

In order to build SpecuFlush, you must first build gem5. Please see the README within the gem5 repository <https://github.com/gem5/gem5> for more information if any issues arise during the build. 
The following section is copied directly from the gem5 repository. We recommend building `scons build/X86/gem5.opt` as this implementation is done on the x86 ISA and processors. 

**Building gem5**

To build gem5, you will need the following software: g++ or clang,
Python (gem5 links in the Python interpreter), SCons, zlib, m4, and lastly
protobuf if you want trace capture and playback support. Please see
<http://www.gem5.org/documentation/general_docs/building> for more details
concerning the minimum versions of these tools.

Once you have all dependencies resolved, execute
`scons build/ALL/gem5.opt` to build an optimized version of the gem5 binary
(`gem5.opt`) containing all gem5 ISAs. If you only wish to compile gem5 to
include a single ISA, you can replace `ALL` with the name of the ISA. Valid
options include `ARM`, `NULL`, `MIPS`, `POWER`, `RISCV`, `SPARC`, and `X86`
The complete list of options can be found in the build_opts directory.

See https://www.gem5.org/documentation/general_docs/building for more
information on building gem5.

**Building Spectre on SpecuFlush**

The next step in running SpecuFlush is to quickly check whether the Hello World program works. Run `build/X86/gem5.opt configs/learning_gem5/part1/two_level.py` and verify that the program runs successfully.

In order to view a Spectre attack, you may need to re-compile the `spectre.c` file. Run `gcc spectre.c -o spectre -static` in the directory where you have cloned this repo into. Next, run `build/X86/gem5.opt configs/learning_gem5/part1/two_level.py spectre` in order to properly view the working Spectre defense. The output will be invalid characters. 

If the program takes too long to run on your machine, please go into the `spectre.c` file and change `for (tries = 20; tries > 0; tries--)` so that the `tries=20` is a smaller value. Smaller values for tries will usually run faster, but can also cause issues on some machines.
