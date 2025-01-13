// Exercise 12.2
// Integer division by 0

.global main

main:
    LDR     S1, divisor      // Load divisor value into S1
    LDR     S2, denominator  // Load denominator value into S2
    
    // Division
    FDIV    S0, S1, S2

    // Print
    FCVT    D0, S0      // Convert to double precision, and print the %f from D0
    LDR     X0, =result
    BL      printf

    // Exit
	MOV     X0, #0      // Use 0 return code
    MOV     X8, #93     // Service command code 93 terminates
    SVC     0           // Call Linux to terminate

.data
divisor:        .single 10
denominator:    .single 0
result:         .asciz "Division by zero result: %f\n"
                .align 4
