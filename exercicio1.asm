# i = $s1 => 6
# num =  $s2
# v[] = $s0 




li $s2,100
li $s1,0
li $s0,0x10010020
li $t0,1
sw $t0,0($s0)
add $s1,$s1,1
li $t0,3
sw $t0,4($s0)
add $s1,$s1,1
la $t0,2
sw $t0,8($s0)
add $s1,$s1,1
li $t0,1
sw $t0,12($s0)
add $s1,$s1,1
li $t0,4
sw $t0,16($s0)
add $s1,$s1,1
li $t0,5
sw $t0,20($s0)
add $s1,$s1,1
lw $t1,8($s0) 
lw $t2,16($s0)
add $t0,$t1,$t2



