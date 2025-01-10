# Note and Exercises from Programming with 64-Bit ARM Assembly Language (2020)

# Set Registers
## Shifting bits
- `LSL #nbits` Logical shift left by `nbits`.
- `LSR #nbits` Logical shift right by `nbits`.
- `ASR #nbits` Arithmetic shift right by `nbits`, keeping signed bit on the left.
- `ROR #nbits` Rotate right by `nbits`.

## Move value into register
`MOV` can move into register only 16-bit at a time. So to load a 64-bit value, we need to shift a maximum of 4 times with `MOVK`.

`MOV  Xd, #imm16` moves `imm16` into `Xd`<br/>
`MOVK Xd, #imm16` moves `imm16` into `Xd` while keeping original data in `Xd`<br/>
`MOVK Xd, #imm16, LSL #4` logical shift left `imm16` by 4-bits<br/>
`MOVN Xd, #imm16` moves logical NOT of `imm16` into `Xd`

# Condition
> Condition is bad for performance!
## Comparison
Usually `CMP` comparing two registers by substraction.<br/>
`CMN`: Uses addition instead of subtraction.<br/>
`TST`: Performs a bitwise AND operation between Xn and Operand2.


## Branching
Comparisons, `ADDS`/`SUBS`, or `S`-variant logical operators sets the `NZCV` register (`CPSR` in ARM) used for branching.

https://developer.arm.com/documentation/100069/0606/Condition-Codes/Condition-code-suffixes-and-related-flags

| Suffix | Flags                | Meaning                                      |
|--------|----------------------|----------------------------------------------|
| EQ     | Z set                | Equal                                        |
| NE     | Z clear              | Not equal                                    |
| CS or HS | C set              | Higher or same (unsigned >=)                 |
| CC or LO | C clear            | Lower (unsigned <)                           |
| MI     | N set                | Negative                                     |
| PL     | N clear              | Positive or zero                             |
| VS     | V set                | Overflow                                     |
| VC     | V clear              | No overflow                                  |
| HI     | C set and Z clear    | Higher (unsigned >)                          |
| LS     | C clear or Z set     | Lower or same (unsigned <=)                  |
| GE     | N and V the same     | Signed >=                                    |
| LT     | N and V differ       | Signed <                                     |
| GT     | Z clear, N and V the same | Signed >                        |
| LE     | Z set, N and V differ| Signed <=                                    |
| AL     | Any                  | Always. This suffix is normally omitted.     |

```asm
CMP X1, X2 // Or SUBS X2, X2, #1, which means testing if X2 reaches 0

// Use comparison value stored in NZCV register to determine condition
B.{condition} branch_name

cont:
// continue

branch_name:
// Do some work in branch
B cont // Go to cont
```

## Looping
```asm
// W2-- until W2 is 0
loop:
    SUBS W2, W2, #1  // Note the S at the end of SUBS
    B.NE loop  // Go to loop if not equal
```

# Logical Operators
`AND` is useful for masking bits with Operand2, `ORR` is useful for setting bits.

`S` variant sets the `NZDV` register.

```asm
AND{S} Xd, Xs, Operand2  // Bitwise AND between Xs and Operand2
EOR{S} Xd, Xs, Operand2  // Bitwise XOR between Xs and Operand2
ORR{S} Xd, Xs, Operand2  // Bitwise OR between Xs and Operand2
BIC{S} Xd, Xs, Operand2  // Bitwise Xs AND NOT Operand2
```


# Macro and Function

Two ways of importing:
- Include: In main, use `.include "file.s"`. The file won't need to be assembled to `.o` file.
- Assemble then link:
    `.global func_name` makes `func_name` function available for other programs.<br/>
    Only one program can be called `_start`.<br/>

## Macro
> Good for performance, bad for conserving memory.<br/>Inserts copy of the code at every point used, so no need to push/pop stack.

Example:
```asm
.MACRO macroname parameter1, parameter2,...
2:
    // Some work
    B.NE 2b
    B 1f
    // ...
1:
    // Some other work
.ENDM
```
If macro is used multiple times, duplicate text labels will create conflict. ARM allows using duplicate numeric labels like 1, 2, 3...

e.g.:
- `2b` - label 2 in backward direction
- `1f` - label 1 in forward direction

## Function
> Bad for performance, good for conserving memory. Usually needs to push/pop stack when calling.

`BL func_name` calls the `func_name` function.
`RET` in the function returns with result in `X0` register.

Registers:
- `X0-X7` - Argument registers. Function parameters that can be used by the function.
- `X0-X18` might be corrupted after running the function, so any value must be **saved to stack before calling function**.
- `X19-X30` - Callee-saved registers. Caller assumes they stay unchanged. If used by the function, must be **saved within the function and restored before return**.
- `LR` stores where the next instruction is after function, so must be saved to stack if calling a nested function within the function.
    - Calling `RET` resumes from current `LR` pointed instruction.
> See Page 143 ARM 64 assembly book

# Memory Access
## Load and store register from memory
Square bracket on `[X0]` signifies load from the memory address stored in X0, not the register content of X0.<br/>
Even though the stack grows downward, the memory save and load instructions access low -> high memory address.
```asm
// load the address of mynumber into X1
LDR X1, =mynumber

// load the word stored at mynumber into X2
LDR X2, [X1]

.data
mynumber: .QUAD 0x123456789ABCDEF0 
```
To load types other than word or quad, and pad correctly:
```asm
LDR{type} Xt, [Xa] 
```
Type can be one of the following:

| Type | Meaning                |
|------|------------------------|
| B    | Unsigned byte          |
| SB   | Signed byte            |
| H    | Unsigned halfword (16 bits) |
| SH   | Signed halfword (16 bits)   |
| SW   | Signed word            |

## Index change while loading/saving
- Pre-indexing:<br/>
    `STP LR, FP, [SP, #-16]!`<br/>
    > Memory address updated
    1. `SP` is first updated to `SP = SP - 16`
    2. Then `LR` and `FP` are stored in increasing memory address from the new `SP` address (`LR -> [SP]` and `FP -> [SP + #8]`)

- Post-indexing:<br/>
    `LDR LR, FP, [SP], #16`<br/>
    > Memory accessed first
    1. `LR` and `FP` are loaded from `SP` and `SP + 8`
    2. Then SP is updated to `SP = SP + 16` after the memory operation

Example:
```asm
// Assume X0 = 0x1000
// Load memory content from 0x1000 + 16 = 0x1010 to 0x1017
LDR X1, [X0, #16]

// Update X0 to 0x1010, then load memory content from 0x1010 to 0x1017
LDR X1, [X0, #16]!

// Load memory from 0x1000-0x1008, then update X0 to 0x1010
LDR X1, [X0], #16

// Similarly for STR operations
```

## Stack and Stack Frame

Stack Pointer (SP) grows downwards by 16 byte aligned on ARM. Non-16-byte aligned address will crash.
> Wastes memory if variables are not using all 16-byte, can be addressed by using Frame Pointer (FP)

> Note there seems to be discrepancy between what is described in the book and online about whether FP should match SP or be at an offset. Here we follow the book. See [this StackOverflow Discussion](https://stackoverflow.com/questions/66143047/is-it-valid-for-the-stack-pointer-and-frame-pointer-to-point-to-the-same-address).

<img src="assets/stackframe.png" />

`X29` register is aliased as Frame Pointer (FP), and set address relative to FP

```asm
// Assume SP = 0x1000

// Positive memory offsets relative to FP
.EQU    VAR1, 0
.EQU    VAR2, 4
.EQU    SUM,  8

SUB   FP, SP, #16
SUB   SP, SP, #16
// Now FP == SP are both 0x0FF0
// Address 0x0FF0 - 0x0FFF can be used

LDR W4, [FP, #VAR1]  // W4 loads from 0x0FF0
LDR W5, [FP, #VAR2]  // W5 loads from 0x0FF4
SUM W6, W4, W5
STR W6, [FP, #SUM]   // Store sum at 0x0FF8
```

Save LR and previous program's FP with the first 16-byte:
<img src="assets/stackframe2.png" />
```asm
// Assume SP = 0x1000, Old FP = 0x1000

// Positive memory offsets relative to FP
.EQU    VAR1, 0
.EQU    VAR2, 4
.EQU    SUM,  8

// Store old FP and LR pair, now SP at 0x0FF0
STP   FP, LR, [SP, #-16]!

// Allocate stack
SUB   FP, SP, #16
SUB   SP, SP, #16
// Now FP == SP are both 0x0FE0
// Address 0x0FE0 - 0x0FF0 can be used

LDR W4, [FP, #VAR1]  // W4 loads from 0x0FE0
LDR W5, [FP, #VAR2]  // W5 loads from 0x0FE4
SUM W6, W4, W5
STR W6, [FP, #SUM]   // Store sum at 0x0FE8

// Free Stack
ADD   FP, SP, #16
ADD   SP, SP, #16
// Now FP == SP are both 0x0FF0

// Restore old FP and LR pair, now SP at 0x1000
LDP   FP, LR, [SP], #16
```