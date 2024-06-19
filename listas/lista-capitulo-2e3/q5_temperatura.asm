#######################
# TEMPERATURA # A0				#
#######################
# PINO 2 # Amarelo-E		#
# PINO 3 # Verde–E				#
# PINO 4 # Verde–D				#
# PINO 5 # Amarelo–D		#
# PINO 6 # Vermelho–D #
# PINO 7 # Vermelho-E #
#######################

START:
	addi sp, zero, 2047 # sp = 2047
	addi x5, x0, b00000001
	jal ra, LOOP
	jal x0, END


LOOP:
	lw x11, 1031(x0)
	add x10, x0, x11
	jal ra, DIVIDIR
	add  t4, x0, x10
	sll x6, x5, x10
	sb x6, 1029(x0)
	bge x0, x0, LOOP


DIVIDIR:
	addi sp, sp, -4 # Salva t0
    sw x5, 0x0(sp)  # Salva t0
	addi sp, sp, -4 # Salva t1
    sw x6, 0x0(sp)  # Salva t1

	addi x5, x0, 0x66  # t0 = 1024/10
	addi x6, x0, 1  # t1 = 0

	# while(a0 > t0) then a-=t0
	DIVIDIR_LOOP:
		sub x10, x10, x5
		blt x10, x0, DIVIDIR_END_LOOP
		addi x6, x6, 1
		beq x0, x0, DIVIDIR_LOOP

	DIVIDIR_END_LOOP:
		addi x10, x6, 0 # a0 = t1
		addi x6, x0, 3  # t1 = 3
		blt x10, x6, DIVIDIR_FLOOR
		addi x6, x0, 8  # t1 = 8
		bge x10, x6, DIVIDIR_CEIL
		beq x0, x0, DIVIDIR_END
	
	DIVIDIR_FLOOR:
		add x10, x0, x6 # a0 = 3
		beq x0, x0, DIVIDIR_END
	DIVIDIR_CEIL:
		add x10, x0, x6 # a0 = 8

	DIVIDIR_END:	
		addi x10, x10, -3 # a0 = t1-3
		lw x6, 0x0(sp)  # Restaura t1
		addi sp, sp, 4  # Restaura t1
		lw x5, 0x0(sp)  # Restaura t0
		addi sp, sp, 4  # Restaura t0
		jalr x0, 0(ra)



END:
	addi x31, x0, -1
	halt


