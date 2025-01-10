// Exercise 2.7: substract two numbers

.global _start

// Load first number to registers
_start: mov X3, #0xf7a9
    movk X3, #0xc1d4, lsl #16
    movk X3, #0xa6b3, lsl #32
    movk X3, #0x78e2, lsl #48
    mov X4, #0xe1b3
    movk X4, #0xa7c9, lsl #16
    movk X4, #0xd3f5, lsl #32
    movk X4, #0xe2b1, lsl #48
    mov X5, #0xd6f8
    movk X5, #0xe2b4, lsl #16
    movk X5, #0xa8c0, lsl #32
    movk X5, #0xd4f6, lsl #48
// Load second number to registers
    mov X6, #0xf68a
    movk X6, #0xb2d4, lsl #16
    movk X6, #0x7e90, lsl #32
    movk X6, #0x3a5c, lsl #48
    mov X7, #0xc2e4
    movk X7, #0xf8a0, lsl #16
    movk X7, #0xb4d6, lsl #32
    movk X7, #0xc0e2, lsl #48
    mov X8, #0xe90b
    movk X8, #0xa5c7, lsl #16
    movk X8, #0xd1f3, lsl #32
    movk X8, #0xf7b9, lsl #48

    subs X2, X5, X8
    sbcs X1, X4, X7
    sbc  X0, X3, X6

    mov X8, #93
    svc 0
    