# Example 002 Write To Terminal

Prints the letter 'A' to the terminal

## Description

## Notes

### bit (binary digit)

A bit is a number that can be either 0 or 1. At the lowest level (object code) all software is represented as binary. This is because binary is a digital representation of the underlying hardware components, such as logic gates, that can be either on (1) or off (0). [read more](https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/Binary_numeral_system.html)

A binary number contains one or more bits, usually grouped as bytes (8 bits). In a binary integer (whole number) the most significant bit (MSB) is to the left and the least significant bit (LSB) is to the right. That is, the number is changed to a higher order of magnitudes as you change bits further to the left.

in the Intel x86 architecture [manual](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html), section 1.3.3, they represent binary numbers as a string of digits followed by a `B`, ie. `1010B`

__binary to decimal__

* `0000 = 0`
* `0001 = 1`
* `0010 = 2`
* `0100 = 4`
* `1000 = 8`
* `1111 = 15` (8 + 4 + 2 + 1)

### hexadecimal numbers

A hexadecimal number is a conveniant way to represent a binary number. A hexadecimal number has a base of 16 (0 to 9 + A to F), which allows us to represent 8 bits (a byte) in just 2 hex digits. This makes it much easier to remember and communicate. In x86 assembly, memory addresses are written as hexadecimal numbers.

The most common notation for writing a hex is with a leading `0x`, however, in the Intel x86 architecture [manual](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html), section 1.3.3, they referr to a hex number as a string of digits followed by a `H`, for example `FF0000H`.

__binary to hex__

* `00001111 = 0x0F` (or just `0xF`)
* `11010111 = 0xD7`