; jump test
		ldc msg
		sout
		
		din
		st x
		jzop next
		ldc msg2
		sout
		ja finish
		
next:	ldc msg1
		sout
	
finish:	halt
	
	
	
msg:	dw "Please enter a number:"
x:		dw 0
msg1:	dw "x is greater or equal to zero"
msg2:	dw "x is negative"