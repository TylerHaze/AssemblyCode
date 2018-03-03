.equ switches, 0x00002030
.equ a, 0x00002000
.equ x, 0x00002010
.global _start
_start: movia r2, switches
		movia r3, x
		movia r4, ARRAY
		movia r5, a
		movi r13, 0
		ldbu r7, 0(r2) #r7 is W
		stbio r7, 0(r5) #stores W into r5 for display
		add r8, r7, r7
		add r8, r7, r8 #this is 3w
		movia r12, HEX #ASSIGNS HEX TO R12
		addi r13, r13, 128
		

	
	
	
LOOP:
	add  r10, r10, r0
	addi r7, r7, 1 #increment the index by 1
	ldbu r10, 0(r2)  #get value from user
	stbio r10, 0(r4) #stores value from user into ARRAY
	addi r4, r4, 1 #increment the array
	addi r13, r13, 1 #increment array pointer
	bgt r4, r13, END #if ARRAY is bigger than r13 then it exits the program
	stbio r7, 0(r5) #store value from user into a
	beq r8, r7, END
	
	
	
	
br LOOP

END:
	ldw r13, 0(r12)
	stw r13, 0(r3)
 br END

ARRAY: .skip 128

HEX: 
	.word 0xFF888EFF