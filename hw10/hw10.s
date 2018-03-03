.equ switches, 0x00002030
.equ a, 0x00002000
.equ x, 0x00002010
.global _start

_start:
	
	movia r2, LUT		#LUT1
	movia r3, x
	movia r4, a
	movia r6, LUT256
	movi r5, 0			#counter
	movia sp, STACK
	addi r20, r20, 255
	addi r7, r7, 0	#y is 0
	addi r8, r8, 0	#x is 0
	
LOOP:
	bgt r5, r20, END
	addi sp, sp, 12		#allocate space
	stw r2, -8(sp)		#store LUT pointer onto stack
	stw r5, -12(sp)		#store counter onto stack
	
	
	call COMPUTE
	
	ldw r11, -4(sp)
	addi sp, sp, -12
	
	add r12, r0, r0		#clear r12
	
	sth r11, 0(r6)
	
	#make blanks on hex5, hex4 and then put halfword onto hex3,2
	addi r12, r12, 0x7F	
	slli r12, r12, 8		#shift the blank you just put in to the left
	addi r12, r12, 0x7F		#add back on another blank
	slli r12, r12, 16		#move that over
	add r12, r12, r11		#add the blanks to your halfword
	stw r12, 0(r3)			#store onto x
	stw r5, 0(r4)			#store onto a
	
	addi r6, r6, 2			#increment 256hw LUT
	
	addi r5, r5, 1		#increment index
	br LOOP
	
	
	
	
COMPUTE:
	#prologue
	addi sp, sp, 28
	stw ra, -28(sp)
	stw r7, -24(sp)
	stw r9, -20(sp)
	stw r8, -16(sp)
	stw r2, -12(sp)
	stw r10, -8(sp)
	stw r11, -4(sp)
	
	ldw r5, -40(sp)
	ldw r2, -36(sp)
	
	#get upper nibble
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
	
	
	stw r11, -32(sp)
	
	#Epilogue
	ldw ra, -28(sp)
	ldw r7, -24(sp)
	ldw r9, -20(sp)
	ldw r8, -16(sp)
	ldw r2, -12(sp)
	ldw r10, -8(sp)
	ldw r11, -4(sp)
	
	addi sp, sp, -28
	ret
	
	
	
	
	
	
	
	
	
	
	
END:
	br END
	
LUT:
	.byte 64, 121, 36, 48, 25, 18, 2, 120, 0, 24, 8, 3, 70, 33, 6, 14
LUT256:
	.skip 512
STACK:
	.skip 128
	
