# Example 7 Procedure Argument 1 - Pass via general registers

This example shows how to pass an argument to a procedure via general registers.

## Description

There are three ways to pass parameters in the x86 architecture;

1. using general-purpose registers
1. in an argument list
1. on the stack

In this example we explore the first, and most simple, method. see vol. 1, ch. 6.4.3 in the [Intel Manual][intel] for more info

## Notes

### Pass arguments using general-purpose registers

The state of the general purpose registers are not saved on procedure calls. This means you can pass up to six parameters (both in and out) by setting these registers before calling into, or returning from, a procedure.

This is passing the arguments as values, since it is the registers themselves that is being set. Of course, those values could be the addresses of other memory segments, but we will look at that in another example. If it is indeed just the registers themselves that is the holder of the value being passed, that puts a limitation on those registers to their max size, which would be one byte each in the example-

Passing arguments by storing them in general registers without any further book-keeping becomes problematic when we have calls to nested functions with their own set of arguments. To handle cases like this we need to use the stack, which we will look at in the next example.

### Other thoughts

In this example, I challenged myself to exclusively use the [Intel Manual][intel] as the only reference, which turned out to be a great learning experience. I feel that too often we rely on Google, StackOverflow, Github etc. for spoonfeeding of information, which tends to promote a pattern of shallow learning resulting in a lack of understanding of the problems we are solving. This, in turn, makes it harder for me as a programmer to build intuition and sound reasoning. While massive, the Intel manual is well structured and informative, and in this case, I am glad I told myself to RTFM.

[intel]: https://software.intel.com/content/www/us/en/develop/download/
[example 1]: ../001_header/001_header#dx
