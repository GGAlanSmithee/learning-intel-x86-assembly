# Example 8 Procedure Argument 2 - Pass via the stack

This example shows how to pass an argument to a procedure via the stack.

## Description

In this example we pass arguments to the procedure by using the stack. This will solve the issue brought up in the last example, that using general registers limits us to not have nested function calls. Initially, I had planned to include all three ways of passing arguments in the same example, but opted not to in order to be able to focus on each case induvidually.

Again, see vol. 1, ch. 6.4.3 in the [Intel Manual][intel] for more info

## Notes

### Pass arguments using the stack

The stack is implemented as a standard FILO (First In, Last Out) data structure, which therefore lends itself very well to keep track of entering contexts (procedures) in order, and then leaving them in reverse order. Technically, what happens when a `call` instruction is executed is that the EIP (Instruction Pointer) - which in turn points to the next instruction to be executed - is pushed to the stack. When the corresponding `ret` instruction is later executed, that EIP is popped of the stack, continuing the execution of the program where it left of.

To illustrate this, here is simple visualization of this flow:

```x86asm
call one        ; 1. EIP => #call one, stack = [], push #call one
                ; 5. EIP => #next instruction, stack = []

one:
    call two    ; 2. EIP => #call two, stack = [#call one], push #call two
    ret         ; 4. EIP => #ret one, stack = [#call one], pop #call one

two:
    ret         ; 3. EIP => #ret two, stack = [#call one, #call two], pop #call two
```

The idea is that the caller pushes the arguments to the stack - in reverse order - before calling the procedure, which this [Princeton] lecture paper exaplains in a clear and consise manner.

### The stack frame

The keen observer might have noticed that the above logic introduces a problem, which is that the return address will be the last thing pushed to the stack before entering the procedure. This means that we have to take that into account when accessing arguments that has been pushed to the stack, which is now offsetted by one entry (or 16 bits - one word - within this example). Since the stack grows down we can now access the variables like `[sp+1]`



### Digging deeper in the stack

Since the bootloader runs in 16 bit mode, the segments (including the stack-, and instruction pointers) are 16 bit wide. This means that each entry to the stack is 16 bit wide, no more and no less. That corresponds to the general-purpose registers `ax`, `bx`, `cx` and `dx` as well as a memory allocation that is the width of a word, ie. using the `dw` (define word) instruction. Read more on this in [example 1].

You can `push` any value that fits in 16 bits or less. If you push a value that is less than 16 bit, the reminder would be garbage. However, when `pop`ping from the stack, you must use a register or variable of the correct size. If you have a value that is larger than 16 bits, you can push the base address of the value (which is 8 bit) and that byte length of the value (which is also 8 bit) for a total of 16 bit, ie. a stack entry. The correct termonology for this is "operand size". see [this stack overflow answer][SO 1]

[intel]: https://software.intel.com/content/www/us/en/develop/download/
[Princeton]: https://www.cs.princeton.edu/courses/archive/spring11/cos217/lectures/15AssemblyFunctions.pdf
[example 1]: ../001_header/001_header.md#dx
[SO 1]: https://stackoverflow.com/a/45134007/3303776
[SO 2]: https://stackoverflow.com/a/1395934/3303776