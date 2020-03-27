; print to n
; this program reads a number n and prints 0, 1, ..., n

	ldc msg
	sout
	din
	st n
	
	; for (i=0; i<=n; i++)
	;       print i, print ","
	
	; test if i>n, or n-i is negative
loop:
	ld n
	sub i
	jn finish
	
	ld i
	dout
	ldc '\n'
	aout
	
	ld i
	add @1
	st i ; i++
	
	ja loop

finish:
	ldc '\n'
	aout
	halt


msg:	dw "Please enter a number:"
n:	dw 0
i:	dw 0
@1:	dw 1