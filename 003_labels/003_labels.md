# Example 003 Labels

Declares labels

## Description

Declares the labels `val` and `print`. The first which points to a memory address that holds the value 'L' and the second that points to a memory address that holds a piece of code that prints `val` to the screen.

As you can see in the example, it is possible to dereference a label to get the underlying value, which is done using angle-brackets `[val]`. This opens the door for things such as pointer arithmetics, which we will explore in a later example.

When declaring a one-liner label, such as `val`, it is possible to skip the `:`, like `val db 'L'`. I would not recommend this, since it makes the code less clear and opens up for errors if you were to add additional lines.

## Notes

### Labels

A label in assembly is a symbolic way to write memory addresses ([source][SO]). However, for someone new to assembly (like me), the syntax of it can be a bit confusing since it looks like either a variable declaration (`val`) or a function declaration (`print`), which of it is neither. To re-iterate, a label is simply a symbol (name) that points to a place in the code (memory address).

When a program is executed and hits a label, the execution of the program will continue as normal. It is not "going into" the label, not "skipping it", or anything like that. There are ways to go to a label, such as `call` or `jmp`, and we will explore this in a later example.

[SO]: https://stackoverflow.com/a/44818531/3303776