;Write a program that reads an n and calculate the sum (1)+(1+2)+(1+2+3)+…+(1+2+…+n) and prints the result.


	ldc msg
	sout
	hin
	st num

loop1:
	ld num
	sub i
	jn finish1


	ldc 1
	st j 

	ldc 0
	st sum1

loop2:
	ld i
	sub j
	jn finish2

	ld sum1
	add j
	st sum1

	;ld sum
	;dout

	ld j
	add @1
	st j
	ja loop2

finish2:
	; sum += sum1
	
	ld sum 
	add sum1
	st sum

	ld i
	add @1
	st i

	ja loop1

finish1:
	ld sum
	dout
	halt


num: dw 0
@1: dw 1
sum: dw 0
sum1: dw 1
msg: dw "Enter number.\n"
i: dw 1
j: dw 1


