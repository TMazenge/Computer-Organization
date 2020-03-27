; bubble sort

buf: dw 100 dup 0
@1: dw 1
@2: dw 2
@100: dw 100
i: dw 0
j: dw 0
msg: dw "Please enter a number. Enter '-1' to stop: "
x: dw 0
n: dw 0

start:
	ldc msg
	sout
	din
	st x
	add @1
	jz finishInput
	; buf[i]= x
	ld x
	push
	ldc buf
	add i
	sti
	
	ld i
	add @1
	st i
	sub @100
	jzop finishInput
	ja start	
	
	
finishInput:
	ld i
	st n
	
	; for (i=0; i<n-1; i++) { //i: last element that is not sorted.
	;    for (j = n-2; j>=i; j--)
	;         if (buf[j]>buf[j+1])
	;			swap(buf[j], buf[j+1])
	
	; set i=0
	ldc 0
	st i
loop1:
	; test if i>=n-1, i-n+1>=0
	ld i
	sub n
	add @1
	jzop finishSort
	
	;j = n-2
	ld n
	sub @2
	st j
	
loop2:
	; test if j<i
	ld j
	sub i
	jn finishLoop2
	
	; loop2 body
	; if buf[j]>buf[j+1]: swap
	
	; get buf[j]
	ldc buf
	add j
	ldi 
	push ; buf[j] in stack
	
	ldc buf
	add j
	add @1
	ldi
	
	subr 0
	jn swap
	pop
	ja continue

swap:
	pop ;pop buf[j]
	ld j
	push
	call swapfun
	pop

continue:
	; j--
	ld j
	sub @1
	st j
	ja loop2
	
finishLoop2:
	ld i
	add @1
	st i
	ja loop1
	
finishSort:
	; for (i = 0; i<n; i++) print(buf[i])
	; i=0
	ldc 0
	st i
	
loop3:
	;test if i>=n 
	ld i
	sub n
	jzop finish
	
	ldc buf
	add i
	ldi 
	dout
	ldc ','
	aout
	
	ld i
	add @1
	st i
	ja loop3
	
finish:
	halt
	
swapfun:
	;swap buf[j] and buf[j+1]
	; temp = buf[j]
	; buf[j]=buf[j+1]
	; buf[j+1]=temp
	ldc buf
	addr 1 ; ret, j
	ldi 
	push ; temp, ret, j
	ldc buf
	addr 2
	add @1
	ldi
	push  ; data, temp, ret, j
	ldc buf
	addr 3
	sti ; temp, ret, j
	ldc buf
	addr 2
	add @1
	sti ; ret, j
	ret
	