// Exercise 12.1
// Create a program to add the following
// 2.343 + 5.3  3.5343425445 + 1.534443455  3.14e12 + 5.55e-10 

.global main

main:
    
    LDR     X2, =pairs // Load calcuation pairs
    
    // First calculation
    LDP     S2, S3, [X2], #8 // Increment by a word to next single
    FADD    S1, S2, S3  // Calculate
// need to take the single precision return value
// and convert it to a double, because the C printf
// function can only print doubles.
    STR     X2, [SP, #-16]! // Save X2 address before calling printf
    // Print
    FCVT    D0, S1  // Convert result to double and move to X0 for %d
    LDR     X0, =message
    BL      printf
    LDR     X2, [SP], #16   // Restore X2
    
    LDP     S2, S3, [X2], #8 // Load numbers
    FADD    S1, S2, S3   // Calculate
    STR     X2, [SP, #-16]!  // Save X2 address before calling printf

    // Print
    FCVT    D0, S1  // Convert result to double and move to X0 for %d
    LDR     X0, =message
    BL      printf
    LDR     X2, [SP], #16   // Restore X2

    LDP     D2, D3, [X2], #16    // Load a double
    FADD    D0, D2, D3  // Calculate and store result into D0, to be substituded with %f
    LDR     X0, =message
    BL      printf

	MOV     X0, #0      // Use 0 return code
    MOV     X8, #93     // Service command code 93 terminates
    SVC     0           // Call Linux to terminate

.data

pairs:      .single 2.343, 5.3
            .single 3.5343425445, 1.534443455
            .double 3.14e12, 5.55e-10

message:    .asciz "Result: %f\n"
            .align 4
