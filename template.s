# Project ECE 30 Winter 2017
# Maximum Subarray Sum
# Student 1 : PID A10902921
# Magana, Cesar 
# Student 2 : PID A12127824
# Tran, Wilson 

.data ## Data declaration section
## String to be printed:
string_newline: .asciiz "\n" # newline character
string_space: .asciiz " " # space character
string_MaxSubArraySum: .asciiz "Maximum Sub Array Sum is: "
array1: .word -2, -5, 6, -2, -3, 1, 5, -6
size: .word 7
.text ## Assembly language instructions go in text segment

main: ## Start of code section
li $a1, 0
la $a2, size 
lw $a2, 0($a2)
la $a0, array1
jal MaximumSubArraySum # MaxSubArraySum(arr,0, size-1);
move $a0,$v0 #result of MaxSubArraySum is stored in $v1 store that as argument of print sum
jal printsum
li $v0, 10 # terminate program
syscall

##########################################################
printsum: # Function to print the contents of the array
# $a0 = value to be printed
move $t0, $a0
	
# print newline character
la $a0, string_newline
li $v0, 4
syscall
    
la $a0,  string_MaxSubArraySum
li $v0, 4
syscall
	
# print the integer at the address $a0
li $v0, 1
move $a0,$t0
syscall
jr $ra  # Return back

##########################################################
MaxSumBoundary:
#	$a0 contains address to arr[].
#	$a1 contains s 
#	$a2 contains e
#	$a3 is the direction (either 0 or 1)
#	$v0 returns the maximum subarray

addiu $sp, $sp, -32        # Allocate space in stack frame
sw $ra, 0($sp)             # $ra stored on stack frame
sw $fp, 4($sp)             # $fp stored on stack frame
sw $a0, 8($sp)             # $a0 stored on stack frame
sw $a1, 12($sp)            # $a0 stored on stack frame
sw $a2, 16($sp)            # $a0 stored on stack frame
sw $a3, 20($sp)            # $a0 stored on stack frame
addiu $fp, $sp, 32         # end callee organizational tasks, setup $fp

# Check to see if s == e
beq $a1, $a2, equal        # Compares s with e


# s != e, check what direction
beq $a3, $zero, zero       # Compare direction to 0


# direction is 1
li $x,                     # Stores the new max 
la $v0, $t0                # Returns maximum subarray

lw $ra, 0($sp)             # Restores $ra
lw $fp, 4($sp)             # Restores $sp
addiu $sp, $sp, 32         # End callee organizational tasks, pop stack frame
jr   $ra                   # Return to caller



# direction is 0 
zero:
sll $t0, $a1, 1            # Shift to 
lw $v0, 0($t0)

lw $ra, 20($sp)            # Restores $ra
lw $fp, 16($sp)            # Restores $sp
addiu $sp, $sp, 32         # End callee organizational tasks, pop stack frame
jr   $ra                   # Return to caller



equal:
sll $t0, $a1, 5            # Saves value of arr[s]
lw $v0, 0($t0)             # Returns arr[s] as max

lw $ra, 0($sp)            # Restores $ra
lw $fp, 4($sp)            # Restores $sp
lw $a0, 8($sp)            # Restores $a0
lw $a1, 12($sp)           # Restores $a1
lw $a2, 16($sp)           # Restores $a1
lw $a3, 20($sp)           # Restores $a3

addiu $sp, $sp, 32         # End callee organizational tasks, pop stack frame
jr   $ra                   # Return to caller

##########################################################
MaximumCrossingSum:
#	$a0 contains arr[]
#	$a1 contains s
#	$a2 contains m
#	$a3 contains e
#	$v0 returns the maximum sum of arrays that cross the midpoint
#   Write your code here
jr $ra


##########################################################
MaximumSubArraySum:
#	$a0 contains arr[].
#	$a1 contains s
#	$a2 contains e
#   Write your code here
jr $ra

##########################################################
FindMax2:
#	$a1 holds the first number.
#	$a2 holds the second number.
#	$v0 contains the maximum between the 2 input numbers.

addi $sp, $sp, -8             #allocate memory
sw $ra, 0($sp)	              #store RA from FindMax3

beq $a1, $a2, first           # if they are the same number, just use first num
slt $t0, $a1, $a2             # if $a1 is maximum, $t0 is 0
beq $t0, $0, first            # check to see if $a1 is maximum
lw $v0, 0($a2)                # $a2 is maximum

first:
lw $v0, 0($a1)                # load $a1 as maximum

lw $ra, 0($sp)	              # load ra from FindMax3
jr $ra                        # jump to FindMax3

FindMax3:
##########################################################
#	$a1 holds the first number.
#	$a2 holds the second number.
#	$a3 holds the third number.
#	$v0 contains the maximum among the 3 numbers
#   Write your code here 

#####NEED TO FIX THE PROCEDURAL DUTIES BETWEEN FINDMAX3 AND FINDMAX2 BUT I BELIEVE THE CODE IS MOSTLY RIGHT

addi $sp, $sp, -8	#allocate memory
sw $ra, 0($sp)		#store RA from caller that called  FindMax3

add $t1, $t1, $a1	#store arguments to be compared in separe registers for safety
add $t2, $t2, $a2
add $t3, $t3, $a3

jal FindMax2		#call  FindMax2 for variables a1 and a2
			#FindMax2 returns v0 = max between a1 and a2

move $a1, $v0		#move $v0 to what will act as the new a1
move $a2, $a3

jal FindMax2		#call FindMax2 for new a1 and a3
			#FindMax2 will return v0 = max of all 3 values.

move $a1, $t1		#return the values from temp to arg
move $a2, $t2
move $a3, $t3

move $a0, $v0		# a0 stores value that will be printed, in this case the MAX3
li $v0, 1		#print the max of all 3 values
syscall
lw $ra, 0($sp)
jr $ra
