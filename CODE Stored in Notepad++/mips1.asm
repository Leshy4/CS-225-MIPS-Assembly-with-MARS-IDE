?#####################################################################
# Assignment #6: Exercises 5.2, 5.7, 5.8	Programmers: Katherine Sykes, 
# 							Chris Welch, & Ed Arellano Mendiola
# Due Date: 4-10-2018				Course: CSC 225 040
# Last Modified: 4-10-2018 1:36 PM
#####################################################################
# Functional Description:
# Each person on our team, selected one of the Exercises in the list and created
# a function (design and code) for their Exercise.
# After each person on the team completed their exercise, we combined the
# exercises into one program: the one you see before you. Each Exercise has 
# its own header to show who designed it, the description for that Exercise, the
# pseudocode, and the code. 
# This header was brought to you by Katherine Sykes.
#####################################################################

	 .data
				# Ed's data section
SRC: 	.space 400		# Arry named SRC 
DEST: 	.space 400 		# Array named DEST
	.globl mainE		# Starting point: must be global			

				# Group data section
message52: .asciiz "Exercise 5.2 was completed by Ed Arellano Mendiola.\n"
message57: .asciiz "Exercise 5.7 was completed by Christopher Welch.\n"
message58: .asciiz "Exercise 5.8 was completed by Katherine Sykes.\n"
opening: .asciiz "The members of our group for Project 6 are Katherine Sykes, Ed Arellano Mendiola, and Christopher Welch.\n"

				# Chris's data section
resulta0:	.asciiz		"  = $a0, the Minimum Value\n"
resulta1:	.asciiz		"  = $a1, the Median Value\n"
resulta2:	.asciiz		"  = $a2, the Maximum Value\n"

				# Katherine's data section
arrayZ:	.space 200		# Each integer takes up 4 bytes.
				# 50 integers * 4 = 200
.text
	main:
	jal displayOpening
	jal edam
	jal chrisw
	jal kaths

	li $v0, 10	# To end main function.
	syscall		# Exit program.

	displayOpening:
		li $v0, 4
		la $a0, opening
		syscall
		jr $ra

#########################Ed Arellano Mendiola's code
edam:
			# Insert message52.
	li $v0, 4
	la $a0, message52
	syscall
			# Insert Ed's code.
mainE:
	la  $a1, SRC 		# $a1 gets address of SRC
	la $a2, DEST 		# $a2 gets address of DEST
	
	li $t0, 100 		# $t0 = 100 Counter assigned 100
	
	loop: lw $t1, 0($a1) 	# $t1= Mem($a1) Loading from SRC(Memory1) to register.
	
#	li $v0, 1		# For Testing, code for printing integer
#	move $a0, $t1		# For Testing, moves contents from $t1 to $a0
#	syscall			# For Testing, does command loaded into $v0
	
	sw $t1, 0($a2) 		# Mem($a2) = $t1 Storing from register to DEST(memory2)
	addi $a1, $a1,4 	# $a1 = $a1+4 Incrementing address of SRC
	addi $a2, $a2,4 	# $a2 = $a2+4 Incrementing address of DEST
	addi $t0, $t0, -1 	# $t0 = $t0 - 1 Decreasing our counter by one
	bgtz $t0, loop 		# Branch if $t0 is greater than 0
	
				# Commented to run multiple functions
#	li $v0, 10 		# terminate program run and
#	syscall 		# return control to system
				# END OF PROGRAM
	
	jr $ra		# To go back to main.


#########################Christopher Welch's code
chrisw:
			# Insert message57.
	li $v0, 4
	la $a0, message57
	syscall
			# Insert Chris's code.
mainC:	li $v0, 5			# system call code for read_integer
	syscall				# reads the input value
	la $a0, ($v0)			# stores input value into $a0

	li $v0, 5			# system call code for read_integer
	syscall				# reads the input value
	la $a1, ($v0)			# stores input value into $a1
	
	li $v0, 5			# system call code for read_integer
	syscall				# reads the input value into $a0
	la $a2, ($v0)			# stores input value into $a2

	bgt $a0, $a1, sortmin1		# if $a0 > $a1, then sortmin1
	bgt $a0, $a2, sortmin2		# if $a0 > $a2, then sortmin2
	bgt $a1, $a2, sortmax		# if $a1 > $a2, then sortmax
	b result			# branch to result if sorted
sortmin1:
	la $t0, ($a0)	  		# $t0 << $a0
	la $a0, ($a1) 			# $a0 << $a1 
	la $a1, ($t0)			# $a1 << $t0
        bgt $a0, $a2, sortmin2		# if $a0 > $a2, then sortmin2
	bgt $a1, $a2, sortmax		# if $a1 > $a2, then sortmax
	b result			# branch to result if sorted
sortmin2:
	la $t1, ($a0)   		# $t1 << $a0
	la $a0, ($a2)	 		# $a0 << $a2 
	la $a2, ($t1)			# $a2 << $t1	
	bgt $a1, $a2, sortmax		# if $a1 > $a2, then sortmax	  
	b result  			# branch to result if sorted
sortmax:
	la $t2, ($a1) 			# $t2 << $a1
	la $a1, ($a2) 			# $a1 << $a2
	la $a2, ($t2)			# $a2 << $t2
	b result			# branch to result
result:	li $v0, 1			# system call code for print_integer
	la $s0, ($a0) 			# $s0 << $a0
	syscall				# print the integer
	
	li $v0, 4	 		# system call code for print_string
	la $a0, resulta0 		# load address of msg. into $a0
 	syscall				# print the string resulta0
	
	la $a0, ($a1)			# $a0 << $a1
	
	li $v0, 1			# system call code for print_integer
	la $s0, ($a0)			# $s0 << $a0
	syscall				# print the integer
	
	li $v0, 4	 		# system call code for print_string
	la $a0, resulta1		# load address of msg. into $a0
 	syscall				# print the string resulta1

	la $a0, ($a2)			# $a0 << $a2
	
 	li $v0, 1			# system call code for print_integer
	la $s0, ($a0)			# $s0 << $a0
	syscall				# print the integer	

	li $v0, 4	 		# system call code for print_string
	la $a0, resulta2		# load address of msg. into $a0
 	syscall				# print the string resulta2

					# Commented to run multiple functions
#	li $v0, 10			# terminate program run and
#	syscall				# return control to system
		
	jr $ra		# To go back to main.

#########################Katherine Sykes's code
	kaths:
			# Insert message58.
	li $v0, 4
	la $a0, message58
	syscall
			# Insert Katherine's code.
			addi $s0, $zero, 20		# Stores 20 into $s0.
			addi $s1, $zero, 56		# Stores 56 into $s1.
			addi $s2, $zero, 16		# Stores 16 into $s2.
			addi $v1, $zero, 0		# Initializes $v1 for the running total.

####################################### Index or Offset of $t0
			addi $t0, $zero, 0		# Initializing $t0. 1st location.
							# To save the result into the 20th	
							# location in the array, this needs to 
							# be shifted by 4 bytes 19 times 
							# (4*19 = 76).

####################################### Start the math equation.
			sw $s0, arrayZ($t0)		# Store the initial value into 1st 
							# position in arrayZ.
			addi $t0, $t0, 4		# Move the index to the 2nd place.

			sra $v1, $s0, 2			# Shift right by 2 is equivalent to 
							# dividing by 4. Stored into $v1 for
							# running total.
			sw $v1, arrayZ($t0)		# Store $v1 into 2nd in arrayZ.
			addi $t0, $t0, 4		# Move the index to the 3rd place.

			addi $v1, $v1, 210		# Add 210 to the running total.
			sw $v1, arrayZ($t0)		# Store $v1 into 3rd in arrayZ.
			addi $t0, $t0, 4		# Move the index to the 4th place.

			sll $v1, $v1, 4			# Shift left by 4 is equivalent to 
							# multiplying by 16. Stored into $v1
							# for running total.
			sw $v1, arrayZ($t0)		# Store $v1 into 4th in arrayZ.
			addi $t0, $t0, 4		# Move the index to the 5th place.

			sub $v1, $s1, $v1		# Subtract the running total from 56.
			sw $v1, arrayZ($t0)		# Store $v1 into 5th in arrayZ.
							# This is the total, but it should be
							# stored into the 20th place in arrayZ.
#			j check				# CheckingÖ Total should = -3384.
			addi $t0, $t0, 60		# Move the index to the 20th place.
			sw $v1, arrayZ($t0)		# Store $v1 into 20th in arrayZ.

###################################### Check the answer.
check:		lw $t6, arrayZ($t0)			# Load word from arrayZís current
							# position into $t6.
			li $v0, 1			# Code to print an integer.
			addi $a0, $t6, 0		# Essentially moves $t6 value to $a0.
			syscall				# Print the result. -3384 displays.

			jr $ra		# To go back to main.