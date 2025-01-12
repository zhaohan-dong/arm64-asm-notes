from ctypes import CDLL, c_char_p, c_int, create_string_buffer

liblower = CDLL("liblow.so")
liblower.mytolower.argtypes = [c_char_p, c_char_p]
liblower.mytolower.restype = c_int

inStr = create_string_buffer(250)
outStr = create_string_buffer(250)

def print_tolower(test_string: str):
    inStr.value = test_string.encode('utf-8')
    len: int = int(liblower.mytolower(inStr, outStr))
    print(test_string)
    print(outStr.value.decode('utf-8'))
    print(len)


def main():
    len: int = int(liblower.mytolower(inStr, outStr))
    print_tolower("This is a test!")
    print_tolower("Étudié À Paris!")
    print_tolower("Hello, WORLD! 123 @#$")

if __name__ == "__main__":
    main()
