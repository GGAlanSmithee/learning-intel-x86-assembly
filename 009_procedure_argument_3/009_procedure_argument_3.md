# Example 7 Procedure Argument 1 - Pass via general registers

This example shows how to pass an argument to a procedure as an argument list.

## Description

Passing arguments in an argument list is suited for passing large data structures and/or a large amount of arguments to a procedure. This bypasses the size-limitations that the general registers imposes.

see vol. 1, ch. 6.4.3 in the [Intel Manual][intel] for more info

## Notes

### Pass arguments using an argument list

Passing arguments in a list is effectively passing them as references, since the only things being "passed" is the address to one (the first argument in the list) or more arguments.


// TODO TODO TODO

(copied to the general registers) 



are the addresses of the arguments and not the argument data itself. This is obvious in the example, where we define bytes of three different sizes, (db (byte) = 8 bits, dw (word) = 16 bits and dd (double) = 32 bits). It is the addresses (the low 8 bits) that is copied into the `bl` register, which is only 8 bit wide.

Passing arguments by storing them in general registers without any further book-keeping becomes problematic when we have nested calls to function with their own set of arguments. To handle cases like this we need to use the stack, which we will look at in the next example.

### Data types

When passing arguments to a procedure it is important to keep track of how large the different pieces of data is. To exapand on [example 1] where we breifly talked about byte addressing, here is a table of the fundamental data types of the x86 architecture:

| Name            | Size         | Bytes | Bits | Layout                                |
| :-------------- | :----------- | :---- | :--- | :------------------------------------ |
| Byte            | 8 bits       | 1     | 8    | `[0000 0000]`                         |
| Word            | 2 Byte       | 2     | 16   | `[High Byte \| Low Byte]`             |
| Doubleword      | 2 Word       | 4     | 32   | `[High Word \| Low Word]`             |
| Quadword        | 2 Doubleword | 8     | 64   | `[High Doubleword \| Low Doubleword]` |
| Double Quadword | 2 Quadword   | 16    | 128  | `[High Quadword \| Low Quadword]`     |

For each of the data types, the low byte (bits 0 - 7) is stored in the lowest address in memory, which is the address that points to the start of the data. This is more important when passing complex data structures, which we will look at in a later example.

### Other thoughts

In this example, I challenged myself to exclusively use the [Intel Manual][intel] as the only reference, which turned out to be a great learning experience. I feel that too often we rely on Google, StackOverflow, Github etc. for spoonfeeding of examples, which tends to promote a pattern of shallow learning resulting in a lack of understanding of the problems we are solving. This, in turn, makes it harder for me as a programmer to build intuition and sound reasoning. While massive, the Intel manual is well structured and informative, and in this case, I am glad I told myself to RTFM.

[intel]: https://software.intel.com/content/www/us/en/develop/download/
[example 1]: ../001_header/001_header#dx
