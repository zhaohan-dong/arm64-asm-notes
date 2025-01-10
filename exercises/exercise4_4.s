// Exercise 4.4
// Modified printword to print 32-bit W register
// Assembler program to print a register in hex
// to stdout.
//
// X0-X2 - parameters to linux function services
// X1 - is also address of byte we are writing
// W4 - register to print
// W5 - loop index
// W6 - current character
// X8 - linux function number
//

.global _start	 // Provide program starting address

_start: MOV	W4, #0x6E3A
	MOVK	W4, #0x4F5D, LSL #16

	LDR	X1, =hexstr // start of string
	ADD	X1, X1, #9	    // start at least sig digit
// The loop is FOR W5 = 8 TO 1 STEP -1
	MOV	W5, #8	    // 8 digits to print
loop:	AND	W6, W4, #0xf // mask of least sig digit
// If W6 >= 10 then goto letter
	CMP	W6, #10	    // is 0-9 or A-F
	B.GE	letter
// Else its a number so convert to an ASCII digit
	ADD	W6, W6, #'0'
	B	cont	// goto to end if
letter: // handle the digits A to F
	ADD	W6, W6, #('A'-10)
cont:	// end if
	STRB	W6, [X1]	// store ascii digit
	SUB	X1, X1, #1		// decrement address for next digit
	LSR	W4, W4, #4	// shift off the digit we just processed

	// next W5
	SUBS	W5, W5, #1		// step W5 by -1
	B.NE	loop		// another for loop if not done

// Setup the parameters to print our hex number
// and then call Linux to do it.
	MOV	X0, #1	    // 1 = StdOut
	LDR	X1, =hexstr // string to print
	MOV	X2, #11	    // length of our string
	MOV	X8, #64	    // linux write system call
	SVC	0 	    // Call linux to output the string

// Setup the parameters to exit the program
// and then call Linux to do it.
	MOV     X0, #0      // Use 0 return code
        MOV     X8, #93     // Service command code 93 terminates this program
        SVC     0           // Call linux to terminate the program

.data
hexstr:      .ascii  "0x12345678\n"

