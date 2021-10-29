# Example 10 string

In this example we define and print a string, as commonly used in C for examples

## Description

## Notes

### The bx register

It turns out that the general registers are not all created equal. For example, `ax` _cannot_ be used as an index register, that is, for example, it cannot be used to index specific characters in a string. The `bx` register, however, can. The `si` and `di` can likewise be used for indexing. TODO READ UP ON THIS IN THE INTEL MANUAL