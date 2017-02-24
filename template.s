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

# Check what directions
beq $a3, $zero, zero

# direction is 1
lw $ra, 0($sp)             # Restores $ra
lw $fp, 4($sp)             # Restores $sp
addiu $sp, $sp, 32         # End callee organizational tasks, pop stack frame
jr   $ra                   # Return to caller

# directions is 0 
zero:
lw $a0, 8($sp)
lw $a1, 12($sp)
lw $a2, 16($sp)
addi $a2, $a2, -1
lw $a3, 20($sp)
jal MaxSumBoudary
sw $v0, 24($sp)

lw $a0, 8($sp)
lw $a2, 16($sp)
sll $t1, $a2, 2
add $t0, $a2, $a0

lw $a2, 0($t0)
add $t1, $v0, $a2
jal FindMax2
 
equal:
sll $t0, $a1, 2           # Shift 8 bits to find value of arr
add $t0, $a0, $t0
lw $v0, 0($t0)            # Returns arr[s] as max

lw $ra, 0($sp)            # Restores $ra
lw $fp, 4($sp)            # Restores $sp
lw $a0, 8($sp)            # Restores $a0
lw $a1, 12($sp)           # Restores $a1
lw $a2, 16($sp)           # Restores $a1
lw $a3, 20($sp)           # Restores $a3
jr $ra

##########################################################
MaximumCrossingSum:
#	$a0 contains arr[]
#	$a1 contains s
#	$a2 contains m
#	$a3 contains e
#	$v0 returns the maximum sum of arrays that cross the midpoint
#   Write your code here

				#a0 contains an array of size x
				#add array elements a to m
				#add array aelements m+1 to e

				#v0 = the two sum 

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

#####NEED TO FIX THE PROCEDURAL DUTIES BETWEEN FINDMAX3 AND FINDMAX2 BUT I BELIEVE THE CODE IS MOSTLY RIGHT

beq $a1 $a2 first           # if they are the same number, just use first num
slt $t0 $a1 $a2             # if $a1 is maximum, $t0 is 0
beq $t0 $0 first            # check to see if $a1 is maximum
lw $v0 0($a2)         XXXXXX cant load from number must load from address      # $a2 is maximum

first:
lw $v0 0($a1) XXXXX cant load from a number must be from mem address


jr $ra				#jump to FindMax3

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


lw $ra, 0($sp)		#loads caller address and jumps to it
jr $ra
