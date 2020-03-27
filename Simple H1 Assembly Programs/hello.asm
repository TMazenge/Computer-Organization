; print hello world!

	ldc text
	sout
	
	ldc '\n'
	aout
	
	ldc 0
	st text1+8
	ldc text1+3
	sout 
	
	halt
	
text: dw 'Hello \" \' World!\n'
text1: dw "Next string"