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
sw $a0, 8($sp)             # arr[] stored on stack frame
sw $a1, 12($sp)            # s stored on stack frame
sw $a2, 16($sp)            # e stored on stack frame
sw $a3, 20($sp)            # direction stored on stack frame
addiu $fp, $sp, 32         # end callee organizational tasks, setup $fp


# Check to see if s == e
beq $a1, $a2, equal        


# Check what directions
beq $a3, $zero, zero      


# direction is 1
lw $a0, 8($sp)             # load arr[]
lw $a1, 12($sp)            # load s
lw $a2, 16($sp)            # load e
addi $a1, $a1, 1           # s = s + 1
lw $a3, 20($sp)            # load direction
jal MaxSumBoundary         # loop again
sw $v0, 24($sp)            # returns maximum subarray

# reload values in case they changed
lw $a0, 8($sp)             # loads arr[]
lw $a1, 12($sp)            # loads s 
sll $t1, $a1, 2            # shifts 8 bits to find value of arr
add $t0, $t1, $a0          # t0 = arr[s] + x 

lw $a1, 0($t0)             # loads arr[s]
add $t1, $a1, $v0          # Updates MaxSubArray
jal FindMax2               # Calls FindMax2 to find new max
j end_MaxSumBoundary


# directions is 0 
zero:
lw $a0, 8($sp)            # load arr[]
lw $a1, 12($sp)           # load s
lw $a2, 16($sp)           # load e
addi $a2, $a2, -1         # e = e - 1
lw $a3, 20($sp)           # load direction
jal MaxSumBoudary         # loop again
sw $v0, 24($sp)           # returns a maximum subarray

# reload values in case they changed
lw $a0, 8($sp)            # load arr[]
lw $a2, 16($sp)           # load e
sll $t1, $a2, 2           # shift 8 bits to find value of arr
add $t0, $a2, $a0         # to = e + arr[] 

lw $a2, 0($t0)            # gets value of t0
add $t1, $v0, $a2         # Updates MaxSubArray
jal FindMax2              # Calls FindMax2 to find new max
j end_MaxSumBoundary

equal:
sll $t0, $a1, 2           # Shift 8 bits to find value of arr
add $t0, $a0, $t0         # t0 = a0 + t0
lw $v0, 0($t0)            # Returns arr[] as max

lw $ra, 0($sp)            # Restores $ra
lw $fp, 4($sp)            # Restores $sp
lw $a0, 8($sp)            # Restores $a0
lw $a1, 12($sp)           # Restores $a1
lw $a2, 16($sp)           # Restores $a1
lw $a3, 20($sp)           # Restores $a3

end_MaxSumBoundary:
jr $ra                    

##########################################################
MaximumCrossingSum:
#	$a0 contains arr[]
#	$a1 contains s
#	$a2 contains m
#	$a3 contains e
#	$v0 returns the maximum sum of arrays that cross the midpoint
#   Write your code here

addiu $sp, $sp, -36            			# Allocate space in stack frame
sw $ra, 0($sp)                  		# $ra stored on stack frame
sw $fp, 4($sp)                  		# $fp stored on stack frame
sw $a0, 8($sp)                  		# arr[] stored on stack frame
sw $a1, 12($sp)                 		# s stored on stack frame
sw $a2, 16($sp)                 		# m stored on stack frame
sw $a3, 20($sp)					# e store in stack
addiu $fp, $sp, 36              		# end callee organizational tasks, setup $fp


lw $a1, 12($sp)                 		#s loaded from stack frame
lw $a2, 16($sp)                 		#m loaded from stack frame
li $a3, 0 					#load d=0
jal MaxSumBoundary				#call MSB
sw $v0, 24($sp)					#store resulting LH Sum in stack 


lw $a3, 20($sp)                 		#e loaded from stack frame
lw $a1, 16($sp)         		        #m loaded from stack frame
addi $a1, $a1, 1				#calculate m+1
li $a3, 1					#load d=1 
jal MaxSumBoundary				#call MSB
sw $v0, 28($sp)					#store resulting RH Sum in stack

lw $t1, 24($sp)					#load the LH Sum
lw $t2, 28($sp)					#load the RH Sum
add $v0, $t1, $t2				#Add LH and RH Sums to get Crossing Sum
jr $ra

##########################################################
MaximumSubArraySum:
#	$a0 contains arr[].
#	$a1 contains s
#	$a2 contains e
#   Write your code here

addiu $sp, $sp, -36                # Allocate space in stack frame
sw $ra, 0($sp)                     # $ra stored on stack frame
sw $fp, 4($sp)                     # $fp stored on stack frame
sw $a0, 8($sp)                     # arr[] stored on stack frame
sw $a1, 12($sp)                    # s stored on stack frame
sw $a2, 16($sp)                    # e stored on stack frame
addiu $fp, $sp, 36                 # end callee organizational tasks, setup $fp

# Load passed in params to check if s == e
lw $a0, 8($sp)                     # load arr[]
lw $a1, 12($sp)                    # load s
lw $a2, 16($sp)                    # load e

# Jump to sEquale if s == e
beq $a1, $a2, sEquale

# Find midpoint of given array, m = (s + e)/2
addu $a3, $a0, $a1              # a3 = s + e
srl $a3, $a3, 1                 # divides by 2
sw $a3 20($sp)					#stored m in stack

# Load arr[], s, and m 
lw $a0, 8($sp)					#load arr[]
lw $a1, 12($sp)					#load s into a1
lw $a2, 20($sp)					#load m into a2
jal MaximumSubArraySum			#run recursion
sw $v0 24($sp)					#store the MSAS for LH side


# Load arr[], m+1, e
lw $a0, 8($sp)                  # load arr[]
lw $a1, 20($sp)					#load s = m
lw $a2, 16($sp)                 #load e
addi $a1, $a3, 1				# calculate m + 1
jal MaximumSubArraySum			#run recursion
sw $v0 28($sp)					#store results in stack

# Load arr[], m, e
lw $a0, 8($sp)					#load arr[]
lw $a1, 12($sp)					#load in original s
lw $a2, 16($sp)					#load in original e
lw $a3, 20($sp)					#load in original m
jal MaxCrossingSum              # Compute maximum crossing sum
sw $v0 32($sp)					#crossing sum results stored

# Find max sub array
lw $a0, 8($sp)					#load the 3 sums calculated
lw $a1, 24($sp)					#will be a1,a2,a3 passed to Findmax3
lw $a2, 28($sp)
lw $a3, 32($sp)
jal FindMax3                    # Returns max value of arrays 

j end_MaximumSubArraySum		#ends the function

# s == e
sEquale:
sll $t0, $a1, 2                 # shifts to address of a1 
add $t0, $a0, $t0               # Stores the value to t0
lw $v0, 0($t0)                  # Returns arr[s]

end_MaximumSubArraySum:
jr $ra

##########################################################
FindMax2:
#	$a1 holds the first number.
#	$a2 holds the second number.
#	$v0 contains the maximum between the 2 input numbers.

beq $a1, $a2, first           # if they are the same number, just use first num
slt $t0, $a1, $a2             # if $a1 is maximum, $t0 is 0
beq $t0, $0, first            # check to see if $a1 is maximum
add $v0, $a2, $0              # returns by storing a2 in v0
j end_findmax2                # $a2 is maximum

first:
add $v0, $a1, $0              # returns by storing a1 in v0
j end_findmax2

end_findmax2:
jr $ra                      # jumps to caller


##########################################################
FindMax3:
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
