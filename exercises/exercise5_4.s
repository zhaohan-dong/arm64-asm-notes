// Exercise 5.4
// Convert any non-alphabetic character in a null-terminated string to a space

// X0-X2 for linux io
// X3 stores outstr
// X4 stores instr
// W5 stores each character during processing
// X6 to handle maximum allowed write buffer size
// X8 for setting linux system call

.global _start

_start:
    LDR     X4, =instr  // Load start mem addr of instr to X4
    LDR     X3, =outstr // Load start mem addr of outstr to X3
    MOV     X6, #255

loop:
    LDRB    W5, [X4], #1  // Load one byte from X4 into W5 and increment X4's memory address by 1

    subs    X6, X6, #1     // Decrease remaining buffer size
    B.LE    overflow // Exit loop if buffer limit is reached

    // Don't convert it if W5 is null or \n
    CMP     W5, #0
    B.EQ    cont
    CMP     W5, #'\n'
    B.EQ    cont

    // Convert if greater than z or less than A
    CMP     W5, #'z'
    B.GT    convert
    CMP     W5, #'A'
    B.LT    convert

    // W5 can only be A-z, so we place it
    b       cont

convert:
    // W5 is not an alphabet and we replace it with space
    MOV     W5, #' '
    // Continue after we have converted (A-z only skipped the convert part)
cont:
    STRB    W5, [X3], #1  // Store content of W5 to address pointed by X3, and increment X3 by 1
    // Continue the loop if W5 is not null
    CMP     W5, #0
    B.NE    loop
    B       end_conversion // End conversion

// Buffer overflow
overflow:
    // Overwrite second to last with '\n'
    MOV     W5, #'\n'
    STRB    W5, [X3, #-1]
    // Null-terminate the string
    MOV     W5, #0
    STRB    W5, [X3], #1

// Normal end conversion
end_conversion:
    // Display the outstr
    MOV     X0, #1 // Write to stdout
    LDR     X1, =outstr
    SUB     X2, X3, X1  // Calculate the length of string
    MOV     X8, #64 // Linux write
    SVC     0

    // Exit with 0
    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
instr:  .asciz "Please call (555) 123-4567 or email support@example.com for help. The event starts at 7:30 PM; don't forget your ID!\n"
outstr: .fill 255, 1, 0
