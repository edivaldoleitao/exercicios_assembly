
.data
arquivo_entrada:	.asciiz "entrada.txt"
arquivo_saida:		.asciiz "saida.txt"
buffer:			.space 512

.text

leitura:
	#abrir o arquivo
	li $v0, 13			#código para abrir arquivo
	la $a0, arquivo_entrada		# entrada 1: endereço do arquivo
	li $a1, 0			# entrada 2: código para abrir arquivo modo leitura 
	syscall
	move $s1, $v0			# retorno v0 -: file descriptor

	#ler o arquivo
	li $v0, 14			#código para ler arquivo
	move $a0, $s1			# entrada 1: file descriptor do arquivo aberto
	la $a1, buffer			# entrada 2: local de memória para armazenar os dados lidos
	li $a2, 512			# entrada 3: tamanho de buffer utilizado no processo de leitura
	syscall

	#fechar arquivo
	li $v0, 16			#código para fechar arquivo
	move $a0, $s1			# entrada 1: file descriptor do arquivo aberto
	syscall


espelha:
  li $t1, 0
  la    $a0, buffer($t1)       # endereço do buffer
  li    $a1, 512       # tamanho buffer
  syscall

  li    $t0, 0         
  subu  $sp, $sp, 4    # coloca na pilha
  sw    $t0, ($sp)     
  li    $t1, 0         # indice do primeiro caracter

push:                 # coloca cada caracter na pilha
  lbu    $t0, buffer($t1) # carrega o caracter da pilha 
  beqz  $t0, stend     # byte nulo

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

	li $v0, 4			#código para escrita de string em tela
	la $a0, buffer			#endereço de memória com a string a ser apresentada na tela
	syscall

	li $v0, 13			#código para abrir arquivo
	la $a0, arquivo_saida		# entrada 1: endereço do arquivo
	li $a1, 1			# entrada 2: código para abrir arquivo modo escrita 
	syscall
	move $s2, $v0			# retorno v0 -: file descriptor

	li $v0, 15			#código para escrever em arquivo
	move $a0, $s2			# entrada 1: file descriptor do arquivo aberto
	la $a1, buffer			# entrada 2: local de memória com o dado a ser escrito
	li $a2, 512			# entrada 3: tamanho de buffer utilizado no processo de escrita
	syscall


	#fechar arquivo
	li $v0, 16			#código para fechar arquivo
	move $a0, $s2			# entrada 1: file descriptor do arquivo aberto
	syscall

	li $v0, 10			#código para finalizar programa
	syscall

