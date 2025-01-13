// Exercise 2.7: substract two numbers

.global _start

// Load first number to registers
_start:
    MOV     X3, #0xf7a9
    MOVK    X3, #0xc1d4, LSL #16
    MOVK    X3, #0xa6b3, LSL #32
    MOVK    X3, #0x78e2, LSL #48
    MOV     X4, #0xe1b3
    MOVK    X4, #0xa7c9, LSL #16
    MOVK    X4, #0xd3f5, LSL #32
    MOVK    X4, #0xe2b1, LSL #48
    MOV     X5, #0xd6f8
    MOVK    X5, #0xe2b4, LSL #16
    MOVK    X5, #0xa8c0, LSL #32
    MOVK    X5, #0xd4f6, LSL #48
// Load second number to registers
    MOV     X6, #0xf68a
    MOVK    X6, #0xb2d4, LSL #16
    MOVK    X6, #0x7e90, LSL #32
    MOVK    X6, #0x3a5c, LSL #48
    MOV     X7, #0xc2e4
    MOVK    X7, #0xf8a0, LSL #16
    MOVK    X7, #0xb4d6, LSL #32
    MOVK    X7, #0xc0e2, LSL #48
    MOV     X8, #0xe90b
    MOVK    X8, #0xa5c7, LSL #16
    MOVK    X8, #0xd1f3, LSL #32
    MOVK    X8, #0xf7b9, LSL #48

    SUBS    X2, X5, X8
    SBCS    X1, X4, X7
    SBC     X0, X3, X6

    MOV     X8, #93
    SVC     0
    