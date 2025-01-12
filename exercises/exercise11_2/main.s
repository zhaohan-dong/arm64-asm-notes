// Exercise 11.2
// Signed 64-bit integer division that checks if denominator is zero
// Print error if zero

.include "division_check_zero.s"
.include "debug.s"

.global main

main:
    // Test if print not by zero is ok
    MOV         X1, #6
    MOV         X2, #-2
    printStr    "6 / -2 = "
    sdivision   X0, X1, X2
    printReg    0

    // Test print by zero
    MOV         X2, #0
    printStr    "6 / 0 = "
    sdivision   X0, X1, X2
    printReg    0

    MOV         X0, #0
    RET
