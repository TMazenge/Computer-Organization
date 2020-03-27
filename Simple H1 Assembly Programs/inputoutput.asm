; This assembly program reads numbers and prints in differnt formats

	hin
	st x
	dout
	
	ldc '\n'
	aout ; print new line
	
	ld x
	hout
	
	ldc '\n'
	aout
	
	ld x
	add @1 
	aout

	ldc '\n'
	aout

	halt
	
x:  dw 0
@1: dw 1