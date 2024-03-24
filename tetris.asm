################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
# Student 1: Tyseer Toufiq, 1009364064

######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       8
# - Unit height in pixels:      8
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################
    .data
ADDR_DSPL:
    .word 0x10008000
ADDR_KBRD:
    .word 0xffff0000
	.text
	.globl main

main: # 0x10008000
##############################################################################
# DRAW THE SCENE (MILESTONE 1)
##############################################################################

# ----------------------------------------------------------------------------
# DRAW VERTICAL WALL (Left Side)
# ---------------------------------------------------------------------------- 
    lw $t0, ADDR_DSPL      # Load base address for the display
    li $t1, 0xFFEDD8       # Load color Wall into $t1
    li $t2, 64             # Set the loop counter for 64 iterations
draw_vertical_wall:
    sw $t1, 0($t0)         # Paint the pixel at the current address     
    addi $t0, $t0, 128     # Move the address down by two units (8 bytes per unit)
    addi $t2, $t2, -1      # Decrement the loop counter 
    # If the loop counter is not zero, continue the loop
    bnez $t2, draw_vertical_wall

# ----------------------------------------------------------------------------
# CHECKERBOARD PATTERN (Draw Even Columns)
# ----------------------------------------------------------------------------
    lw $t0, ADDR_DSPL      # Load the base address of the display into $t0
    li $t6, 0x31363F       # Load color Grey into $t6
    li $t7, 0x222831       # Load color Black into $t7
    li $t5, 44             # Initialize the offset for the column

draw_columns_even:
    li $t1, 4              # Exit the loop when we have reached the offset of 4 
    blt $t5, $t1, draw_next_col # Calculate the starting address for this column
    add $t8, $t0, $t5      # $t8 is the address for this column
    li $t2, 64             # Initialize loop counter for rows
    li $t3, 0              # Counter to alternate colors
draw_checkerboard_row_even: 
    # If $t3 is not zero, draw black, otherwise draw grey
    bne $t3, 0, draw_balck_even   
draw_green_even:
    sw $t6, 0($t8)         # Paint the pixel at the current address
    j draw_next_even
draw_balck_even:
    sw $t7, 0($t8)         # Paint the pixel at the current address black
draw_next_even:
    addi $t8, $t8, 128     # Move the address down by two units
    addi $t3, $t3, 1       # Increment the alternate counter
    andi $t3, $t3, 1       # Keep $t3 value as 0 or 1
    addi $t2, $t2, -1      # Decrement the loop counter
    bnez $t2, draw_checkerboard_row_even  # If the loop counter is not zero, continue the loop
    addi $t5, $t5, -8      # Decrement the column offset by 4 and repeat the process
    j draw_columns_even    # Jump back to the beginning of the column drawing loop


# ----------------------------------------------------------------------------
# CHECKERBOARD PATTERN (Draw Odd Columns)
# ---------------------------------------------------------------------------- 
draw_next_col:
    lw $t0, ADDR_DSPL      # Load the base address of the display into $t0
    li $t6, 0x222831       # Load color Black into $t6
    li $t7, 0x31363F       # Load color Grey into $t7
    li $t5, 40             # Initialize the offset for the column to 56

draw_columns_odd:
    li $t1, 4              # Exit the loop when we have reached the offset of 4
    blt $t5, $t1, checkerboard_done  
    # Calculate the starting address for this column
    add $t8, $t0, $t5      # $t8 is the address for this column
    li $t2, 64             # Initialize loop counter for rows
    li $t3, 0              # Counter to alternate colors
draw_checkerboard_row_odd: 
    # If $t3 is not zero, draw grey, otherwise draw black
    bne $t3, 0, draw_blue_odd  
draw_green_odd:
    sw $t6, 0($t8)         # Paint the pixel at the current address
    j draw_next_odd
draw_blue_odd:
    sw $t7, 0($t8)         # Paint the pixel at the current address
draw_next_odd:
    addi $t8, $t8, 128     # Move the address down by two units
    addi $t3, $t3, 1       # Increment the alternate counter
    andi $t3, $t3, 1       # Keep $t3 value as 0 or 1
    addi $t2, $t2, -1      # Decrement the loop counter 
    # If the loop counter is not zero, continue the loop
    bnez $t2, draw_checkerboard_row_odd  
    
    # Decrement the column offset by 4 and repeat the process
    addi $t5, $t5, -8
    j draw_columns_odd  # Jump back to the beginning of the column drawing loop
checkerboard_done:
# ----------------------------------------------------------------------------
# DRAW HORIZONTAL WALLS (Bottom)
# ---------------------------------------------------------------------------- 
    lw $t0, ADDR_DSPL      # Load base address for the display
    li $t1, 0xFFEDD8       # Load color Wall into $t1
    li $t2, 12             # Set the loop counter for 64 iterations
draw_horizontal_wall:
    sw $t1, 3968($t0)     # Paint the pixel at the current address   
    addi $t0, $t0, 4     # Move the address down by two units (8 bytes per unit)
    addi $t2, $t2, -1      # Decrement the loop counter 
    # If the loop counter is not zero, continue the loop
    bnez $t2, draw_horizontal_wall  

# ----------------------------------------------------------------------------
# DRAW VERTICAL WALL (Left Side)
# ---------------------------------------------------------------------------- 
    lw $t0, ADDR_DSPL      # Load base address for the display
    li $t1, 0xFFEDD8       # Load color Wall into $t1
    li $t2, 64             # Set the loop counter for 64 iterations
draw_other_vertical_wall: 
    sw $t1, 48($t0)   
    addi $t0, $t0, 128     # Move the address down by two units (8 bytes per unit)
    addi $t2, $t2, -1      # Decrement the loop counter 
    # If the loop counter is not zero, continue the loop
    bnez $t2, draw_other_vertical_wall
    
# ----------------------------------------------------------------------------
# DRAW TRIMINO (l - Hard Coded)
# ---------------------------------------------------------------------------- 
lw $t0, ADDR_DSPL      # Load base address for the display
li $t1, 0xFDA403       # Load t1 with the colour Orange

# Paint the Pixles
# sw $t1, 3844($t0)
# sw $t1, 3716($t0) 
# sw $t1, 3588($t0)  
# sw $t1, 3848($t0) 

sw $t1, 24($t0)  
sw $t1, 152($t0)
sw $t1, 280($t0) 
sw $t1, 284($t0) 




##############################################################################
# IMPLEMENT CONTROLS (MILESTONE 2)
##############################################################################






game_loop:
	# 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    b game_loop


Exit:
li $v0, 10 # terminate the program gracefully
syscall