// Exercise 6.1
// A hypothetical stack grows upwards
// Do not run as this might corrupt other program's stack

// X0, X1, X2 are hypothetical function parameters

.global _start

_start:
    MOV X0, #0
    MOV W1, #1
    MOV W2, #2
    // Call function
    BL func

    MOV X0, #0
    MOV X8, #93 // Exit
    SVC 0

// Function that allocates memory on the stack upwards
func:
    // Stack pointer grows up 16-bit to accomodate FP and LR from SP up
    STP FP, LR, [SP], #16
    // Allocate stack for function
    ADD FP, SP, #16  // Increase FP by 16
    ADD SP, SP, #16  // Increase SP by 16
    STR W1, [FP, #-4]  // Save from W1 to FP - 4
    STR W2, [FP, #-8]  // Save from W2 to FP - 8
    LDR W1, [FP, #-4]
    LDR W2, [FP, #-8]
    // Deallocate stack
    SUB FP, SP, #16
    SUB SP, SP, #16
    // Restore FP and LR
    LDP FP, LR, [SP, #-16]!

    RET // return
