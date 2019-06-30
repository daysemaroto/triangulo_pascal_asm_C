#----------------------------------------------------------------------------------
# Mostrar el triangulo de pascal.
#------------------------------------------------------------------------------
#NOTAS:

#    * El maximo valor a ser ingresado es 13 porque despues se crea un overflow , igual en C.

#-------------------------------------------------------------------------------------------

.data
#---------------mensajes presentados al usuario--------------------------------------
mensaje_1: .asciiz "\n Triangulo de pascal"
mensaje_2: .asciiz "\n Ingrese un numero para formar el arbol binario de pascal: "
espacio_blanco: .asciiz " "
linea_aparte: .asciiz "\n"
#--------------------------------------------------------------------------------------


#--------------------funcion main-----------------------
# aqui empieza el programa
# cargamos todos los temporales que vamos a usar
#--------------------------------------------------
.text
main:	li $v0 4
	la $a0 mensaje_1
	syscall
	la $a0 mensaje_2
	syscall
	li $v0 5
	syscall
	
	#------------------ registro para el arbol binario
	
	# cantidad de linea_apartes pedidos
	move $t0 $v0 
	
	# cantidad de linea_apartes mostradas
	li $t1 0 
	
	# contador de numeros de la linea_aparte
	li $t7 0 
	
	
	# --------------------registro para union
	
	# numero de union r y/o union total
	li $t2 0 
	
	# numero de union k
	li $t3 0 
	
	# numero temporal que guarda $t2-t3 para union
	li $t4 0 
	
	# -------------------------------registro para factorial_numero
	
	# numero actual del factorial_numero
	li $t5 0 
	
	# $t6-1
	li $t6 0 

lineas_apartes_arbol_binario:

	 # cantidad de linea_apartes pedidas = mostradas
	beq $t0 $t1 exit
	b actual_linea_aparte

acumular_linea_aparte:
	# sumar +1 a linea_apartes mostradas
	addi $t1 $t1 1 
	
	# resetar el registro de numeros mostrados por linea_aparte
	li $t7 0 
	li $v0 4
	la $a0 linea_aparte
	syscall
	b lineas_apartes_arbol_binario
	
actual_linea_aparte:

	 # numero de linea_aparte < numeros mostrados en la linea_aparte
	bgt $t7 $t1 acumular_linea_aparte
	
	# $t2 sera el numero de linea_apartes
	move $t2 $t1 
	
	# $t3 sera el contador de numeros mostrados por linea_aparte
	move $t3 $t7 
	jal union
	
	# $t2 es donde esta el resultado de la union
	move $a0 $t2 
	li $v0 1
	syscall
	li $v0 4
	la $a0 espacio_blanco
	syscall
	
	# Sumar 1 a numeros mostrados por la linea_aparte actual
	addi $t7 $t7 1 
	b actual_linea_aparte


union:
	move $s1 $ra
	
	# $t4 = r-k
	sub $t4 $t2 $t3 
	move $t5 $t4
	jal factorial_numero
	
	 # $t4 = (r-k)!
	move $t4 $t5
	move $t5 $t3
	jal factorial_numero
	
	# $t3 = k!
	move $t3 $t5 
	move $t5 $t2
	jal factorial_numero
	
	# $t2 = r!
	move $t2 $t5 
	mul $t4 $t4 $t3
	
	# division por 0
	beqz $t2 union_cero 
	
	 # division por 0
	beqz $t4 union_cero
	div $t2 $t2 $t4
	b union_return


union_return: 
	jr $s1	
		
				
union_cero:
	li $t2 1
	b union_return
	
factorial_numero_cero:
	li $t5 1
	b factorial_numero_return


	
factorial_numero_loop:
	 # termino
	beqz $t6 factorial_numero_return
	mul $t5 $t5 $t6
	subi $t6 $t6 1
	b factorial_numero_loop

	
			
factorial_numero:
	move $t6 $t5
	subi $t6 $t6 1
	
	 # division por 0
	beqz $t5 factorial_numero_cero
	b factorial_numero_loop
		
		
				
factorial_numero_return: 
	jr $ra

		
exit:	li $v0 10
	syscall
