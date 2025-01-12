// Exercise 9.6
// Embed asm in C

#include <stdio.h>

#define MAX_BUFFSIZE 255

int print_mytolower(int *len, char *str, char *outBuf) {
    __asm__ volatile(
        "mov    X3, %2\n"
        "loop:\n"
        "LDRB   W4, [%1], #1\n"
        "CMP    W4, #'A'\n"
        "B.LT   cont\n"
        "CMP    W4, #'Z'\n"
        "B.GT   cont\n"
        "ADD    W4, W4, #('a'-'A')\n"
        "cont:\n"
        "STRB   W4, [%2], #1\n"
        "CMP    W4, #0\n"
        "B.NE   loop\n"
        "SUB    %0, %2, X3\n"
        : "=r"(*len)
        : "r"(str), "r"(outBuf)
        : "r3", "r4");

    printf("Before str: %s\n", str);
    printf("After str: %s\n", outBuf);
    printf("Str len = %d\n", *len);
}

int main() {
    char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];
    int len;

    print_mytolower(&len, str, outBuf);
    str = "Étudié À Paris!";
    print_mytolower(&len, str, outBuf);
    str = "Hello, WORLD! 123 @#$";
    print_mytolower(&len, str, outBuf);

    return (0);
}
