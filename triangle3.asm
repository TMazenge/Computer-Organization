; Read a number n and print an unside down triangle with n rows. 

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data

number1 DWORD   ?
prompt1 BYTE    "Enter number:  ", 0
string  BYTE    40 DUP (?)
star    BYTE    "*", 0
newline BYTE    cr, Lf, 0
.CODE                           ; start of main program code
_start:
        output  prompt1         ; prompt for first number
        input   string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        
        mov ebx, eax
loop1:  cmp ebx, 0
        je finish

        mov ecx, ebx
        mov edx, 0

loop2:  output star
        loop loop2
        output newline

        dec ebx
        jmp loop1

finish:
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code

