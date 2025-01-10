// Exercise 6.3
// Calling a tolower function to convert text to all lower-case

.global _start

.MACRO      print   buffer, length_register
    MOV     X2, \length_register  // String length from is in length_register
    MOV     X0, #1  // Output to STDOUT
    LDR     X1, =\buffer // Print from buffer
    MOV     X8, #64  // Write system call
    SVC     0  // Call interrupt
.ENDM

_start:
    LDR     X1, =buffer
    LDR     X2, =input1
    BL      tolower
    print   buffer, X0

    LDR     X1, =buffer
    LDR     X2, =input2
    BL      tolower
    print   buffer, X0

    LDR     X1, =buffer
    LDR     X2, =input3
    BL      tolower
    print   buffer, X0

    // Exit with 0
    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
input1:     .asciz  "Hello World\n"
input2:     .asciz  "Hello—World!\n"
input3:     .asciz  "Th3 Qu!ck Br0wn F0x Jumps @Ov3r Th3 L@zy D0g!\n"
buffer:     .fill 255, 1, 0
