# learning-intel-x86-assembly

A repository to keep my files while learning Intel x86 assembly. I am using the [NASM](https://www.nasm.us/) assembler, which uses the standard Intel syntax for writing x86 assembly code. The examples are ordered chronologically by the time they were added, starting with 001. This means that the examples are not necesarily ordered by complexity. Each example includes a small boot loader header, so that they are identified as bootable and can mounted and run using the [qemu](https://www.qemu.org/) emulator.

The isolated header can be found in the first example, [001_header](001_header/001_header.md).

## DISCLAIMER

_This repository serves as a learning experience for me and will contain errors, missconceptions, misinformation, unoptimized code etc. Feel free to create an issue, PR or discussion with improvements._

## Instructions

Before running an example you need to make sure that the two executables `nasm` and `qemu` are available in the system path. This can be done in a variaty of ways, depending on your operating system. The way I did it was to download [SASM](https://dman95.github.io/SASM/english.html) (which is great for debugging assembly) and [qemu](https://www.qemu.org/). I then made sure the (windows) environment variables path included their respective directories.

To run an example, simply type `run.sh {example}`, for example `run.sh 001_header`. A shell script, `.sh`, is a way to run scripts on linux, but you can execute it on windows by, for example, installing the [git bash](https://git-scm.com/downloads), or by using the [Windows subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install).

If you wish to create a new example, the `create_example.sh` script will help you get set up. Simply call it with `./crete_example.sh {name_of_example}` which will add a new folder with an, othervise empty, but bootable script and a readme file.

## Manuals

* [NASM manual](https://nasm.us/doc/nasmdoci.html)
* [Intel x86 developer manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)

## Additional resources

* https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture
* [x86 registers](https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html)
* [x86 interrupts](https://stanislavs.org/helppc/int_table.html)

## Examples

* [001_header](001_header/001_header.md)