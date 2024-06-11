
_start:
	addi sp, zero, 2047 # sp = 2047
	lw a1, input

	jal ra, GET_DIGITS 
	jal ra, FATORIALS
	jal ra, SHOW_DIGITS 
	
	# Encerra Aplicacao
	beq zero, zero, END


GET_DIGITS:
	addi sp, sp, -4 # Salva ra
    sw ra, 0x0(sp)  # Salva ra

	lw a0, var_10_5		# a1 =10'5
	jal ra, GET_DIGIT   # GET_DIGIT(5)
	addi x18, a0, 0

    addi a0, x0, 1000   # a1 = 10'4
	jal ra, GET_DIGIT   # GET_DIGIT(4)
	addi x19, a0, 0

    addi a0, x0, 100    # a1 = 10'3
	jal ra, GET_DIGIT   # GET_DIGIT(3)
	addi x20, a0, 0

    addi a0, x0, 10     # a1 = 10'2
	jal ra, GET_DIGIT   # GET_DIGIT(2)
	addi x21, a0, 0

    addi a0, x0, 1      # a1 = 10'1
	jal ra, GET_DIGIT   # GET_DIGIT(1)
	addi x22, a0, 0

	lw ra, 0x0(sp)  # Restaura ra
	addi sp, sp, 4  # Restaura ra
	jalr zero, 0(ra)

GET_DIGIT:
    addi sp, sp, -4 # Salva t0
    sw t0, 0x0(sp)  # Salva t0
	add t0, x0, x0  # t0 = 0
	LOOP_DECIMAL:
		blt a1, a0, END_DECIMAL # a0 < a1
		addi t0, t0, 1   # t1++
		sub a1, a1, a0   # a0 -= a1
		beq zero, zero, LOOP_DECIMAL
	END_DECIMAL:
		addi a0, t0, 0	 # a0 = t0
		lw t0, 0x0(sp)  # Restaura t0
		addi sp, sp, 4  # Restaura t0
		jalr zero, 0(ra) # Retorna





FATORIALS:
	addi sp, sp, -4 # Salva ra
    sw ra, 0x0(sp)  # Salva ra
	addi sp, sp, -4 # Salva t0
    sw t0, 0x0(sp)  # Salva t0
	add t5, x0, x0

	add a0, x0, x18
	jal ra, FATORIAL
	add t5, t5, a0 # t5 += FATORIAL(a0)

	add a0, x0, x19
	jal ra, FATORIAL
	add t5, t5, a0 # t5 += FATORIAL(a0)

	add a0, x0, x20
	jal ra, FATORIAL
	add t5, t5, a0 # t5 += FATORIAL(a0)

	add a0, x0, x21
	jal ra, FATORIAL
	add t5, t5, a0 # t5 += FATORIAL(a0)

	add a0, x0, x22
	jal ra, FATORIAL
	add t5, t5, a0 # t5 += FATORIAL(a0)

	lw t0, 0x0(sp)  # Restaura t0
	addi sp, sp, 4  # Restaura t0
	lw ra, 0x0(sp)  # Restaura ra
	addi sp, sp, 4  # Restaura ra
	jalr zero, 0(ra)



FATORIAL:
    addi sp, sp, -4
    sw ra, 0(sp)       # Salva ra na pilha
    addi sp, sp, -4
    sw t0, 0(sp)       # Salva t0 na pilha
    addi sp, sp, -4
    sw t1, 0(sp)       # Salva t1 na pilha
	
	beq a0, zero, FATORIAL_END

    add t0, zero, a0   # t0 = a0
    addi t1, zero, 1   # t1 = 1 (resultado inicial do fatorial)

	FATORIAL_LOOP:
		addi a0, t0, 0     # a0 = t0
		addi a1, t1, 0     # a1 = t1
		jal ra, MULTIPLY   # Chama a função MULTIPLY
		addi t1, a0, 0     # t1 = resultado da multiplicação
		addi t0, t0, -1    # t0 = t0 - 1
		bge t0, zero, FATORIAL_LOOP  # Continua o loop se t0 >= 0

	FATORIAL_END:
		lw t1, 0(sp)       # Restaura t1 da pilha
		addi sp, sp, 4
		lw t0, 0(sp)       # Restaura t0 da pilha
		addi sp, sp, 4
		lw ra, 0(sp)       # Restaura ra da pilha
		addi sp, sp, 4

		addi a0, a1, 0     # a0 = resultadofinal do fatorial
		jalr zero, 0(ra)   # Retorna


MULTIPLY:
    addi sp, sp, -4
    sw t0, 0(sp)
    add t0, zero, zero  # t0 = 0
    addi a0, a0, -1     # a0 = a0 - 1 (inicialização do loop)
	
	MULTIPLY_LOOP:
		addi a0, a0, -1     # a0 = a0 - 1
		add t0, t0, a1      # t0 += a1
		bge a0, zero, MULTIPLY_LOOP  # Continua o loop se a0 >= 0

	END_MULTIPLY:
		add a0, t0, zero    # a0 = resultado da multiplicação
		lw t0, 0(sp)
		addi sp, sp, 4
		jalr zero, 0(ra)    # Retorna







SHOW_DIGITS:
	addi sp, sp, -4 # Salva ra
    sw ra, 0x0(sp)  # Salva ra
	addi sp, sp, -4 # Salva t0
    sw t0, 0x0(sp)  # Salva t0

    addi t0, zero, 40  # t0 = '('
	sb t0, 1024(x0)

	add a1, zero, t5   # a1 = t5
	jal ra, GET_DIGITS # GET_DIGITS(a1)


	addi t0, s2, 48
	sb t0, 1024(x0)

	addi t0, s3, 48
	sb t0, 1024(x0)

	addi t0, s4, 48
	sb t0, 1024(x0)

	addi t0, s5, 48
	sb t0, 1024(x0)

	addi t0, s6, 48
	sb t0, 1024(x0)

    addi t0, zero, 41  # t0 = ')'
	sb t0, 1024(x0)

	lw t0, 0(sp)	# Restaura t0
	addi sp, sp, 4  # Restaura t0
	lw ra, 0(sp)	# Restaura ra
	addi sp, sp, 4  # Restaura ra
	jalr zero, 0(ra)




END:
	addi x31, x0, -1
	halt



input: .word 678
var_10_5: .word 10000

