// Exercise 6.4
// Calling a tolower macro to convert text to all lower-case

// Sacrificing coupling for speed
// Keep using X1 as buffer register, so we don't need to move into X1 for print
// Keep using X3 as input register
// tolower returns length in X2, which can be directly used in print

.include "tolower.s"

.global _start

.MACRO      print
    // String length from is in X2 from tolower
    MOV     X0, #1  // Output to STDOUT
    MOV     X8, #64  // Write system call
    SVC     0  // Call interrupt
.ENDM

_start:
    // Use X1 as a constant for buffer
    LDR     X1, =buffer

    LDR     X3, =input1
    tolower X1, X3  // Implicitly return string length to X2
    print   // Print string with string length in X2 already

    LDR     X3, =input2
    tolower X1, X3  // Implicitly return string length to X2
    print   // Print string with string length in X2 already

    LDR     X3, =input3
    tolower X1, X3  // Implicitly return string length to X2
    print   // Print string with string length in X2 already

    // Exit with 0
    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
input1:     .asciz  "Hello World\n"
input2:     .asciz  "Hello—World!\n"
input3:     .asciz  "Th3 Qu!ck Br0wn F0x Jumps @Ov3r Th3 L@zy D0g!\n"
buffer:     .fill 255, 1, 0
