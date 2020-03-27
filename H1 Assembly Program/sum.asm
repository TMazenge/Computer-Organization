;Write a program that reads two numbers and prints their sum. The output must be of the format a+b=c. 
	
	ldc msg
	sout
	din
	st x

	ldc msg 
	sout
	din
	st y

	ld x
	dout
	ldc msg1
	sout

	ld y
	dout
	ldc msg2
	sout

	ld sum
	add x
	add y
	dout
	halt

x: dw 0
y: dw 0
sum: dw 0

msg: dw "Enter a number.\n"
msg1: dw " + "
msg2: dw " = "