# Example 8 Procedure Argument 2 - Pass via the stack

This example shows how to pass an argument to a procedure via the stack.

## Description

In this example we pass arguments to the procedure by using the stack. This will solve the issue brought up in the last example, that using general registers limits us to not have nested function calls. Initially, I had planned to include all three ways of passing arguments in the same example, but opted not to in order to be able to focus on each case induvidually.

Again, see vol. 1, ch. 6.4.3 in the [Intel Manual][intel] for more info

## Notes

### The width of the stack

Since the bootloader runs in 16 bit mode, the segments (including the stack-, and instruction pointers) are 16 bit wide. This is called the "operand size", and it means that each entry to the stack is 16 bit wide, no more and no less. That corresponds to the general-purpose registers `ax`, `bx`, `cx` and `dx` as well as a memory allocation that is the width of a word, ie. using the `dw` (define word) instruction. Read more on this in [example 1].

You can `push` any value that fits in 16 bits or less. If you push a value that is less than 16 bit, the reminder of that entry would be filled with garbage. However, when `pop`ping from the stack, you must use a register or variable of the correct size. If you have a value that is larger than 16 bits, you can push the base address of the value (which is 8 bits) + the byte length of the value (which is also 8 bits) for a total of 16 bits, ie. a stack entry. see [this stack overflow answer][SO 1]

### Pass arguments using the stack

The stack is implemented as a standard LIFO (Last In, First Out) data structure, which therefore lends itself very well to keep track of entering contexts (procedures) in order, and then leaving them in reverse order. Technically, what happens when a `call` instruction is executed is that the EIP (Instruction Pointer) - which in turn points to the next instruction to be executed - is pushed to the stack. When the corresponding `ret` instruction is later executed, that EIP is popped of the stack, continuing the execution of the program where it left of.

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

As you can see, the above logic introduces a problem, which is that the return address will be the last thing pushed to the stack before entering the procedure. This means that we have to take that into account when accessing arguments that has been pushed to the stack, which is now offsetted by one entry (16 bits / 2 bytes). Since the stack grows down we can now access the arguments by their offset to the sp.

To facilitate this, and also make it conveniant for us to store local variables, declared within the procedure, on the stack, there exists a common pattern called a "frame stack". The idea is that you temporarily store the sp in the base pointer register (BP) upon entry to the procedure and then use it as the base address to access arguments and local variables. Upon exit of the procedure, you then reset the sp to the value of the bp and pop it off the stack, effectively resetting the stack to as it was upon entry. When exiting the procedure, you can then reset register to as how they were before calling the procedure by popping them in reverse order as they were pushed.

```x86asm
push cx             ; 1. push cx on the stack
push dx             ; 2. push dx on the stack

call procedure      ; 3. call the procedure (= push ip)

pop dx              ; 12. pop stack into dx, reset to old value
pop cx              ; 23. pop stack into cx, reset to old value

procedure:
    push bp         ; 4. push bp to the stack (= the entry point of the stack frame)
    mov bp, sp      ; 5. bp = sp, (= the frame pointer points to the top of the stack)
    mov bx, [bp+6]  ; 6. access first procedure argument
    mov bx, [bp+4]  ; 7. access second procedure argument

    push cx, 'Hi'   ; 8. declare a local variable on the stack

    mov sp, bp      ; 9. set sp to bp, the entry point of the function (step 4)
    pop bp          ; 10. pop bp (the entry point), resetting sp to the return address

    ret             ; 11. return from the procedure (= pop ip)
```

### The stack vs. the heap

In higher level programming, variables can generally be declared in two ways; either on the heap or on the stack. Heap-allocated variables are values that are dynamically declared (a pointer) on a memory segment that is not the stack, and that are long-lived. A stack declared variable on the other hand _is_ declared on the stack, and are typically short lived, bound by the scope (most often a function) that they are declared on.

In the previous example, when we decalred values in the general registered and then accessed them as arguments in a procedure, is an example of heap-allocation, while this example, where arguments are temporarily pushed on the stack, is an example of allocating values on the stack.

It becomes quite appearant what the potential benefints and drawbacks of each type of allocation is. It also makes it super clear to me why you might not want to pass complex data structures by value in a traditional C application (even though modern C++ compilers, move constructors etc can mitigate this), and why you cannot return a reference to locally allocated memory from a function.

[intel]: https://software.intel.com/content/www/us/en/develop/download/
[Princeton]: https://www.cs.princeton.edu/courses/archive/spring11/cos217/lectures/15AssemblyFunctions.pdf
[example 1]: ../001_header/001_header.md#dx
[SO 1]: https://stackoverflow.com/a/45134007/3303776
[SO 2]: https://stackoverflow.com/a/1395934/3303776