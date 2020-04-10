;Read numbers x, y and prints x+y, x-y, x*y, x/y and x%y.

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
number1 DWORD   ?
number2 DWORD   ?
prompt1 BYTE    "Enter X:  ", 0
prompt2 BYTE    "Enter Y:  ", 0
string  BYTE    40 DUP (?)
label1  BYTE    cr, Lf, "The sum is "
sum     BYTE    11 DUP (?)
        BYTE    cr, Lf, 0

label2  BYTE    cr, Lf, "X - Y = "
diff    BYTE    11 DUP (?)
        BYTE    cr, Lf, 0

label3  BYTE    cr, Lf, "X * Y = "
prod    BYTE    11 DUP (?)
        BYTE    cr, Lf, 0

label4  BYTE    cr, Lf, "X / Y = "
quo     BYTE    11 DUP (?)
        BYTE    cr, Lf, 0

label5  BYTE    cr, Lf, "X % Y = "
rem     BYTE    11 DUP (?)
        BYTE    cr, Lf, 0


.CODE                           ; start of main program code
_start:
        output  prompt1         ; prompt for first number
        input   string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     number1, eax    ; store in memory

        output  prompt2         ; repeat for second number
        input   string, 40
        atod    string
        mov     number2, eax
        
        mov     eax, number1    ; first number to EAX
        add     eax, number2    ; add second number
        dtoa    sum, eax        ; convert to ASCII characters
        output  label1          ; output label and sum

        mov     eax, number1    ; first number to EAX
        sub     eax, number2    ; subtract second number
        dtoa    diff, eax       ; convert to ASCII characters
        output  label2          ; output label and subtracti

        mov     eax, number1    ; first number to EAX
        imul    number2         ; multiple second number
        dtoa    prod, eax       ; convert to ASCII characters
        output  label3          ; output label and multiplication

        mov     eax, number1    ; first number to EAX
        cdq    
        idiv    number2         ; add second number
        dtoa    quo, eax        ; convert to ASCII characters
        output  label4          ; output label and sum

        dtoa rem, edx           ; convert to ASCII characters
        output label5           


        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code

