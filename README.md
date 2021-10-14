# learning-intel-x86-assembly

A repository to keep my files while learning Intel x86 assembly. I am using the [NASM](https://www.nasm.us/) assembler, which uses the standard Intel syntax for writing x86 assembly code. The examples are ordered chronologically by the time they were added, starting with 001. This means that the examples are not necesarily ordered by complexity. Each example includes a small boot loader header, so that they are identified as bootable and can mounted and run using the [qemu](https://www.qemu.org/) emulator.

The isolated header can be found in the first example, [001_header](001_header/001_header.md).

I will be adding a markdown file for each example, but this is more as a way for me to solidify what I am learning then something worth reading. Feel free to look through them though.

## DISCLAIMER

_This repository serves as a learning experience for me and will contain errors, missconceptions, misinformation, unoptimized code etc. Feel free to create an issue, PR or discussion with improvements._

## Instructions

Before running an example you need to make sure that the two executables `nasm` and `qemu` are available in the system path. This can be done in a variaty of ways, depending on your operating system. The way I did it was to download [SASM](https://dman95.github.io/SASM/english.html) (which is great for debugging assembly) and [qemu](https://www.qemu.org/). I then made sure the (windows) environment variables path included their respective directories.

To run an example, simply type `run.sh {example}`, for example `run.sh 001_header`. A shell script, `.sh`, is a way to run scripts on linux, but you can execute it on windows by, for example, installing the [git bash](https://git-scm.com/downloads), or by using the [Windows subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install).

If you wish to create a new example, the `create_example.sh` script will help you get set up. Simply call it with `./crete_example.sh {name_of_example}` which will add a new folder with an, othervise empty, but bootable script and a readme file.

## Manuals

- [NasmManual]
- [IntelManual]

## Additional resources

- [x86architecture]
- [x86registers]
- [x86interrupts]

## Examples

- [001_header](001_header/001_header.md)
- [002_write_to_terminal](002_write_to_terminal/002_write_to_terminal.md)
- [003_labels](003_labels/003_labels.md)
- [004_jmp](004_jmp/004_jmp.md)

## Ideas for future examples

- non blocking keyboard input (0x16, AH = 1)
- for-loop
- GDT
- IDT
- Protected mode
- Procedure calls

## Notes

### Operating modes

As explained in vol. 1, ch. 3 of the [IntelManual], the x86 architecture has three operting modes: real-address mode, protected mode, and system management mode.

#### **real-address mode**

The mode that the processor enters upon startup is called real-address mode. In this mode we have access to the programming environment of the processor, which lets us execute instructions, access memory and switch to protected mode. All our examples is written in this mode. While real address mode gives us direct control over memory and a handy set of interrupts, it is also very limiting. For example, it has less than 1MB of RAM available and no built in security mechanisms. See [RealMode] for more info.

_By a lack of understanding on my part, I started running examples with the assembly directive `BITS 32`. This caused incompatabilities that became apparent when I tried to add an example of call procedures, which uses the stack. The procedure calls would behave very randomly, not returning to the correct addresses etc. The reason for this is that real address mode always run in 16 bit mode. I have since updated the examples._

#### **protected mode**

From real-address mode, we can enter protected mode. This is done by setting up a descriptor table and enabling the Protection Enabled (PE) bit in the control register 0 (CR0) (more on this in a later example). In this mode we can do things such as setting up different memory models using virtual memory addresses. It also gives us access to a lot more memory. The limit on a 32-bit system is 4GB (4,294,967,295 bytes) which is the max number of a 32-bit unsigned integer (2^32-1). See [ProtectedMode] for more info.

### Other

- The names x86 and IA-32 are used interchangeably by Intel

## References

- [NasmManual] <https://nasm.us/doc/nasmdoci.html> "NASM Manual"
- [IntelManual] <https://software.intel.com/content/www/us/en/develop/download/intel-64-and-ia-32-architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4.html> "Intel x86 Developer Manual"
- [RealMode] <https://wiki.osdev.org/Real_Mode> "Real Mode"
- [ProtectedMode] <https://en.wikipedia.org/wiki/Protected_mode> "Protected Mode"
- [x86architecture] <https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture> "x86 architecture"
- [x86registers] <https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html> "x86 registers"
- [x86interrupts] <https://stanislavs.org/helppc/int_table.html>  "x86 interrupts"