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
black_squares: 
    .word 4, 12, 20, 28, 36, 136, 144, 152, 160, 168, 260, 268, 276, 284, 292, 392, 400, 408, 416, 424, 516, 524, 532,  
    540, 548, 648, 656, 664, 672, 680, 772, 780, 788, 796, 804, 904, 912, 920, 928, 936, 1028, 1036, 1044, 1052, 1060,  
    1160, 1168, 1176, 1184, 1192, 1284, 1292, 1300, 1308, 1316, 1416, 1424, 1432, 1440, 1448, 1540, 1548, 1556, 1564,  
    1572, 1672, 1680, 1688, 1696, 1704, 1796, 1804, 1812, 1820, 1828, 1928, 1936, 1944, 1952, 1960, 2052, 2060, 2068,  
    2076, 2084, 2184, 2192, 2200, 2208, 2216, 2308, 2316, 2324, 2332, 2340, 2440, 2448, 2456, 2464, 2472, 2564, 2572,  
    2580, 2588, 2596, 2696, 2704, 2712, 2720, 2728, 2820, 2828, 2836, 2844, 2852, 2952, 2960, 2968, 2976, 2984, 3076,  
    3084, 3092, 3100, 3108, 3208, 3216, 3224, 3232, 3240, 3332, 3340, 3348, 3356, 3364, 3464, 3472, 3480, 3488, 3496,  
    3588, 3596, 3604, 3612, 3620, 3720, 3728, 3736, 3744, 3752, 3844, 3852, 3860, 3868, 3876, 44, 300, 556, 812, 1068, 
    1324, 1580, 1836, 2092, 2348, 2604, 2860, 3116, 3372, 3628, 3884       # Blue 
grey_squares: 
    .word 
    8, 16, 24, 32, 40, 132, 140, 148, 156, 164, 172, 264, 272, 280, 288, 296, 388, 396, 404, 412, 420, 428, 520, 528, 536, 544,  
    552, 644, 652, 660, 668, 676, 684, 776, 784, 792, 800, 808, 900, 908, 916, 924, 932, 940, 1032, 1040, 1048, 1056, 1064, 1156,  
    1164, 1172, 1180, 1188, 1196, 1288, 1296, 1304, 1312, 1320, 1412, 1420, 1428, 1436, 1444, 1452, 1544, 1552, 1560, 1568, 1576, 
    1668, 1676, 1684, 1692, 1700, 1708, 1800, 1808, 1816, 1824, 1832, 1924, 1932, 1940, 1948, 1956, 1964, 2056, 2064, 2072, 2080, 
    2088, 2180, 2188, 2196, 2204, 2212, 2220, 2312, 2320, 2328, 2336, 2344, 2436, 2444, 2452, 2460, 2468, 2476, 2568, 2576, 2584, 
    2592, 2600, 2692, 2700, 2708, 2716, 2724, 2732, 2824, 2832, 2840, 2848, 2856, 2948, 2956, 2964, 2972, 2980, 2988, 3080, 3088, 
    3096, 3104, 3112, 3204, 3212, 3220, 3228, 3236, 3244, 3336, 3344, 3352, 3360, 3368, 3460, 3468, 3476, 3484, 3492, 3500, 3592, 
    3600, 3608, 3616, 3624, 3716, 3724, 3732, 3740, 3748, 3756, 3848, 3856, 3864, 3872, 3880   # Red
taken_spots: 
    .word 
num_taken_spots: 
    .word 2
num_squares: 
    .word 171       
taken_spots_by_trimino: 
    .word 24, 152, 280, 284
rotation_state:  
    .word 0  
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
    beq $a0, $t9, rotate

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
    
	j sleepy
   
   
 move_left: 	
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
    addi $s0, $s0, -4  
    addi $s1, $s1, -4
    addi $s2, $s2, -4  
    addi $s3, $s3, -4

    # Draw the Tetrimino in the new position
    sw $t1, 0($s0)  
    sw $t1, 0($s1)
    sw $t1, 0($s2) 
    sw $t1, 0($s3)
    
	j sleepy
   
   
 move_down: 	
 
# ----------------------------------------------------------------------------
# Checkerboard Repainter
# ---------------------------------------------------------------------------- 

li $t2, 0xFF0000  # Red color for painting squares
    lw $t0, ADDR_DSPL # Load base address of the display into $t0
    la $t1, black_squares # Load the address of the black_squares array into $t1
    lw $t3, num_squares  # Total number of elements in black_squares
    li $t4, 0  # Index counter for iterating through black_squares

loop_squares:
    beq $t4, $t3, end_loop  # End loop if all squares are checked
    lw $t5, 0($t1)          # Load the current square offset into $t5

    # Initialize variables for checking taken spots
    la $t7, taken_spots     # Address of taken_spots array
    lw $t8, num_taken_spots # Load the number of taken spots
    li $t9, 0  # Index counter for taken_spots
    li $t6, 0  # Flag for checking if current square is taken

check_if_taken:
    beq $t9, $t8, not_taken # Check if all taken spots are iterated
    lw $a0, 0($t7)          # Load the current taken spot
    beq $t5, $a0, skip_square # If square is taken, skip painting
    addiu $t7, $t7, 4       # Move to the next taken spot
    addiu $t9, $t9, 1       # Increment taken spots index
    j check_if_taken

not_taken:
    beqz $t6, paint_square # Paint square if it's not marked as taken

skip_square:
    li $t6, 1  # Mark as taken to skip painting
    j update_index

paint_square:
    add $a1, $t0, $t5       # Calculate the absolute address for the square
    sw $t2, 0($a1)          # Paint the square red

update_index:
    addiu $t1, $t1, 4       # Move to the next element in the array
    addiu $t4, $t4, 1       # Increment the index counter
    j loop_squares          # Jump back to iterate over the next square

end_loop:
    # Add logic here to continue after the loop
    
    
    


    
    

li $t2, 0x0000FF  # Red color for painting squares
    lw $t0, ADDR_DSPL # Load base address of the display into $t0
    la $t1, grey_squares # Load the address of the black_squares array into $t1
    lw $t3, num_squares  # Total number of elements in grey_squares
    li $t4, 0  # Index counter for iterating through black_squares

loop_squares2:
    beq $t4, $t3, end_loop2  # End loop if all squares are checked
    lw $t5, 0($t1)          # Load the current square offset into $t5

    # Initialize variables for checking taken spots
    la $t7, taken_spots     # Address of taken_spots array
    lw $t8, num_taken_spots # Load the number of taken spots
    li $t9, 0  # Index counter for taken_spots
    li $t6, 0  # Flag for checking if current square is taken

check_if_taken2:
    beq $t9, $t8, not_taken2 # Check if all taken spots are iterated
    lw $a0, 0($t7)          # Load the current taken spot
    beq $t5, $a0, skip_square2 # If square is taken, skip painting
    addiu $t7, $t7, 4       # Move to the next taken spot
    addiu $t9, $t9, 1       # Increment taken spots index
    j check_if_taken2

not_taken2:
    beqz $t6, paint_square2 # Paint square if it's not marked as taken

skip_square2:
    li $t6, 1  # Mark as taken to skip painting
    j update_index2

paint_square2:
    add $a1, $t0, $t5       # Calculate the absolute address for the square
    sw $t2, 0($a1)          # Paint the square red

update_index2:
    addiu $t1, $t1, 4       # Move to the next element in the array
    addiu $t4, $t4, 1       # Increment the index counter
    j loop_squares2          # Jump back to iterate over the next square

end_loop2:
    # Add logic here to continue after the loop





    
# ----------------------------------------------------------------------------
# Checkerboard Repainter
# ----------------------------------------------------------------------------  
 

 
    # Assume $t1 has the Tetrimino color (orange), and $t2 has the background color (white)
    li $t1, 0xFDA403       # Tetrimino color (orange)
    lw $t0, ADDR_DSPL      # Load base address for the display

    # # Clear the old position by coloring the pixels black
    # sw $t2, 0($s0)  
    # sw $t2, 0($s1)
    # sw $t2, 0($s2) 
    # sw $t2, 0($s3)

    # Calculate the new position by adding 4 to each register holding a position
    addi $s0, $s0, 128  
    addi $s1, $s1, 128
    addi $s2, $s2, 128  
    addi $s3, $s3, 128

    # Draw the Tetrimino in the new position
    sw $t1, 0($s0)  
    sw $t1, 0($s1)
    sw $t1, 0($s2) 
    sw $t1, 0($s3)
    
	j sleepy
   
	
rotate: 
    # Load the current rotation state
    lw $t4, rotation_state
    
    # Increment the rotation state
    addi $t4, $t4, 1
    li $t5, 4
    div $t4, $t5
    mfhi $t4                # Use the remainder to keep the state within [0,3]
    sw $t4, rotation_state  # Store the updated state back

    # Based on the rotation state, select the Tetrimino's color
    lw $t0, ADDR_DSPL       # Base address for the display
    beq $t4, 0, rotate_L_state_1
    beq $t4, 1, rotate_L_state_2
    beq $t4, 2, rotate_L_state_3
    beq $t4, 3, rotate_L_state_4
    
rotate_L_state_2: 
    li $t1, 0xFDA403       # Tetrimino color (orange)
    li $t2, 0x222831       # Color for black
    li $t6, 0x31363F       # Color for grey
    lw $t0, ADDR_DSPL      # Load base address for the display   

    # Paint blocks with Tetrimino color
    sw $t2, 0($s0)    
    #sw $t2, 0($s1)  
    sw $t2, 0($s2) 
    sw $t6, 0($s3)  
    j end_rotate_L_state_2 
    
end_rotate_L_state_2:
    # Offset the blocks (To Do Colliosn Detection)
    addi $s0, $s0, 124 
    #addi $s1, $s1, 0 
    addi $s2, $s2, -4
    addi $s3, $s3, -128  

    # Paint
    sw $t1, 0($s0) 
    sw $t1, 0($s1) 
    sw $t1, 0($s2)
    sw $t1, 0($s3) 
    
    j sleepy

rotate_L_state_3:
    li $t1, 0xFDA403       # Tetrimino color (orange)
    li $t2, 0x222831       # Color for black
    li $t6, 0x31363F       # Color for grey
    lw $t0, ADDR_DSPL      # Load base address for the display
    
    # Paint blocks according to colorFlag == 1 scheme
    sw $t2, 0($s0)
    #sw $t2, 0($s1)    # Uncomment if $s1 needs painting
    sw $t6, 0($s2)
    sw $t2, 0($s3)
    j paint_and_offset_state_3


paint_and_offset_state_3:
    # Offset the blocks (For Collision Detection or positioning)
    addi $s0, $s0, -128
    #addi $s1, $s1, 0    # Uncomment if $s1 needs offset adjustment
    addi $s2, $s2, 4
    addi $s3, $s3, -132

    # Re-paint Tetrimino blocks with Tetrimino color after offsetting
    sw $t1, 0($s0)
    sw $t1, 0($s1)   # Ensure $s1 is defined or uncommented if used
    sw $t1, 0($s2)
    sw $t1, 0($s3)
    
    j sleepy


rotate_L_state_4:
    li $t1, 0xFDA403       # Tetrimino color (orange)
    li $t2, 0x222831       # Color for black
    li $t6, 0x31363F       # Color for grey
    lw $t0, ADDR_DSPL      # Load base address for the display

    # Color scheme for colorFlag == 1
    sw $t6, 0($s0)    
    sw $t6, 0($s1)  
    sw $t2, 0($s2) 
    sw $t2, 0($s3)  
    j offset_and_paint_state_4 
    
    
offset_and_paint_state_4:
    # Offset the blocks (For Collision Detection or positioning)
    addi $s0, $s0, 256
    addi $s1, $s1, 4 
    addi $s3, $s3, 260  

    # Re-paint Tetrimino blocks with Tetrimino color after offsetting
    sw $t1, 0($s0) 
    sw $t1, 0($s1) 
    sw $t1, 0($s2)
    sw $t1, 0($s3) 
    
    j sleepy

rotate_L_state_1:
    li $t1, 0xFDA403       # Tetrimino color (orange)
    li $t2, 0x222831       # Color for black
    li $t6, 0x31363F       # Color for grey
    lw $t0, ADDR_DSPL      # Load base address for the display
    

    # Color scheme for colorFlag == 1
    sw $t6, 0($s0)    
    sw $t2, 0($s1)  
    # The next two lines are commented out because they are not being painted in this state
    # But if needed, here's how it would look:
    # sw $t2, 0($s2) 
    # sw $t2, 0($s3)
    j offset_and_paint_state_1 
    
    
offset_and_paint_state_1:
    # Offset the blocks (For Collision Detection or positioning)
    addi $s0, $s0, -252
    addi $s1, $s1, -4 
    # Since $s2 and $s3 are not being offset, they're commented out
    # addi $s2, $s2, 0
    # addi $s3, $s3, 0

    # Re-paint Tetrimino blocks with Tetrimino color after offsetting
    sw $t1, 0($s0) 
    sw $t1, 0($s1) 
    # sw $t1, 0($s2)
    # sw $t1, 0($s3)
    
    j sleepy















quit_game:
    li $v0, 10 # terminate the program gracefully
    syscall
   
   
   

   #---------------------------  Sleep  --------------------------------
sleepy:
    # Perform the sleep syscall once at the end of the game loop iteration
    li $v0, 32                      # Set syscall number for sleep operation
    li $a0, 20                      # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep
    j game_loop                     # Jump back to the start of the game loop


    






















# Exit:
# li $v0, 10 # terminate the program gracefully
# syscall






    #5. Go back to 1
    b game_loop
