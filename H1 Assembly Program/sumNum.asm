;Write a program that reads an n and calculates the sum 1+2+3…+n and prints the result.

	ldc msg
	sout
	din
	st num

loop:
	ld num
	sub i
	jn finish

	ld sum
	add i
	st sum

	ld i
	add @1
	st i
	ja loop

finish:
	ld sum
	dout
	halt
	
sum: dw 0
msg: dw "Enter number.\n"
num: dw 0
@1: dw 1
i: dw 0



