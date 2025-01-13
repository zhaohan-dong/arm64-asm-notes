// Exercise 4.3
// Do-While loop where the loop is always executed at least once

// X0 - stdout
// X1 - string to print every loop
// X2 - string length
// X3 - control variable for loop, exit loop when it reaches 0

.global _start

_start:
    // Load string to print
    MOV     X0, #1
    LDR     X1, =print
    MOV     X2, #5 // Length of the string

    // Set loop count to 4
    MOV     X3, #10

// Print "Loop\n" whenever the loop is executed
loop:
    // Linux write
    MOV     X0, #1
    MOV     X8, #64
    SVC     0
    // subtract test if the counter reaches 0
    SUBS    X3, X3, #1
    B.HI    loop

loopend:
    // Exit
    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
print: .ascii "Loop\n"
