; This program reads a number n
; and prints a triangle of n asterisks.
	ldc msg
	sout
	din
	st n
	
	; for (i=1; i<=n; i++)
	; 	for (j=1; j<=i; j++)
	;		print('*');
	;	print("\n")
	
	; test if i>n
loop1:
	ld n
	sub i
	jn finish
	
	ldc 1
	st j ; j = 1
	; test if j>i, or i-j is negative
loop2:
	ld i
	sub j
	jn finish1
	ldc '*'
	aout ;print "*"
	
	; j++
	ld j
	add @1
	st j
	ja loop2
	
finish1:
	ldc '\n'
	aout

	ld i
	add @1
	st i
	
	ja loop1
	
finish:
	halt

msg:	dw "Please enter a number:"
n:		dw 0
i:		dw 1
j:		dw 1
@1:		dw 1
