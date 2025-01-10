// Exercise 5.3
// Convert a string to all lower-case.
// Note: lower-case chars have higher value than upper-case

.global _start

_start:
    ldr	X4, =instr // Input string address
    ldr X3, =outstr // Output string address
loop:
    ldrb W5, [X4], #1  // load character and increment pointer X4
    cmp W5, #'A' // Compare the character with 'A'
    b.lt cont // W5 < 'A', we put the character back without converting
    cmp W5, #'Z' // Compare with 'Z'
    b.gt cont // W5 > 'Z', we put the character back without converting
    // letter in W5 is upper-case
    add	W5, W5, #('a'-'A')
cont:
    strb W5, [X3], #1 // store character to X3 and increment pointer X3
    // Compare W5 with null, if it is null, we have hit the end
    cmp	W5, #0
    b.ne loop

// Setup the parameters to print our hex number
// and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, =outstr // string to print, X3 now points to one address after end of the string
	SUB	X2, X3, X1  // get the length by subtracting the pointers
	MOV	X8, #64	    // linux write system call
	SVC	0 	    // Call Linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
	MOV     X0, #0      // Use 0 return code
        MOV     X8, #93     // Service code 93 terminates
        SVC     0           // Call Linux to terminate the program

.data
.align 4
instr:  .asciz  "This is our Test String that we will convert.\n"
.align 4
outstr:	.fill	255, 1, 0