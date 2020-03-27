!cpu

;checking sub 
ld x
sub y
st x

;checking push
ld x
push

;checking sti
sti

;checking subr
ld s
subr 0
st s

;checking pop
ld t
push
ld y
push
ld s
push
pop
pop

;checking swap
ld y
swap

ld v
push
;checking call
call subr2
st x
pop

;checking jp
ld t
jp
halt


subr2:
	ld v
	subr 0
	ret ;checking return
	
x: dw 8
y: dw 4
s: dw 5
t: dw 10
v: dw 2