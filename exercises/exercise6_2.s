// Exercise 6.2
// Prologue and epilogue for a function that uses X4, X5, W20, X23 and W27.
// Function also calls other functions

// Analysis:
// X4 and X5 are parameters, so caller expect corrupted value
// W20, X23 and W27 need to be saved first and restored before returning

exercise_func:
    // Save FP and LR because we call another function
    STP     FP, LR, [SP, #-16]!
    // Grow stack
    SUB     FP, SP, #32
    SUB     SP, SP, #32

    // Store callee registers
    STP     W20, W27, FP
    STR     X23, [FP, #8]

    // Do work
    STP     X4, X5, [FP, #16]

    // Call another function
    LDP     X4, X5, [FP, #16]

    // Restore callee registers before we return
    LDR     X23, [FP, #8]
    LDP     W20, W27, FP

    // Deallocate stack
    ADD     FP, SP, #32
    ADD     SP, SP, #32

    // Restore FP and LR
    LDP     FP, LR, [SP], #16

    RET