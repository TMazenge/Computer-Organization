num: dw 0
@1: dw 1
totalSum: dw 0
msg: dw "Enter number.\n"
i: dw 1

start:
	ldc msg
	sout
	din
	st num

loop:
	ld num 
	sub i
	jn finish

	ld i
	push
	aloc 1 ;alocate space for returnValue
	;returnAdress, returnValue, i

	call summation
	pop 
	add totalSum
	st totalSum
	dloc 1

	ld i
	add @1
	st i
	ja loop

summation:
	ld @1 ; returnAddress, returnValue, i
	subr 2
	jzop finish1
	
	ldr 2
	sub @1
	push 
	aloc 1
	call summation
	; retVal, i-1
	pop
	dloc 1
	addr 2
	str 1
	ret

finish1:
	ldr 2
	str 1
	ret
	
finish:
	ld totalSum
	dout
	halt

END start
	

