// Exercise 14.2
// Condition with CSINC


// Loop five times (i=0; i<5; i++)

.global main

main:
    MOV     X1, XZR  // Set loop counter to start from 0

loop:
    // Print the result from loop
    CSINC   X1, X1, X1, GE   // Increment X1 if it's less than 5; if not, keep X1 as is
    CMP     X1, #5           // Compare X1 with 5
    B.LT    loop             // Loop if X1 < 5

    LDR     X0, =message
    MOV     X2, X1           // Move loop counter to X2 for printf
    BL      printf           // Call printf

    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
message:    .asciz "Loop executed %d times\n"
