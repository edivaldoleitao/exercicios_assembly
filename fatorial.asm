.data
entrada: .asciiz "entre com o valor do fatorial:\n"
saida: .asciiz "o valor do fatorial é: "
.text

li $v0, 4
la $a0, entrada
syscall

li $v0, 5
syscall
move $a0, $v0

main:
	move $s0, $a0
	add $s1, $s0, $zero
fatorial:
	beq $s0, 1, caso_base
	beqz $s0, caso_base
	subi $s1, $s1, 1
	mult $s1, $s0
	mflo $t1
	move $s0, $t1
	beq $s1, 1, fim

	j fatorial

caso_base: 
	li $s0, 1
	j fim
fim:
	li $v0, 4
	la $a0, saida
	syscall
	
	li $v0, 1
	la $a0, ($s0)
	syscall
	
	li $v0, 10
	syscall
	
	
