
.data
arquivo_entrada:	.asciiz "entrada.txt"
arquivo_saida:		.asciiz "saida.txt"
buffer:			.space 512

.text


leitura:
	#abrir o arquivo
	li $v0, 13			#c�digo para abrir arquivo
	la $a0, arquivo_entrada		# entrada 1: endere�o do arquivo
	li $a1, 0			# entrada 2: c�digo para abrir arquivo modo leitura 
	syscall
	move $s1, $v0			# retorno v0 -: file descriptor

	#ler o arquivo
	li $v0, 14			#c�digo para ler arquivo
	move $a0, $s1			# entrada 1: file descriptor do arquivo aberto
	la $a1, buffer			# entrada 2: local de mem�ria para armazenar os dados lidos
	li $a2, 512			# entrada 3: tamanho de buffer utilizado no processo de leitura
	syscall

	#fechar arquivo
	li $v0, 16			#c�digo para fechar arquivo
	move $a0, $s1			# entrada 1: file descriptor do arquivo aberto
	syscall
	
# mant�m os caracteres especiais e inverte o lowercase e uppercase
inverte_case:
    li $t0, 0 # carrega zero para garantir que a contagem come�a do zero
loop:
    lb $t1, buffer($t0) # carrega o byte em $t1, pois um caractere � representado por 8 bits
    beq $t1, 0, espelha # verifica se � nulo, sen�o vai pra espelha
    bge $t1, 'a', maior # verifica se � maior ou igual ao caracter 'a' se for vai para o label maior
    bge $t1, 'A', maior2 # verifica se � maior ou igual ao caracter 'A' se for vai para o label maior2
    j cont
maior: 
    ble $t1, 'z', upcase # verifica se � menor ou igual que 'z', se for est� no intervalo valores para caracteres lowercase
    j cont # sen�o ir� para o label cont, onde segue sendo armazenado sem altera��o 
maior2:
    ble $t1, 'Z', not_lower
upcase:
    sub $t1, $t1, 32 # subtrai ao caracter 32 para tornar uppercase
cont:
    sb $t1, buffer($t0)
    addi $t0, $t0, 1
    j loop
not_lower:
    add $t1, $t1, 32 # soma ao caracter 32 para tornar lowercase
    j cont
        

#espelha os caracteres da string no arquivo
espelha:
  li 	$t1, 0
  la    $a0, buffer($t1)       # endere�o do buffer     
  li    $t0, 0         
  subu  $sp, $sp, 4    # coloca na pilha
  sw    $t0, ($sp)     
  li    $t1, 0         # indice do primeiro caracter

push:                 # coloca cada caracter na pilha
  lbu    $t0, buffer($t1) # carrega o caracter da pilha 
  beqz  $t0, stend     # byte nulo, que vai ser zero

  subu  $sp, $sp, 4    
  sw    $t0, ($sp)     

  addu  $t1, $t1 1     # incrementa o indice
  j      push         

stend:                 # tira o caracter da pilha e coloca no buffer
  li    $t1, 0       
pop:
  lw    $t0, ($sp)     
  addu  $sp, $sp, 4
  beqz  $t0, escrita      # se tiver a vazio

  sb    $t0, buffer($t1)  # armazena no array
  addu  $t1, $t1, 1    # incremento
  j      pop



escrita:

	li $v0, 4			#c�digo para escrita de string em tela
	la $a0, buffer			#endere�o de mem�ria com a string a ser apresentada na tela
	syscall

	li $v0, 13			#c�digo para abrir arquivo
	la $a0, arquivo_saida		# entrada 1: endere�o do arquivo
	li $a1, 1			# entrada 2: c�digo para abrir arquivo modo escrita 
	syscall
	move $s2, $v0			# retorno v0 -: file descriptor

	li $v0, 15			#c�digo para escrever em arquivo
	move $a0, $s2			# entrada 1: file descriptor do arquivo aberto
	la $a1, buffer			# entrada 2: local de mem�ria com o dado a ser escrito
	li $a2, 512			# entrada 3: tamanho de buffer utilizado no processo de escrita
	syscall


	#fechar arquivo
	li $v0, 16			#c�digo para fechar arquivo
	move $a0, $s2			# entrada 1: file descriptor do arquivo aberto
	syscall

	li $v0, 10			#c�digo para finalizar programa
	syscall



