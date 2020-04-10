;Read numbers x,y,z,w, calculate (x+y)-(z+w) and print the result.

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
number3 DWORD   ?
number4 DWORD   ?

sum1    DWORD   ?
sum2    DWORD   ?

prompt1 BYTE    "Enter X:  ", 0
prompt2 BYTE    "Enter Y:  ", 0
prompt3 BYTE    "Enter W:  ", 0
prompt4 BYTE    "Enter Z:  ", 0
string  BYTE    40 DUP (?)
label1  BYTE    cr, Lf, "The result is "

result  BYTE    11 DUP (?)
        BYTE    cr, Lf, 0



.CODE                           ; start of main program code
_start:
        output  prompt1         ; prompt for X
        input   string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     number1, eax    ; store in memory

        output  prompt2         ; repeat for Y
        input   string, 40
        atod    string
        mov     number2, eax

        mov     eax, number1    ; X to EAX
        add     eax, number2    ; add Y sum
        mov    sum1, eax       ; store in memory

        output  prompt3         ; repeat for W
        input   string, 40      
        atod    string          
        mov     number3, eax    

        output  prompt4         ; prompt for Z
        input   string, 40      
        atod    string          
        mov     number4, eax   

        mov     eax, number3    ; w to EAX 
        add     eax, number4    ; add Z
        mov    sum2, eax       ; store in memory
        
        mov     eax, sum1       ; first sum1 to EAX
        sub     eax, sum2       ; sub second sum2
        dtoa    result, eax     ; convert to ASCII characters
        output  label1          ; output label and sum              ;need to verify


        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code

