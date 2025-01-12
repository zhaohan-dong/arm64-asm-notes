// Dot product
// Might be undefined if input1 or input2 is not of dimension length

// input1 is register holding first vector address
// input2 is register holding second vector address
// output is output result vector
// dimension holds the dimension


.MACRO  dotproduct  output, input1, input2, dimension
    // We use dimension as counter
    MOV     \output, #0  // Initialize output to 0
    STP     X4, X5, [SP, #-16]! // Registers used for loading inputs
1:
    // Subtract dimension by 1 and if that < 0, we quit
    SUBS    \dimension, \dimension, #1
    B.LT    2f
    // Do product of one element and accumulate
    LDR     W4, [\input1], #4
    LDR     W5, [\input2], #4
    SMADDL  \output, W4, W5, \output
    B       1b      // Go back to loop begin
2:
    // Restore X4 and X5, then exit
    LDP     X4, X5, [SP], #16
.ENDM
