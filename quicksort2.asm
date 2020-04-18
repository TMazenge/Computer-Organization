; This program will generate an array of 
; random numbers. Using quicksort to sort it and then 
; print sorted array
; 

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
lf     EQU     0ah     ; line feed
tb      EQU		09h		; tab

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
seed	DWORD 143562311
a		DWORD 112398323
b 		DWORD 98423322
q       DWORD 312984527
array	DWORD 10240 DUP(?)

n 		DWORD   ?
prompt1 BYTE    "Enter a number:  ", 0
string  BYTE    40 DUP (?)
outputBuf  BYTE    11 DUP (?)
newline    BYTE    cr, Lf, 0
sep     BYTE tb, 0
nPerline Dword 10

.CODE                           ; start of main program code
_start:
        output  prompt1         ; prompt for first number
        input   string, 40      ; read ASCII characters
        atod    string          ; convert to integer
		mov n, eax
		
		mov ecx, n
		lea edi, array
		call genRandArray
		
		mov ecx, n
		lea esi, array
		call printArray

		; call quicksort procedure
		; quicksort(array, 0, n-1)
		lea esi, array
		mov eax, 0
		mov ebx, n
		dec ebx
		call quicksort

		mov ecx, n
		lea esi, array
		call printArray
		

		; output label and sum
        INVOKE  ExitProcess, 0  ; exit with return code 0

quicksort PROC near32
	pushad ;eax, ecx, edx, ebx, esp, ebp, esi, edi
	mov ebp, esp
	;def quicksort(arr, low, high):
	;	if low>=high:
    ;	    return
    ;	pivot = partition(arr, low, high)
    ;	quicksort(arr, low, pivot-1)
    ;	quicksort(arr, pivot+1, high)
	
	; arr: esi
	; low: eax
	; high: ebx
	cmp eax, ebx ;compare low and high
	jge qfinish
	
	call partition 
	
	; edx: pivot
	mov ebx, edx ;set high=pivot
	dec ebx 
	call quicksort
	
	mov eax, edx
	inc eax
	mov ebx, [ebp+16] ; move the old ebx(high) into ebx
	call quicksort
	
qfinish:	
	popad
	ret
quicksort ENDP

partition PROC near32
	pushad
	mov ebp, esp
  ;def partition (arr, low, high):
    ;pivot = arr[high]  
    ;i = low 
    ;for j in range(low, high+1): 
    ;    if (arr[j] < pivot):
    ;        temp =arr[i] 
    ;        arr[i] = arr[j]
    ;        arr[j] = temp
    ;        i+=1
    ;temp = arr[i] 
    ;arr[i] = arr[high]
    ;arr[high] = temp
    ;return i
	
	; arr: esi
	; low: eax
	; high: ebx
	; return value: edx
	; i: ecx
	; j: edx
	; pivod: edi
	mov edi, [esi+ebx*4] ;pivot = arr[high]
	
	mov ecx, eax
	; for (j=low, j<=high, j++)
	mov edx, eax
ploop:
	cmp edx, ebx
	jnle pfin1
	cmp edi, [esi+edx*4] ; arr[j]
	jng pfin2
	
	; from now, eax: temp
	mov eax, [esi+ecx*4]
	push [esi+edx*4] ; arr[j]
	pop [esi+ecx*4]  ; arr[i]
	mov [esi+edx*4], eax
	inc ecx
pfin2:
	inc edx
	jmp ploop	
pfin1:	
	; swap array[i] and arr[high]
	mov eax, [esi+ecx*4]
	push [esi+ebx*4] 
	pop [esi+ecx*4] ;arr[i]
	mov [esi+ebx*4], eax
	
	mov  [ebp+20], ecx	;mov ecx to the stack location for edx
	
	popad
	ret
partition ENDP
		
printArray PROC near32
		; ecx: count. 
		; esi: location of array
		pushad
		mov ebp, esp
		mov ebx, nPerline  ;ebx is a counter to decide if we need to start a new line.
paLoop:
		mov eax, [esi]
		call print
		output sep
		add esi,4
		dec ebx
		jnz paContinute
		mov ebx, nPerline
		output newline
paContinute:
		loop paLoop
		output newline
		popad
		ret
printArray ENDP		

genRandArray PROC near32
		; this procedure will generate an array of random number
		; ecx: the size of the array
		; edi: the location of the array
		pushad
		mov ebp, esp
rlLoop: mov eax, [ebp+28]
		call random
		mov [edi], eax
		add edi, 4
		loop rlLoop
		popad
		ret
genRandArray ENDP		
		
random PROC near32
		; this procedure will return a random number
		; eax will carry the returned value.
		pushad
		mov ebp, esp
		
		; calculate (a*seed+b)%q
		mov eax, a
		mul seed
		; result  in edx:eax
		add eax, b
		adc edx, 0
		div q
		; eax: quotient. edx: remainder, seed		
		mov seed, edx
		
		mov eax, edx ; we will divide seed by 1000. The remainder will be the 
		mov edx, 0  ; random number to be returned.
		mov ebx, 1000
		div ebx
		mov [EBP+28], edx
		
		popad
		ret
random ENDP


print PROC near32
		pushad
		mov ebp, esp
		lea edi, outputBuf
		cmp eax,0
		jnl nonneg
		; print '-'
		mov bl, '-'
		mov [edi], bl
		mov bl, 0
		mov [edi+1], bl
		output outputBuf
		neg eax
nonneg:
		mov edx, -1
		push edx
		mov ebx, 10
loopPrint:
		xor edx,edx
		div ebx
		push edx
		cmp eax, 0
		jz finPrint
		jmp loopPrint
finPrint:
		lea edi,outputBuf
loopPrint2:
		pop edx
		cmp edx, 0
		jl finishPrint
		add dl, '0'
		mov BYTE PTR [edi], dl
		inc edi
		jmp loopPrint2
finishPrint:
		mov BYTE PTR [edi],0
		output outputBuf
		popad
		ret
print ENDP

PUBLIC _start                   ; make entry point public

END                             ; end of source code
