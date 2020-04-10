;Read a number n, calculate the value of 1*1+2*2+...+n*n and print the result.

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
number1 DWORD   ?
prod    DWORD   ?
sum1    DWORD   ?

prompt1 BYTE    "Please enter number:  ", 0
string  BYTE    40 DUP (?)
label1  BYTE    cr, Lf, "The result is "
result  BYTE    11 DUP (?)
        BYTE    cr, Lf, 0

.CODE                           ; start of main program code
_start:
        output  prompt1         ; prompt for first number
        input   string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     ebx, eax        ; store in memory

        mov ecx, 1   

loop1:  cmp ecx, ebx
        jnle finish

        mov eax, ecx
        mul ecx

        mov prod, eax
        mov eax, sum1
        add eax, prod
        mov sum1, eax
        inc ecx
        jmp loop1
       
finish: dtoa    result, eax        ; convert to ASCII characters
        output  label1          ; output label and sum
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code

