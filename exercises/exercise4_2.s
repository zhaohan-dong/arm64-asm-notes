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
    mov X1, #2
    
    // test if X1 is 1, and go to case1
    cmp X1, #1
    b.eq case1

    // test if X1 is 2, and go to case2
    cmp X1, #2
    b.eq case2
    
    // else go to elseclause
    b elseclause
case1:
    // Load one to print from X1
    ldr X1, =one
    mov X2, #4
    b continue  // Go to continue

case2:
    // Load two to print from X1
    ldr X1, =two
    mov X2, #4
    b continue  // Go to continue

elseclause:
    // Load else to print from X1
    ldr X1, =else
    mov X2, #5

// Continue and print it out to system
continue:
    // Set output to STDOUT
    mov X0, #1
    // Linux write
    mov X8, #64
    svc 0
    
    // Exit program with 0
    mov X0, #0
    mov X8, #93
    svc 0

.data
one: .ascii "one\n"
two: .ascii "two\n"
else: .ascii "else\n"
