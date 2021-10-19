# Example 006 Call Procedure

Builds on [example 5](../005_for_loop/005_for_loop.md) but moves the print logic into its own procedure.

## Description

This example moves the print logic into a procedure, which is called into, and returned from. It might not be apparent at a first look, but this requires a stack, which is a fundamental concept in programming, and also a part of the x86 architecture.

## Notes

As talked about previously, when the bootloader is started, it enters something called real-address mode, or real mode. In this mode, the memory model used is called the "real-address mode memory model". There are other memory models, such as the "flat memory model" and the "segmented memory model", that are often used in protected mode. All of these models are virtual, that is they do not represent physcal memory 1:1.

The real-address mode memory model is the one that x86 processors use. It is a form of segmented memory that consists of an array of linear space segments of up to 64 KB in size for each segment, with a maximum address space of 2^20 bytes (or 1 048 576 bytes, which is why real-address mode has a 1MB memory limit). see vol. 1, ch. 3.3.1 of the [Intel manual][intel]

### Procedure Calls, The Stack and The Stack Pointer (ESP)

The procedure stack (the stack) is a contiguous array of memory locations contained in a memory segment, identified by the Stack Segment (SS) register. In real-address mode, and by extension in the real-address mode memory model, the Stack Pointer (ESP) register points to the current memory location within the SS register. The ESP isn't usually manipulated directly, but is changed by the processor when data is either `push`ed or `pop`ed from the stack. This is what happends when you make a procedure call; the state of the calling producedure, local variables, and parameters passed to the called procedure is stored on the stack. In other memory models you can set up your own stack. We will probably look at that in a later example.

Interesting to note is that `jmp` does not use the stack, which is why you cannot get a stack overflow exception by an infinite loop, but very much so by a recursive function in higher level languages. This can be mitigated in most languages by something called tail call optimization.

see vol. 1, ch. 6 of the [Intel manual][intel]

### Labels

To re-iterate the point made in [example 3], the `print` label is just a normal label, there is nothing special about it. It is the process of `call`ing it, which "makes" it a procedure. It is _not_ the same as declaring a C function. There is **no** concept of a function in assembly. However, there is a difference which is the `ret` instruciton that, as you might have guessed, returns from the procedure. The way this is done, is that it simply fetches the value (memory address) that is in the `esp` register and then `jmp` there. If the `ret` instruction is not preceeded by a `call` (or the registered have othervise been set), it is AFAIK undefined behaviour as to where the code execution will end up. see this [SO answer][SO]

[SO]: https://stackoverflow.com/a/46715087/3303776
[example 3]: ../003_labels/003_labels.md#Labels
[intel]: https://software.intel.com/content/www/us/en/develop/download/