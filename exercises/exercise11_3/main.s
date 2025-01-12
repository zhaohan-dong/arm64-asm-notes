// Exercise 11.3
// Dot product of dimension six

.include "debug.s"
.include "dotproduct.s"

.global main

main:
    LDR         X1, =vecA
    LDR         X2, =vecB
    MOV         X3, #6 // Define dimension of six
    dotproduct   X0, X1, X2, X3 // Calculate and store result in X0

    // Print result
    printReg    0

    MOV         X0, #0  // Return 0
    RET

.data
vecA:   .word 1, 2, 3, 4, 5, -6      // Vector A
        .align 4
vecB:   .word 6, 5, 4, 3, 2, 1      // Vector B
        .align 4
message: .asciz "Dot Product: %d\n" // Format string for printing
