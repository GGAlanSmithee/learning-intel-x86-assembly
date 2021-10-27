# Example 006 Call Procedure

Builds on [example 5](../005_for_loop/005_for_loop.md) but moves the print logic into its own procedure.

## Description

This example moves the print logic into a procedure, which is called into, and returned from. It might not be apparent at a first look, but this requires a stack, which is a fundamental concept in programming, and also a part of the x86 architecture.

## Notes

As talked about previously, when the bootloader is started, it enters something called real-address mode, or real mode. In this mode, the memory model used is called the "real-address mode memory model". There are other memory models, such as the "flat memory model" and the "segmented memory model", that are often used in protected mode. All of these models are virtual, that is they do not represent physical memory 1:1.

The real-address mode memory model is the one that x86 processors use. It is a form of segmented memory that consists of an array of linear space segments of up to 64 KB in size for each segment, with a maximum address space of 2^20 bytes (or 1 048 576 bytes, which is why real-address mode has a 1MB memory limit). see vol. 1, ch. 3.3.1 of the [Intel manual][intel]

### Procedure Calls, The Stack and The Stack Pointer (ESP)

The procedure stack (the stack) is a contiguous array of memory locations contained in a memory segment, identified by the Stack Segment (SS) register. In real-address mode, and by extension in the real-address mode memory model, the Stack Pointer (ESP) register points to the current memory location within the SS register. The ESP isn't usually manipulated directly, but is changed by the processor when data is either `push`ed or `pop`ed from the stack. This is what happens when you make a procedure call; the state of the calling procedure, local variables, and parameters passed to the called procedure is stored on the stack. In other memory models you can set up your own stack, we will probably look at that in a later example.

Interesting to note is that `jmp` does not use the stack, which is why you cannot get a stack overflow exception by an infinite loop, but very much so by a recursive function in higher level languages. This can be mitigated in most languages by something called tail call optimization.

see vol. 1, ch. 6 and vol. 2A of the [Intel manual][intel]

### Procedure Calls continued

The `call` instruction transfers control to a procedure in the current code segment (a near call) or another code segment (a far call). Near calls usually provide access into local procedures within the currently running program while far calls are used to access procedures in the OS or another program/task. A near `call` and `ret` is performed as follows:

* call
    1. Pushes the current value of the EIP register on the stack
    1. Loads the offset of the called procedure in the EIP register
    1. Beings execution of the called procedure
* ret
    1. Pops the value that is at the top of the stack into the EIP register
    1. If the `ret` instruction has an optional `n` argument, increments the stack pointer by `n` bytes
        - this is how arguments are handled on the stack
    1. Resumes execution of the calling procedure

As you can see, and to clarify, the Instruction Pointer (EIP) register (as talked about in [example 4]) holds the address (base + offset) of the next instruction to be executed and the ESP register holds the address of top-most entry in the stack (the SS register).

see vol. 1, ch. 6.4 of the [Intel manual][intel]

### Labels

To re-iterate the point made in [example 3], the `print` label is just a normal label, there is nothing special about it. It is the process of `call`ing it, which "makes" it a procedure. It is _not_ the same as declaring a C function. There is **no** concept of a function in assembly. However, there is a difference which is the `ret` instruction that, as you might have guessed, returns from the procedure. The way this is done, is that it simply fetches the value (memory address) that is in the `esp` register and then `jmp` there. If the `ret` instruction is not preceded by a `call` (or the registered have otherwise been set), it is AFAIK undefined behavior as to where the code execution will end up. see this [SO answer][SO 1]

[SO 1]: https://stackoverflow.com/a/46715087/3303776
[SO 2]: https://stackoverflow.com/a/40324529/3303776
[example 3]: ../003_labels/003_labels.md#Labels
[example 4]: ../004_jmp/004_jmp.md
[intel]: https://software.intel.com/content/www/us/en/develop/download/