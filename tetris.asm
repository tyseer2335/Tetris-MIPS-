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
	
main: 
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
# DRAW TRIMINO (L - Shape [Orange])
# ---------------------------------------------------------------------------- 
    lw $t0, ADDR_DSPL      # Load base address for the display
    li $t1, 0xFDA403       # Load t1 with the colour Orange
    
    li $s0, 24     # Top left pixel of the Tetrimino
    li $s1, 152    # Next pixel down
    li $s2, 280    # Next pixel down
    li $s3, 284    # Pixel to the right of the last one, making the 'L' shape

    # Assuming $s0 to $s3 contain correct offsets for each block of the Tetrimino
    # Add base address to each offset to get the absolute address
    add $s0, $s0, $t0
    add $s1, $s1, $t0
    add $s2, $s2, $t0
    add $s3, $s3, $t0

    sw $t1, 0($s0)    # Draw the block at the absolute address in $s0
    sw $t1, 0($s1)    # Draw the block at the absolute address in $s1
    sw $t1, 0($s2)    # Draw the block at the absolute address in $s2
    sw $t1, 0($s3)    # Draw the block at the absolute address in $s3


# ----------------------------------------------------------------------------
# START GAME (Jump to Game Loop)
# ---------------------------------------------------------------------------- 
 j game_loop          # Jump to the game loop


##############################################################################
# IMPLEMENT CONTROLS (MILESTONE 2)
##############################################################################
# ----------------------------------------------------------------------------
# MOVE TRIMINO [i] Rightt (press D)
# ---------------------------------------------------------------------------- 
game_loop:
    #------------  1a. Check if key has been pressed  ------------------------ 
    li $t8 0                        # Clear $t8
    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed 
    j sleepy                        # If no key is pressed, go to end of loop

    #------------  1b. Check which key has been pressed  ----------------------         
keyboard_input:  
    lw $a0, 4($t0)                # Load second word from keyboard
    # Check for 'D' (move right)
    li $t9, 0x64                  # ASCII for 'D'
    beq $a0, $t9, move_right

    # Check for 'A' (move left)
    li $t9, 0x61                  # ASCII for 'A'
    beq $a0, $t9, move_left

    # Check for 'S' (move down)
    li $t9, 0x73                  # ASCII for 'S'
    beq $a0, $t9, move_down

    # Check for 'W' (move up)
    li $t9, 0x77                  # ASCII for 'W'
    beq $a0, $t9, move_up

    # Check for Escape (quit game)
    li $t9, 0x1B             # ASCII for Escape
    beq $a0, $t9, quit_game
    
    b game_loop


   #-----------------------  2a. Check for collisions  -------------------------



   #------------------  2b. Update locations (paddle, ball)  --------------------
   
   
   
   
   #---------------------------  Draw the screen  -------------------------------- 
   move_right: 	
    # Assume $t1 has the Tetrimino color (orange), and $t2 has the background color (white)
    li $t1, 0xFDA403       # Tetrimino color (orange)
    li $t2, 0x222831       # Color for black
    lw $t0, ADDR_DSPL      # Load base address for the display

    # Clear the old position by coloring the pixels black
    sw $t2, 0($s0)  
    sw $t2, 0($s1)
    sw $t2, 0($s2) 
    sw $t2, 0($s3)

    # Calculate the new position by adding 4 to each register holding a position
    addi $s0, $s0, 4  
    addi $s1, $s1, 4
    addi $s2, $s2, 4  
    addi $s3, $s3, 4

    # Draw the Tetrimino in the new position
    sw $t1, 0($s0)  
    sw $t1, 0($s1)
    sw $t1, 0($s2) 
    sw $t1, 0($s3)
    
    li $v0, 32                      # Set syscall number for sleep operation
    li $a0, 500                     # Set sleep duration in milliseconds (1 second)
    syscall                         # Execute the syscall to sleep
    
	j sleepy
   
   
   move_left: 
   
   move_down: 
   
   move_up: 
   
   quit_game:
   
   
   
   

   #---------------------------  Sleep  --------------------------------
sleepy:
    # Perform the sleep syscall once at the end of the game loop iteration
    li $v0, 32                      # Set syscall number for sleep operation
    li $a0, 1000                    # Set sleep duration in milliseconds (1 second)
    syscall                         # Execute the syscall to sleep
    j game_loop                     # Jump back to the start of the game loop


    







# Exit:
# li $v0, 10 # terminate the program gracefully
# syscall






    #5. Go back to 1
    b game_loop
