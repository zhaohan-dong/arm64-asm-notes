// Definiton for tolower macro
// buffer is buffer register
// input is input register (should be X3)
// Return length of buffer in X2

// Uses X4, W5 for calculation and X2 for return

// Assuming buffer is sufficiently large, otherwise we need a parameter of buffer length to prevent overflow

.MACRO      tolower     buffer, input
    MOV     X4, \buffer // Copy address from buffer to X4 for returning length in X0

2:
    LDRB    W5, [\input], #1
    CMP     W5, #'A' // Compare the character with 'A'
    B.LT    1f
    CMP     W5, #'Z' // Compare the character with 'Z'
    B.GT    1f
    // Here W4 must be upper case
    ADD	    W5, W5, #('a'-'A')

1:
    STRB    W5, [X4], #1
    // Loop if W4 is not \0
    CMP     W5, #0
    B.NE    2b

    // Return the string length in X2
    SUB     X2, X4, \buffer
.ENDM
