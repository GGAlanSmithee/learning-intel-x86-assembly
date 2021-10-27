# Example 002 Write To Terminal

Prints the letter 'A' to the terminal

## Description

This program uses a software interrupt to let the processor know there is something it must do. In this specific example, that is to write a character to the terminal, which corresponds to interrupt 10.E. This interrupt is a part of the INT _n_ (software interrupt) instruction, which is one of the instructions that allows a program to call an interrupt. See vol. 1, ch. 6.5.4 and 7.3.8.4 in the [intel manual]

The intel x86 manual does not cover available software interrupts as it is a part of the BIOS instruction set as far as I understand it. [This page][int table] covers them though. Drilling down we see that [interrupt 10] (Video BIOS Service), and more specifically [interrupt 10.E] (Write Text in Teletype Mode) is the one used in this example.

On a high level, a software interrupt works like this:

1. set some registers (as defined by the BIOS)
1. call the appropriate software interrupt using the `int` instruction
1. optionally, the processor will set some register as a return value

Looking at the doc for this interrupt, it expects the register `ah` to be set to `0e` and the register `al` to be set to the character to be printed. I recommend reading [this tutorial][rip tutorial] which contains a lot of useful information regarding software interrupts.

## Notes

### Segment Registers

The segment registers that are used to calculate the physical address of memory being accessed are always 16 bits wide. This is true for all processor modes. These are the `cs`, `ds`, `ss`, `es`, `fs` and `gs` registers and they are each associated with one of three types of storage: code, data or stack. How these are used depends on your memory model. read more in vol. 1, ch. 3.4.2 of the [intel manual]

### General-Purpose Registers

The x86 architecture defines a couple of registers (space in memory) that are built in to the processor, called general registers. While these can be used as a general store of data (that are more performant than the custom defined `dx` registers), they are also used by the processor as a way of passing data between the BIOS and the processor. read more [here][x86 registers]

A register (for 32 bit x86) is 32 bits wide. The "general registers" are named `EAX`, `EBX`, `ECX`, `EDX` and each one of them are also segmented into 16 and 8 bits sub parts. These sub parts follows a naming convention that is as

| 32 bit | 16 bit | High 8 bit | Low 8 bit |
| :---   | :---   | :---       | :---      |
| `EAX`  | `AX`   | `AH`       | `AL`      |
| `EBX`  | `BX`   | `BH`       | `BL`      |
| `ECX`  | `CX`   | `CH`       | `CL`      |
| `EDX`  | `DX`   | `DH`       | `DL`      |

and the memory layout is as follow

| 32 bit                | 16 bit      |             |
| :--                   | :--         | :--         |
|                       | Hight 8 bit | Low 8 bit   |
| `0000 0000 0000 0000` | `0000 0000` | `0000 0000` |

This has the consequence that if you assign something to `EAX`, it will also override the `AX`, `AH` and `AL` registers, and if you assign something to `AX`, it will also override the `AH` and `AL` registers, since these registers point to the same memory.

### Interrupts

An interrupt is a asynchronous event that is usually triggered by an I/O event such as keyboard input or writing a character to the screen. When the processor receives an interrupt (or an exception, which acts much like an interrupt, except that it's synchronous) it halts the execution of the current program to handle the event. In the x86 (i32) architecture, there are 18 predefined interrupts / exceptions and 223 user defined interrupts. see vol. 1, ch. 6.5 of the [intel manual]

### bit (binary digit)

A bit is a number that can be either 0 or 1. At the lowest level (object code) all software is represented as binary. This is because a bit is a digital representation of the underlying hardware component operations, such as logic gates, that can be either on (1) or off (0). [read more][binary]

A binary number contains one or more bits, grouped as bytes (8 bits), which is referred to as "segmented addressing" or more specifically as "byte addressing". In a binary integer (whole number) the most significant bit (MSB) is to the left and the least significant bit (LSB) is to the right. That is, the number is changed to a higher order of magnitudes as you change bits further to the left.

in the Intel x86 architecture [manual][intel manual], vol. 1, ch. 1.3.3, they represent binary numbers as a string of digits followed by a `B`, ie. `1010B`

| Binary | Decimal |         |
| :---   | :---    | :---    |
| `0000` | `0`     |         |
| `0001` | `1`     |         |
| `0010` | `2`     |         |
| `0100` | `4`     |         |
| `1000` | `8`     |         |
| `1111` | `15`    | 8+4+2+1 |


### hexadecimal numbers

A hexadecimal number is a convenient way to represent a binary number. A hexadecimal number has a base of 16 (0 to 9 + A to F), which allows us to represent 8 bits (a byte) in just 2 hex digits. This makes it much easier to remember and to communicate. In x86 assembly, memory addresses are written as hexadecimal numbers.

The most common notation for writing a hex is with a leading `0x`, however, in the Intel x86 architecture [manual][intel manual], vol. 1, ch. 1.3.3, they refer to a hex number as a string of digits followed by a `H`, for example `FF0000H`.

| Binary      | Hex    |               |
| :---        | :---   | :---          |
| `0000 1111` | `0x0F` | or just `0xF` |
| `1101 0111` | `0xD7` |               |

[intel manual]: https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html
[int table]: https://stanislavs.org/helppc/int_table.html
[interrupt 10]: https://stanislavs.org/helppc/int_10.html
[interrupt 10.E]: https://stanislavs.org/helppc/int_10-e.html
[rip tutorial]: https://riptutorial.com/x86/example/23463/bios-calls
[x86 registers]: https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html
[binary]: https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/Binary_numeral_system.html