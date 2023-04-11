.data
fibonacci:
  .word 0:10   # Reserva 10 palabras de memoria para almacenar la serie de Fibonacci
  
.text
.globl main

main:
  li $t0, 0    # Inicializa $t0 con el primer t�rmino de la serie de Fibonacci
  sw $t0, 0($fibonacci)    # Almacena el primer t�rmino en la primera posici�n de memoria
  li $t1, 1    # Inicializa $t1 con el segundo t�rmino de la serie de Fibonacci
  sw $t1, 4($fibonacci)    # Almacena el segundo t�rmino en la segunda posici�n de memoria
  
  # Ciclo principal para calcular la serie de Fibonacci
  li $t2, 2    # Inicializa $t2 con el �ndice del siguiente t�rmino
  loop:
    lw $t3, 4($fibonacci)  # Carga el �ltimo t�rmino de la serie de Fibonacci
    lw $t4, 0($fibonacci)  # Carga el pen�ltimo t�rmino de la serie de Fibonacci
    add $t5, $t3, $t4      # Calcula el siguiente t�rmino de la serie de Fibonacci
    sw $t5, ($fibonacci)   # Almacena el siguiente t�rmino en la siguiente posici�n de memoria
    addi $fibonacci, $fibonacci, 4   # Incrementa el puntero a la siguiente posici�n de memoria
    addi $t2, $t2, 1       # Incrementa el �ndice del siguiente t�rmino
    blt $t2, 10, loop      # Repite el ciclo hasta que se hayan calculado los 10 t�rminos de la serie de Fibonacci
  
  # Imprime la serie de Fibonacci
  li $v0, 4    # Establece el c�digo de la llamada al sistema para imprimir cadena
  la $a0, message    # Carga la direcci�n de la cadena de mensaje en $a0
  syscall
  
  li $v0, 1    # Establece el c�digo de la llamada al sistema para imprimir un entero
  li $t6, 0    # Inicializa $t6 con el �ndice del primer t�rmino de la serie de Fibonacci
  loop2:
    lw $t7, ($fibonacci)  # Carga el siguiente t�rmino de la serie de Fibonacci
    move $a0, $t7         # Mueve el valor del siguiente t�rmino a $a0
    syscall
    addi $fibonacci, $fibonacci, 4   # Incrementa el puntero a la siguiente posici�n de memoria
    addi $t6, $t6, 1      # Incrementa el �ndice del siguiente t�rmino
    blt $t6, 10, loop2     # Repite el ciclo hasta que se hayan impreso los 10 t�rminos de la serie de Fibonacci
  
  li $v0, 10   # Establece el c�digo de la llamada al sistema para salir
  syscall
  
.data
message:
  .asciiz "La serie de Fibonacci es:\n"
