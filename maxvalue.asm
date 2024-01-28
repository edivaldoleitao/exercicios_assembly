.data
  X: .word 1, 2, 3, 4, 5, 6, 7, 8

  
.text

main:
  la $t0, X
  lw $s0, 0($t0) #Sets Max to first value in array
  move $s1, $s0  #Sets Min to first value in array
  addi $t1, $0, 0 #Sets the counter to 0
  li $t1, 0     #Index for the array

loop: 
  bge $t0, 8, EndLoop
  bgt X($t1), $s0, SetMax
  blt X($t1), $s1, SetMin
  addi $t1, $t1, 4 #Increases the index for the array
  addi $t0, $t0, 1 #Increments the counter
SetMax:
  move $s0, X($t1)
  j loop
SetMin: 
  move $s0, X($t1)
  j loop
EndLoop:
  li $v0, 1
  addi $s0, $s0, 0
  addi $si, $s1, 0
  syscall