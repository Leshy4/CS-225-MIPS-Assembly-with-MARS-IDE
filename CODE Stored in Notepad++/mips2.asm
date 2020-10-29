#####################################################################
# Assignment #6: Min/Max Value	Programmer: Chris Welch
# Due Date: 4-10-18			Course: CSC 225 040
# Last Modified: 4-7-18
#####################################################################
# Functional Description:
# This program receives 3 integer values from the keyboard
# Then sorts the values to Minimum and Maximum, with the other number being the Median Value.
# Then prints the Minimum Value as $a0, the Median Value as $a1, and the Maximum Value as $a2.
#
#####################################################################
# Pseudocode:
# main:	cin >> $a0 
# 	cin >> $a1
# 	cin >> $a2
# 	if ($a0 > $a1),	then sortmin1 or
#	if ($a0 > $a2),	then sortmin2 or
#	if ($a1 > $a2),	then sortmax
#	else result
# sortmin1:
#	$t0 << $a0, $a0 << $a1, $a1 << $t0
#	if $a0 > $a2, then sortmin2 or
# 	if $a1 > $a2, then sortmax
# 	else result
# sortmin2:
#	$t1 << $a0, $a0 << $a2, $a2 << $t1
# 	if $a1 > $a2, then sortmax
# 	else result
# sortmax: 
#	$t2 << $a1, $a1 << $a2, $a2 << $t2
# result:
#	print $a0, resulta0
#	print $a1, resulta1
#	print $a2, resulta2
#	End	
######################################################################
# Register Usage:
# $v0: User Input Value Catcher
# $a0: First Input / Minimum Value / Integer Catcher
# $a1: Second  Input / Median Value
# $a2: Third Input / Maximum Value
# $a3: Program Header
# $t0: Temporary Minimum Value
# $t1: Temporary Minimum Value
# $t2: Temporary Maximum Value
# $s0: String Catcher
######################################################################
	.data				# Data declaration section
resulta0:	.asciiz	 		"  = $a0, the Minimum Value\n"
resulta1:	.asciiz	 		"  = $a1, the Median Value\n"
resulta2:	.asciiz	 		"  = $a2, the Maximum Value\n"
	.text				# Executable code follows
main:	li $v0, 5			# system call code for read_integer
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
	 	
	li $v0, 10			# terminate program run and
	syscall				# return control to system

					# END OF PROGRAM