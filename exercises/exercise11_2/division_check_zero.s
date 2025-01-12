// Check if denominator is zero before signed division
// 64-bit

// result_reg is the result register
// divisor_reg is the divisor number register
// denominator_reg is the denominator number register
// Prints to stderr but still returns 0 because it is signed division

.MACRO      sdivision  result_reg, divisor_reg, denominator_reg
    CMP     \denominator_reg, #0
    B.NE    1f

    // Division by zero error
    // Print error
    MOV     X0, #2  // Print to stderr
    LDR     X1, =2f
    MOV     X2, #24
    MOV     X8, #64
    SVC     0
    
    MOV     \result_reg, #0 // Return 0 even with error, as it is signed division and we can't use a negative number
    B       3f  // Exit
1:
    // Perform division here
    SDIV    \result_reg, \divisor_reg, \denominator_reg
    B       3f  // Exit
2:  .asciz  "Error: Division by Zero\n"
    .align  4
3:
.ENDM
