// Exercise 9.4 call to lower from C

#include <stdio.h>

extern int mytolower(char *, char *);

#define MAX_BUFFSIZE 255

int print_mytolower(int *len, char *str, char *outBuf) {
    *len = mytolower(str, outBuf);
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
