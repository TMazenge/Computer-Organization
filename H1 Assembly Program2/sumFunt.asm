;Read a number, calculate  and print the result of 1+(1+2)+...+(1+2...+n). You need to use a function to calculate 1+2+...+k.

;Read a number, calculate  and print the result of 1+(1+2)+...+(1+2...+n). Using recursion.


num: dw 0
@1: dw 1
sum: dw 0
totalSum: dw 0
msg: dw "Enter number :"
i: dw 1
j: dw 1

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

	ldc 0
	st sum 

	ld i
	add @1
	st i
	ja loop
	
summation:
	ld i
	sub j
	jn finish1

	ld sum
	add j
	st sum


	ld j
	add @1
	st j
	ja summation

finish:
	ld totalSum
	dout
	halt

finish1:
	ld sum
	str 1
	ldc 1
	st j
	ret

END start

	

	

