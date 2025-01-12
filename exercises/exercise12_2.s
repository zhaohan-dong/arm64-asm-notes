// Exercise 12.2
// Integer division by 0

.global main

main:
    LDR     X1, =divisor
    LDR     X2, =denominator
    LDR     S1, [X1]
    LDR     S2, [X2]
    
    // Division
    FDIV    S0, S1, S2

    // Print
    FCVT    D0, S0
    FMOV    X1, D0
    LDR     X0, =result
    BL      printf

    // Exit
    MOV     X8, #93
    MOV     X0, #0          // Exit code 0
    SVC     #0              // Make syscall

.data
divisor:        .single 10
denominator:    .single 0
result:         .asciz "Division by zero result: %f\n"
                .align 4
