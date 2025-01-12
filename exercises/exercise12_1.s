// Exercise 12.1
// Create a program to add the following
// 2.343 + 5.3  3.5343425445 + 1.534443455  3.14e12 + 5.55e-10 


.global main

main:
    LDR     X2, =pairs
    LDP     S2, S3, [X2], #8 // Increment by a word to next single
    FADD    S1, S2, S3
// need to take the single precision return value
// and convert it to a double, because the C printf
// function can only print doubles.
    FCVT    D0, S1
    STR     X2, [SP, #-16]! // Save X2 address before calling printf
    // Print
    FMOV    X1, D0
    LDR     X0, =message
    BL      printf
    LDR     X2, [SP], #16   // Restore X2
    
    LDP     S2, S3, [X2], #8 // Load numbers
    FADD    S1, S2, S3   // S1 = 3.5343425445 + 1.534443455
    FCVT    D0, S1       // Convert single to double
    STR     X2, [SP, #-16]!  // Save X2 address before calling printf
    // Print
    FMOV    X1, D0
    LDR     X0, =message
    BL      printf
    LDR     X2, [SP], #16   // Restore X2

    LDP     D2, D3, [X2], #16    // Load a double
    FADD    D1, D2, D3
    FMOV    X1, D1
    LDR     X0, =message
    BL      printf

    MOV     X8, #93
    MOV     X0, #0          // Exit code 0
    SVC     #0              // Make syscall

.data

pairs:      .single 2.343, 5.3
            .single 3.5343425445, 1.534443455
            .double 3.14e12, 5.55e-10

message:    .asciz "Result: %lf\n"
            .align 4
