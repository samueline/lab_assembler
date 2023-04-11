.data
fibonacci:
  .word 0:10   # Reserva 10 palabras de memoria para almacenar la serie de Fibonacci
  
.text
.globl main

main:
  li $t0, 0    # Inicializa $t0 con el primer término de la serie de Fibonacci
  sw $t0, 0($fibonacci)    # Almacena el primer término en la primera posición de memoria
  li $t1, 1    # Inicializa $t1 con el segundo término de la serie de Fibonacci
  sw $t1, 4($fibonacci)    # Almacena el segundo término en la segunda posición de memoria
  
  # Ciclo principal para calcular la serie de Fibonacci
  li $t2, 2    # Inicializa $t2 con el índice del siguiente término
  loop:
    lw $t3, 4($fibonacci)  # Carga el último término de la serie de Fibonacci
    lw $t4, 0($fibonacci)  # Carga el penúltimo término de la serie de Fibonacci
    add $t5, $t3, $t4      # Calcula el siguiente término de la serie de Fibonacci
    sw $t5, ($fibonacci)   # Almacena el siguiente término en la siguiente posición de memoria
    addi $fibonacci, $fibonacci, 4   # Incrementa el puntero a la siguiente posición de memoria
    addi $t2, $t2, 1       # Incrementa el índice del siguiente término
    blt $t2, 10, loop      # Repite el ciclo hasta que se hayan calculado los 10 términos de la serie de Fibonacci
  
  # Imprime la serie de Fibonacci
  li $v0, 4    # Establece el código de la llamada al sistema para imprimir cadena
  la $a0, message    # Carga la dirección de la cadena de mensaje en $a0
  syscall
  
  li $v0, 1    # Establece el código de la llamada al sistema para imprimir un entero
  li $t6, 0    # Inicializa $t6 con el índice del primer término de la serie de Fibonacci
  loop2:
    lw $t7, ($fibonacci)  # Carga el siguiente término de la serie de Fibonacci
    move $a0, $t7         # Mueve el valor del siguiente término a $a0
    syscall
    addi $fibonacci, $fibonacci, 4   # Incrementa el puntero a la siguiente posición de memoria
    addi $t6, $t6, 1      # Incrementa el índice del siguiente término
    blt $t6, 10, loop2     # Repite el ciclo hasta que se hayan impreso los 10 términos de la serie de Fibonacci
  
  li $v0, 10   # Establece el código de la llamada al sistema para salir
  syscall
  
.data
message:
  .asciiz "La serie de Fibonacci es:\n"
