// Exercise 4.2
// SELECT number
// CASE 1: 
// << statements if number is 1 >>
// CASE 2:
// << statements if number is 2>>
// CASE ELSE:
// << statements if not any other case >>
// END SELECT 

// X1 - store the number

.global _start

_start:
    // Enter the test value into X1 (can be any)
    MOV     X1, #2
    
    // test if X1 is 1, and go to case1
    CMP     X1, #1
    B.EQ    case1

    // test if X1 is 2, and go to case2
    CMP     X1, #2
    B.EQ    case2
    
    // else go to elseclause
    B       elseclause
case1:
    // Load one to print from X1
    LDR     X1, =one
    MOV     X2, #4
    B       continue  // Go to continue

case2:
    // Load two to print from X1
    LDR     X1, =two
    MOV     X2, #4
    B       continue  // Go to continue

elseclause:
    // Load else to print from X1
    LDR     X1, =else
    MOV     X2, #5

// Continue and print it out to system
continue:
    // Set output to STDOUT
    MOV     X0, #1
    // Linux write
    MOV     X8, #64
    SVC     0
    
    // Exit program with 0
    MOV     X0, #0
    MOV     X8, #93
    SVC     0

.data
one: .ascii "one\n"
two: .ascii "two\n"
else: .ascii "else\n"
