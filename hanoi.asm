msg: dw "Please enter n: "
n:	dw 0
msg1: dw "-->"
@1: dw 1
count: dw 0

start:
	ldc msg
	sout
	din
	st n
	
	; move(n, 1, 3, 2)
	
	ld n
	push
	ldc 1
	push ;from
	ldc 3
	push  ; to
	ldc 2
	push ; temp
	call move
	dloc 4
	ld count
	dout	
	halt
	
move:
	; void move(m, from, to, temp)
	;      if m==0 return;
	;      move(m-1, from, temp, to)
	;      move one disc from (from, to)
	;      move(m-1, temp, to, from);
	
	; retAddr, temp, to, from, m
	ldr 4 ;load m
	jz finish ; if m==0 return
	ldr 4 
	sub @1
	push ; m-1, retAddr, temp, to, from, m
	ldr 4
	push ; from, m-1, retAddr, temp, to, from, m
	ldr 3
	push ; temp, from, m-1, retAddr, temp, to, from, m
	ldr 5
	push ; to, temp, from, m-1, retAddr, temp, to, from, m
	call move
	dloc 4 ;retAddr, temp, to, from, m
	
	;print from
	ldr 3
	dout ; print from
	ldc msg1
	sout ;print arrow
	ldr 2
	dout
	ldc '\n'
	aout
	
	ld count
	add @1
	st count
	
	; move(m-1, temp, to, from);
	ldr 4
	sub @1
	push ; m-1, retAddr, temp, to, from, m
	ldr 2 
	push ; temp, m-1, retAddr, temp, to, from, m
	ldr 4
	push ; to, temp, m-1, retAddr, temp, to, from, m
	ldr 6
	push ; from, ....
	call move
	dloc 4
	
finish:
	ret
	
	END start
	