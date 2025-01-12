// Definiton for tolower function
// X0 has input string - first arg in C
// X1 has buffer to save the string to - second arg in C

// Assuming buffer is sufficiently large, otherwise we need a parameter of buffer length to prevent overflow

.global mytolower

mytolower:
    MOV     X3, X1 // Copy address from X1 to X3 for returning length in X0
loop:
    LDRB    W4, [X0], #1
    CMP     W4, #'A' // Compare the character with 'A'
    B.LT    cont
    CMP     W4, #'Z' // Compare the character with 'Z'
    B.GT    cont    
    // Here W4 must be upper case
convert:
    ADD	    W4, W4, #('a'-'A')

cont:
    STRB    W4, [X3], #1
    // Loop if W4 is not \0
    CMP     W4, #0
    B.NE    loop

    // Return the string length in X0
    SUB     X0, X3, X1
    RET
