// Exercise12.3
// Approximate sin x using taylor series sin x = x - x^3/3! + x^5/5! - x^7/7!

.include "debug.s"

.global main

// Function that calculates sine of an angle in radians
// Variables:
// output - output address register of sine result
// input - input address register of angle in radians
// Uses single precision
.MACRO  sin     output, input
    // S0 - output and build the output with +/-
    // S1 - to store result from division
    // S2 - result after cube (can be reused)
    // S3 - input x

    // Save S0-S3
    SUB         FP, SP, #16     // Allocate stack
    SUB         SP, SP, #16
    STP         S0, S1, [FP]    //Store at FP and FP+4
    STP         S2, S3, [FP, #8] // Store at FP+8 and FP+12

    // Load constants
    LDR         S4, constant_6
    LDR         S5, constant_120
    LDR         S6, constant_5040

    LDR         S3, [\input]    // Load input from memory

    FMOV        S0, S3          // output = x

    // Calculate x^3
    FMOV        S2, S3
    FMUL        S2, S2, S3
    FMUL        S2, S2, S3
    // Calculate x^3/3! and save to S1
    FDIV        S1, S2, S4
    // Add to output: sin x = x - x^3/3!
    FSUB        S0, S0, S1

    // Calculate x^5, reuse S2
    FMUL        S2, S2, S3
    FMUL        S2, S2, S3
    // Calculate x^5/5! and save to S1
    FDIV        S1, S2, S5
    // Add to output
    FADD        S0, S0, S1
    
    // Calculate x^7, reuse S2
    FMUL        S2, S2, S3
    FMUL        S2, S2, S3
    FDIV        S1, S2, S6
    FSUB        S0, S0, S1

    STR         S0, [\output]   // Save output into memory

    // Restore S0-S3
    LDP         S0, S1, [FP]
    LDP         S2, S3, [FP, #8]
    ADD         SP, SP, #16     // Free stack
    ADD         FP, SP, #16
.ENDM

.MACRO   printRes  angle, result
    // angle - pointer to the angle in angles array
    // result - label to result

    // Save X0-X2 because we call printf that destroys these
    SUB         FP, SP, #32     // Allocate stack
    SUB         SP, SP, #32
    STP         X0, X1, [FP]    // Save X0-X2
    STR         X2, [FP, #16]

    // Load from result
    LDR         S1, \result
    FCVT        D1, S1

    LDR         S0, [\angle]
    FCVT        D0, S0

    LDR         X0, =message    // Load message
    BL          printf      // Print

    LDP         X0, X1, [FP]   // Restore X0-X2
    LDR         X2, [FP, #16]
    ADD         SP, SP, #32    // Free stack
    ADD         FP, SP, #32
.ENDM

main:
    LDR         X1, =result  // Load result address into X1
    LDR         X2, =angles  // Load angle into X2

    sin         X1, X2          // Calculate sine of X2, put into result's address
    printRes    X2, result      // Print from memory

    ADD         X2, X2, #4
    //ADD         X2, X2, #4      // Increment result pointer to next
    sin         X1, X2          // Calculate sine of X2, put into result's address
    printRes    X2, result      // Print from memory

    MOV         X0, #0      // Use 0 return code
    MOV         X8, #93     // Service command code 93 terminates
    SVC         0           // Call Linux to terminate

.data
angles:     .single 1.5708, 3.1415
            .align 4
result:     .single 0
constant_6:  .single 6.0
constant_120: .single 120.0
constant_5040: .single 5040.0
message:    .asciz  "Sin %f = %f\n"
            .align 4
