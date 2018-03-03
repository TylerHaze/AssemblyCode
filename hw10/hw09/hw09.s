.equ switches, 0x00002030
.equ a, 0x00002000
.equ x, 0x00002010
.global _start

_start:
	
	movia r2, LUT	#LUT1
	movia r3, x
	movia r4, a
	addi r5, r5, 0 #register is equal to 0
	movia r6, LUT256
	addi r20, r20, 255
	addi r7, r7, 0	#y is 0
	addi r8, r8, 0	#x is 0
	
	
MAIN:
	#get upper nibble
	bgt r5, r20, END	#end the program if you get 255 bits
	add r12, r0, r0		#clear r13
	andi r7, r5, 0xF0	#set value of y equal to
	srli r7, r7, 4		#shift upper nibble right to use it with LUT table
	add r9, r2, r7		#add the r7 and r2 index so find the index for the number you need
	ldb r9, 0(r9)		#prior to this r9 is equal to the LUT value at y, so now this will actually get the value
	
	#get lower nibble
	andi r8, r5, 0x0F
	add r10, r2, r8
	ldb r10, 0(r10)
	
	slli r9, r9, 8		#shift r9 back to the left
	or r11, r9, r10		#or r9 and r10 together to have a full halfword for use
	
	sth r11, 0(r6)		#store your halfword into r6
	
	#make blanks on hex5, hex4 and then put halfword onto hex3,2
	addi r12, r12, 0x7F	
	slli r12, r12, 8
	addi r12, r12, 0x7F
	slli r12, r12, 16
	add r12, r11, r12
	stw r12, 0(r3)
	
	addi r5, r5, 1
	
	br MAIN
	
END:
	br END
	
LUT:
	.byte 64, 121, 36, 48, 25, 18, 2, 120, 0, 24, 8, 3, 70, 33, 6, 14
LUT256:
	.skip 512
