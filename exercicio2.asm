.data

teste: .word 2,2,4
entrada: .asciiz "entrada dados:\n"

.text

li $v0, 4
la $a0, entrada
syscall
li $v0, 5
syscall
move $t0, $v0
li $v0, 1
la $a0, ($t0)
syscall

