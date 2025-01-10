// Exercise 4.3
// Do-While loop where the loop is always executed at least once

// X0 - stdout
// X1 - string to print every loop
// X2 - string length
// X3 - control variable for loop, exit loop when it reaches 0

.global _start

_start:
    // Load string to print
    mov X0, #1
    ldr X1, =print
    mov X2, #5 // Length of the string

    // Set loop count to 4
    mov X3, #10

// Print "Loop\n" whenever the loop is executed
loop:
    // Linux write
    mov X0, #1
    mov X8, #64
    svc 0
    // subtract test if the counter reaches 0
    subs X3, X3, #1
    b.hi loop

loopend:
    // Exit
    mov X0, #0
    mov X8, #93
    svc 0

.data
print: .ascii "Loop\n"
