# Example 001 Header

A simple script containing a bootable header.

## Description

This is (almost) the minimum example of a (useless) x86 NASM boot loader. It does nothing more than define a header, which makes it bootable. For BIOS to identify the script as being bootable it has two requirements.

1. The script must be a total of 512 bytes
1. The last two bytes must be the (magic) hexadecimal number `0xaa00`

The above requirements are met by lines 6 and 7 in the script. Lines 1 and 2 are optional, they are so called "assembler directives", which gives hints to the assembler, that it _can_ adhere to if it wants to. (see comments in the file).

## Notes

### dx

x86 uses something called "byte addressing", which means that the least (meaningful) common denominator as far as memory allocation is concerned is a `byte`, which is 8 bits large. A chunk of memory of that size is referred to as just that, a `byte`. Everything above that is referred to as a variation of a `word`. read more in volume 1, section 4.1 in the intel x86 [manual](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)

NASM, much like other assembly languages, provides syntax to define these memory chunks. This is done via the psuedo-instructions that is generalized as `dx`. The `x` varies depending on size of the "chunk", see section 3.2.1 in the [manual](https://nasm.us/doc/nasmdoc3.html#section-3.2.1). For example, a `dw` (define word) allocates two bytes (16 bits) of memory, and `dd` (define doubleword) allocates four bytes (32 bits) of memory. In relation to a higher level language, such as C, a `char` is a byte, a `short` is two bytes and an `int` is four bytes.

The syntax for declaring data is as follows: `dx {data}`

### TIMES

`TIMES` is another psuedo-instruction that repeats an instruction n times, just like `TIMES {n} {instruction}`. see section 3.2.5 in the [manual](https://nasm.us/doc/nasmdoc3.html#section-3.2.1)

### Psuedo instructions

The above instructions are called psuedo instructions because they are not real x86 machine instructions, but are used in the instruction field anyway. see section 3.2 in the [manual](https://nasm.us/doc/nasmdoc3.html#section-3.2)
