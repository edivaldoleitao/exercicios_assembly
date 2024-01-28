.data
lista: .word 2,2,7

.text

la $t0 , lista
lw $t1, 8($t0)

li $v0, 1
la $a0, ($t1)
syscall