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
row_1:  .word 3844, 3848, 3844, 3852, 3856, 3860, 3864, 3868, 3872, 3876, 3880, 3884
row_2:  .word 3716, 3720, 3716, 3724, 3728, 3732, 3736, 3740, 3744, 3748, 3752, 3756
row_3:  .word 3588, 3592, 3588, 3596, 3600, 3604, 3608, 3612, 3616, 3620, 3624, 3628
row_4:  .word 3460, 3464, 3460, 3468, 3472, 3476, 3480, 3484, 3488, 3492, 3496, 3500
row_5:  .word 3332, 3336, 3332, 3340, 3344, 3348, 3352, 3356, 3360, 3364, 3368, 3372
row_6:  .word 3204, 3208, 3204, 3212, 3216, 3220, 3224, 3228, 3232, 3236, 3240, 3244
row_7:  .word 3076, 3080, 3076, 3084, 3088, 3092, 3096, 3100, 3104, 3108, 3112, 3116
row_8:  .word 2948, 2952, 2948, 2956, 2960, 2964, 2968, 2972, 2976, 2980, 2984, 2988
row_9:  .word 2820, 2824, 2820, 2828, 2832, 2836, 2840, 2844, 2848, 2852, 2856, 2860
row_10: .word 2692, 2696, 2692, 2700, 2704, 2708, 2712, 2716, 2720, 2724, 2728, 2732
row_11: .word 2564, 2568, 2564, 2572, 2576, 2580, 2584, 2588, 2592, 2596, 2600, 2604
row_12: .word 2436, 2440, 2436, 2444, 2448, 2452, 2456, 2460, 2464, 2468, 2472, 2476
row_13: .word 2308, 2312, 2308, 2316, 2320, 2324, 2328, 2332, 2336, 2340, 2344, 2348
row_14: .word 2180, 2184, 2180, 2188, 2192, 2196, 2200, 2204, 2208, 2212, 2216, 2220
row_15: .word 2052, 2056, 2052, 2060, 2064, 2068, 2072, 2076, 2080, 2084, 2088, 2092
row_16: .word 1924, 1928, 1924, 1932, 1936, 1940, 1944, 1948, 1952, 1956, 1960, 1964
row_17: .word 1796, 1800, 1796, 1804, 1808, 1812, 1816, 1820, 1824, 1828, 1832, 1836
row_18: .word 1668, 1672, 1668, 1676, 1680, 1684, 1688, 1692, 1696, 1700, 1704, 1708
row_19: .word 1540, 1544, 1540, 1548, 1552, 1556, 1560, 1564, 1568, 1572, 1576, 1580
row_20: .word 1412, 1416, 1412, 1420, 1424, 1428, 1432, 1436, 1440, 1444, 1448, 1452
row_21: .word 1284, 1288, 1284, 1292, 1296, 1300, 1304, 1308, 1312, 1316, 1320, 1324
row_22: .word 1156, 1160, 1156, 1164, 1168, 1172, 1176, 1180, 1184, 1188, 1192, 1196
row_23: .word 1028, 1032, 1028, 1036, 1040, 1044, 1048, 1052, 1056, 1060, 1064, 1068
row_24: .word 900,  904,  900,  908,  912,  916,  920,  924,  928,  932,  936,  940
row_25: .word 772,  776,  772,  780,  784,  788,  792,  796,  800,  804,  808,  812
row_26: .word 644,  648,  644,  652,  656,  660,  664,  668,  672,  676,  680,  684
row_27: .word 516,  520,  516,  524,  528,  532,  536,  540,  544,  548,  552,  556
row_28: .word 388,  392,  388,  396,  400,  404,  408,  412,  416,  420,  424,  428
row_29: .word 260,  264,  260,  268,  272,  276,  280,  284,  288,  292,  296,  300
row_30: .word 132,  136,  132,  140,  144,  148,  152,  156,  160,  164,  168,  172
row_31: .word 4,    8,    4,    12,   16,   20,   24,   28,   32,   36,   40,   44
piece_state: 
    .word 1
pause_state: 
    .word 1
actionCounter: .word 0
black_squares: 
    .word 4, 12, 20, 28, 36, 136, 144, 152, 160, 168, 260, 268, 276, 284, 292, 392, 400, 408, 416, 424, 516, 524, 532,  
    540, 548, 648, 656, 664, 672, 680, 772, 780, 788, 796, 804, 904, 912, 920, 928, 936, 1028, 1036, 1044, 1052, 1060,  
    1160, 1168, 1176, 1184, 1192, 1284, 1292, 1300, 1308, 1316, 1416, 1424, 1432, 1440, 1448, 1540, 1548, 1556, 1564,  
    1572, 1672, 1680, 1688, 1696, 1704, 1796, 1804, 1812, 1820, 1828, 1928, 1936, 1944, 1952, 1960, 2052, 2060, 2068,  
    2076, 2084, 2184, 2192, 2200, 2208, 2216, 2308, 2316, 2324, 2332, 2340, 2440, 2448, 2456, 2464, 2472, 2564, 2572,  
    2580, 2588, 2596, 2696, 2704, 2712, 2720, 2728, 2820, 2828, 2836, 2844, 2852, 2952, 2960, 2968, 2976, 2984, 3076,  
    3084, 3092, 3100, 3108, 3208, 3216, 3224, 3232, 3240, 3332, 3340, 3348, 3356, 3364, 3464, 3472, 3480, 3488, 3496,  
    3588, 3596, 3604, 3612, 3620, 3720, 3728, 3736, 3744, 3752, 3844, 3852, 3860, 3868, 3876, 44, 300, 556, 812, 1068, 
    1324, 1580, 1836, 2092, 2348, 2604, 2860, 3116, 3372, 3628, 3884 
grey_squares: 
    .word 
    8, 16, 24, 32, 40, 132, 140, 148, 156, 164, 172, 264, 272, 280, 288, 296, 388, 396, 404, 412, 420, 428, 520, 528, 536, 544,  
    552, 644, 652, 660, 668, 676, 684, 776, 784, 792, 800, 808, 900, 908, 916, 924, 932, 940, 1032, 1040, 1048, 1056, 1064, 1156,  
    1164, 1172, 1180, 1188, 1196, 1288, 1296, 1304, 1312, 1320, 1412, 1420, 1428, 1436, 1444, 1452, 1544, 1552, 1560, 1568, 1576, 
    1668, 1676, 1684, 1692, 1700, 1708, 1800, 1808, 1816, 1824, 1832, 1924, 1932, 1940, 1948, 1956, 1964, 2056, 2064, 2072, 2080, 
    2088, 2180, 2188, 2196, 2204, 2212, 2220, 2312, 2320, 2328, 2336, 2344, 2436, 2444, 2452, 2460, 2468, 2476, 2568, 2576, 2584, 
    2592, 2600, 2692, 2700, 2708, 2716, 2724, 2732, 2824, 2832, 2840, 2848, 2856, 2948, 2956, 2964, 2972, 2980, 2988, 3080, 3088, 
    3096, 3104, 3112, 3204, 3212, 3220, 3228, 3236, 3244, 3336, 3344, 3352, 3360, 3368, 3460, 3468, 3476, 3484, 3492, 3500, 3592, 
    3600, 3608, 3616, 3624, 3716, 3724, 3732, 3740, 3748, 3756, 3848, 3856, 3864, 3872, 3880 
walls: 
    .word 0, 128, 256, 384, 512, 640, 768, 896, 1024, 1152, 1280, 1408, 1536, 1664, 1792, 1920, 2048, 2176, 2304, 2432, 2560, 2688,  
    2816, 2944, 3072, 3200, 3328, 3456, 3584, 3712, 3840, 3968, 3972, 3976, 3980, 3984, 3988, 3992, 3996, 4000, 4004, 4008, 4012, 4016,  
    3888, 3760, 3632, 3504, 3376, 3248, 3120, 2992, 2864, 2992, 2864, 2736, 2608, 2480, 2352, 2224, 2096, 1968, 1840, 1712, 1584, 1456,  
    1328, 1200, 1072, 944, 816, 688, 560, 432, 304, 176, 48, 52, 180, 308, 436, 564, 692, 820, 948, 1076, 1204, 1332, 1460, 1588, 1716,  
    1844, 1972, 2100, 2228, 2356, 2484, 2612, 2740, 2868, 2996, 3124, 3252, 3380, 3508, 3636, 3764, 3892, 4020, 
    56, 184, 312, 440, 568, 696, 824, 952, 1080, 1208, 1336, 1464, 1592, 1720, 1848, 1976, 2104, 2232, 2360, 2488, 2616, 2744, 2872, 3000, 3128, 3256, 3384, 3512, 3640, 3768, 3896, 4024  
    60, 188, 316, 444, 572, 700, 828, 956, 1084, 1212, 1340, 1468, 1596, 1724, 1852, 1980, 2108, 2236, 2364, 2492, 2620, 2748, 2876, 3004, 3132, 3260, 3388, 3516, 3644, 3772, 3900, 4028, 
    64, 192, 320, 448, 576, 704, 832, 960, 1088, 1216, 1344, 1472, 1600, 1728, 1856, 1984, 2112, 2240, 2368, 2496, 2624, 2752, 2880, 3008, 3136, 3264, 3392, 3520, 3648, 3776, 3904, 4032, 
    68, 196, 324, 452, 580, 708, 836, 964, 1092, 1220, 1348, 1476, 1604, 1732, 1860, 1988, 2116, 2244, 2372, 2500, 2628, 2756, 2884, 3012, 3140, 3268, 3396, 3524, 3652, 3780, 3908, 4036, 
    4164, 4292, 4420, 4548, 4676, 4804, 4932, 5060, 5188, 5316, 5444, 5572, 5700, 5828, 5956, 6084, 6212, 6340, 6468, 6596, 6724, 6852, 6980, 7108, 7236, 7364, 7492, 7620, 7748, 7876, 8004 
    8132, 8260, 8388, 8516, 8644, 8772, 8900, 9028, 9156, 9284, 9412, 9540, 9668, 9796, 9924, 10052, 10180, 10308, 10436, 10564, 10692, 10820, 10948, 11076, 11204, 11332, 11460, 11588, 11716, 11844, 11972, 
    12096, 12220, 12344, 12468, 12592, 12716, 12840, 12964, 13088, 13212, 13336, 13460, 13584, 13708, 13832, 13956, 14080, 14204, 14328, 14452, 14576, 14700, 14824, 14948, 15072, 15196, 15320, 15444, 15568, 15692, 15816, 
    72, 200, 328, 456, 584, 712, 840, 968, 1096, 1224, 1352, 1480, 1608, 1736, 1864, 1992, 2120, 2248, 2376, 2504, 2632, 2760, 2888    
num_walls: 
    .word 120
taken_spots: 
    .space 800
num_taken_spots: 
    .word 0
num_squares: 
    .word 171   
ground:
    .word 3844, 3848, 3852, 3856, 3860, 3864, 3868, 3872, 3876, 3880, 3884    
num_ground:
    .word 11  
pieces: 
    .word 
num_pieces: 
    .word 0    
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
# DRAW WALL
##############################################################################
    li $t2, 0xFFEDD8              # White color for painting squares
    lw $t0, ADDR_DSPL             # Load base address of the display into $t0
    la $t1, walls                 # Load the address of the walls array into $t1
    lw $t3, num_walls             # Load the total number of elements in walls array from num_walls
    li $t4, 0                     # Index counter for iterating through walls array
loop_walls:
    beq $t4, $t3, end_loop_walls  # End loop if all walls are checked
    lw $t5, 0($t1)                # Load the current wall offset into $t5
    add $t6, $t0, $t5             # Calculate the absolute address for the wall
    sw $t2, 0($t6)                # Paint the wall white
    addiu $t1, $t1, 4             # Move to the next element in the array
    addiu $t4, $t4, 1             # Increment the index counter
    j loop_walls                  # Jump back to iterate over the next wall
end_loop_walls: 
    lw $t0, ADDR_DSPL             # Load base address for the display
    li $t1, 0xFFEDD8              # Load color Wall into $t1
    li $t3, 56                    # Initial offset for drawing
    li $t5, 64                    # Set the loop counter for 64 iterations for vertical line drawing
outer_loop:
    move $t2, $t5                 # Reset the loop counter for 64 iterations for each vertical line
    add $t6, $t0, $t3             # Calculate the current base address plus offset for drawing
draw_vertical_wall: 
    sw $t1, 0($t6)                # Draw at the current position+offset
    addi $t6, $t6, 128            # Move the address down by two units (8 bytes per unit)
    addi $t2, $t2, -1             # Decrement the loop counter 
    bnez $t2, draw_vertical_wall  # If the loop counter is not zero, continue the loop
    addi $t3, $t3, 4              # Increment the offset for the next line
                                  # Check if we've completed all desired offsets
    blt $t3, 128, outer_loop      # If the offset is less than 124, prepare for the next line
##############################################################################
# DRAW GROUND WALLS (Bottom)
##############################################################################
 la $t0, ground                   # Load the base address of the ground array into $t0
    li $t1, 3840                  # Initialize the starting position of the bottom wall
    li $t2, 12                    # Set the loop counter for 12 iterations
save_ground_positions:
    sw $t1, 0($t0)                # Save the position into the ground array
    addi $t1, $t1, 4              # Move to the next position (4 bytes per position)
    addi $t0, $t0, 4              # Move to the next space in the ground array
    addi $t2, $t2, -1             # Decrement the loop counter
    bnez $t2, save_ground_positions    
##############################################################################
# DRAW CHECKERBOARD PATTERN FUNCTION (Used Later also to repaint board)
##############################################################################
jal checkerboard_repainter
j checkerboard_done
checkerboard_repainter:
li $t2, 0x31363F                  # Color for painting squares
    lw $t0, ADDR_DSPL             # Load base address of the display into $t0
    la $t1, black_squares         # Load the address of the black_squares array into $t1
    lw $t3, num_squares           # Total number of elements in black_squares
    li $t4, 0                     # Index counter for iterating through black_squares
loop_squares:
    beq $t4, $t3, end_loop        # End loop if all squares are checked
    lw $t5, 0($t1)                # Load the current square offset into $t5
                                  # Initialize variables for checking taken spots
    la $t7, taken_spots           # Address of taken_spots array
    lw $t8, num_taken_spots       # Load the number of taken spots
    li $t9, 0                     # Index counter for taken_spots
    li $t6, 0                     # Flag for checking if current square is taken
check_if_taken:
    beq $t9, $t8, not_taken       # Check if all taken spots are iterated
    lw $a0, 0($t7)                # Load the current taken spot
    beq $t5, $a0, skip_square     # If square is taken, skip painting
    addiu $t7, $t7, 4             # Move to the next taken spot
    addiu $t9, $t9, 1             # Increment taken spots index
    j check_if_taken
not_taken:
    beqz $t6, paint_square        # Paint square if it's not marked as taken
skip_square:
    li $t6, 1                     # Mark as taken to skip painting
    j update_index
paint_square:
    add $a1, $t0, $t5             # Calculate the absolute address for the square
    sw $t2, 0($a1)                # Paint the square
update_index:
    addiu $t1, $t1, 4             # Move to the next element in the array
    addiu $t4, $t4, 1             # Increment the index counter
    j loop_squares                # Jump back to iterate over the next square
end_loop:
li $t2, 0x222831                  # Color for painting squares 
    lw $t0, ADDR_DSPL             # Load base address of the display into $t0
    la $t1, grey_squares          # Load the address of the black_squares array into $t1
    lw $t3, num_squares           # Total number of elements in grey_squares
    li $t4, 0                     # Index counter for iterating through black_squares
loop_squares2:
    beq $t4, $t3, end_loop2       # End loop if all squares are checked
    lw $t5, 0($t1)                # Load the current square offset into $t5
                                  # Initialize variables for checking taken spots
    la $t7, taken_spots           # Address of taken_spots array
    lw $t8, num_taken_spots       # Load the number of taken spots
    li $t9, 0                     # Index counter for taken_spots
    li $t6, 0                     # Flag for checking if current square is taken
check_if_taken2:
    beq $t9, $t8, not_taken2      # Check if all taken spots are iterated
    lw $a0, 0($t7)                # Load the current taken spot
    beq $t5, $a0, skip_square2    # If square is taken, skip painting
    addiu $t7, $t7, 4             # Move to the next taken spot
    addiu $t9, $t9, 1             # Increment taken spots index
    j check_if_taken2
not_taken2:
    beqz $t6, paint_square2       # Paint square if it's not marked as taken
skip_square2:
    li $t6, 1                     # Mark as taken to skip painting
    j update_index2
paint_square2:
    add $a1, $t0, $t5             # Calculate the absolute address for the square
    sw $t2, 0($a1)                # Paint the square
update_index2:
    addiu $t1, $t1, 4             # Move to the next element in the array
    addiu $t4, $t4, 1             # Increment the index counter
    j loop_squares2               # Jump back to iterate over the next square
end_loop2:
    lw $t0, ADDR_DSPL
    li $t1, 0xFFEDD8 	          # $t1 stores the red colour code
    sw $t1, 0($t0) 	        	  # Paint the first pixle of wall because for some reason its grey
jr $ra  
checkerboard_done:
##############################################################################
# DRAW TRIMINO 
##############################################################################
    jal start_the_L
    j exit_program  
start_the_L:
    la $a0, actionCounter
    lw $t0, 0($a0)
    addi $t0, $t0, 1               # Increment actionCounter
    andi $t0, $t0, 0x00000007      # Ensure the counter cycles between 0 and 6
    sw $t0, 0($a0)                 # Depending on the value in $t0, jump to the corresponding action         
    li $t3, 0
    beq $t0, $t3, action0
    li $t3, 1
    beq $t0, $t3, action1
    li $t3, 2
    beq $t0, $t3, action2
    li $t3, 3
    beq $t0, $t3, action3
    li $t3, 4
    beq $t0, $t3, action4
    li $t3, 5
    beq $t0, $t3, action5
    li $t3, 6
    beq $t0, $t3, action6
    j start_the_L_done             # In case none of the conditions are met, though this shouldn't happen with correct setup.
action0:
##############################################################################
# DRAW TRIMINO (O - Shape)
##############################################################################   
    li $t9, 0xFFEDD8               # Colour over the prevous
    lw $t7, ADDR_DSPL 
    sw $t9, 196($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    la $a0, piece_state  
    li $t0, 0             
    sw $t0, 0($a0)                  # Set the peice state to 0
    la $t0, rotation_state          # Load the address of rotation_state into $t0
    li $t1, 0                       # Load the value 0 into $t1
    sw $t1, 0($t0) 
    li $s0, 156                     # Top left pixel of the Tetrimino
    li $s1, 152    
    li $s2, 280    
    li $s3, 284    
    li $t9, 0x378CE7                # Color for painting squares
    lw $t7, ADDR_DSPL               # Load base address of the display into $t0 
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 448($t7)     
    j continue_after_action
action1:
##############################################################################
# DRAW TRIMINO (I - Shape)
############################################################################## 
    li $t9, 0xFFEDD8                
    lw $t7, ADDR_DSPL               
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 448($t7) 
    la $a0, piece_state  
    li $t0, 1             
    sw $t0, 0($a0) 
    la $t0, rotation_state  
    li $t1, 0              
    sw $t1, 0($t0) 
    li $s0, 24     
    li $s1, 152    
    li $s2, 280    
    li $s3, 408    
    li $t9, 0xFF204E             
    lw $t7, ADDR_DSPL              
    sw $t9, 196($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    j continue_after_action
action2:
##############################################################################
# DRAW TRIMINO (S - Shape)
##############################################################################
    li $t9, 0xFFEDD8             
    lw $t7, ADDR_DSPL              
    sw $t9, 196($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    la $a0, piece_state  
    li $t0, 2             
    sw $t0, 0($a0) 
    la $t0, rotation_state  
    li $t1, 0              
    sw $t1, 0($t0) 
    li $s0, 156     
    li $s1, 152    
    li $s2, 280    
    li $s3, 276   
    li $a1, 10
    li $t9, 0x87A922             
    lw $t7, ADDR_DSPL              
    sw $t9, 192($t7)    
    sw $t9, 188($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    j continue_after_action
action3:
##############################################################################
# DRAW TRIMINO (Z - Shape)
##############################################################################    
    li $t9, 0xFFEDD8             
    lw $t7, ADDR_DSPL             
    sw $t9, 192($t7)    
    sw $t9, 188($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    la $a0, piece_state  
    li $t0, 3             
    sw $t0, 0($a0) 
    la $t0, rotation_state  
    li $t1, 0               
    sw $t1, 0($t0) 
    li $s0, 152     
    li $s1, 148    
    li $s2, 280    
    li $s3, 284        
    li $t9, 0xF6995C             
    lw $t7, ADDR_DSPL             
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    j continue_after_action
action4:
# ############################################################################
# DRAW TRIMINO (L - Shape)
############################################################################## 
    li $t9, 0xFFEDD8              
    lw $t7, ADDR_DSPL             
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    la $a0, piece_state  
    li $t0, 4             
    sw $t0, 0($a0)   
    la $t0, rotation_state  
    li $t1, 0              
    sw $t1, 0($t0) 
    li $s0, 24     
    li $s1, 152    
    li $s2, 280    
    li $s3, 284    
    li $a1, 10
    li $t9, 0x7469B6              
    lw $t7, ADDR_DSPL             
    sw $t9, 324($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    j continue_after_action
action5:
# #############################################################################
# DRAW TRIMINO (T - Shape)
# ############################################################################# 
    li $t9, 0xFFEDD8             
    lw $t7, ADDR_DSPL             
    sw $t9, 324($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    la $a0, piece_state  
    la $a0, piece_state  
    li $t0, 6             
    sw $t0, 0($a0) 
    la $t0, rotation_state  
    li $t1, 0               
    sw $t1, 0($t0) 
    li $s0, 284    
    li $s1, 152   
    li $s2, 280    
    li $s3, 276  
    li $t9, 0xFF7ED4              
    lw $t7, ADDR_DSPL            
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    j continue_after_action
action6:
# #############################################################################
# DRAW TRIMINO (J - Shape)
# #############################################################################     
    li $t9, 0xFFEDD8             
    lw $t7, ADDR_DSPL            
    sw $t9, 64($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 316($t7) 
    la $a0, piece_state  
    li $t0, 5             
    sw $t0, 0($a0)  
    la $t0, rotation_state  
    li $t1, 0               
    sw $t1, 0($t0) 
    li $s0, 24     
    li $s1, 152   
    li $s2, 280    
    li $s3, 276
    li $t9, 0xFFF455              
    lw $t7, ADDR_DSPL             
    sw $t9, 196($t7)    
    sw $t9, 192($t7)  
    sw $t9, 320($t7)  
    sw $t9, 324($t7) 
    j continue_after_action
continue_after_action:
    jr $ra  
start_the_L_done:
    jr $ra  
exit_program:
##############################################################################
# REPAINT BLOCK FUNCTION
##############################################################################     
jal paint_block
j done_paint 
paint_block: 
    la $t1, piece_state             # Load address of piece_state
    lw $t0, 0($t1)                  # Load value of piece_state into $t0                   
    li $t2, 0                       # Compare piece_state and jump to the corresponding action
    beq $t0, $t2, action0_21 
    li $t2, 1
    beq $t0, $t2, action1_21
    li $t2, 2
    beq $t0, $t2, action2_21
    li $t2, 3
    beq $t0, $t2, action3_21
    li $t2, 4
    beq $t0, $t2, action4_21
    li $t2, 5
    beq $t0, $t2, action5_21
    li $t2, 6
    beq $t0, $t2, action6_21
action0_21:                          # Define what happens in each action
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0xFFF455                 # Load t1 with the colour
    j end_21
action1_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0x378CE7                 # Load t1 with the colour 
    j end_21
action2_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0xFF204E                 # Load t1 with the colour 
    j end_21
action3_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0x87A922                 # Load t1 with the colour 
    j end_21
action4_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0xF6995C                 # Load t1 with the colour 
    j end_21
action5_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0xFF7ED4                 # Load t1 with the colour 
    j end_21
action6_21:
    lw $t0, ADDR_DSPL                # Load base address for the display
    li $t1, 0x7469B6                 # Load t1 with the colour 
    j end_21
end_21:    
    add $s0, $s0, $t0
    add $s1, $s1, $t0
    add $s2, $s2, $t0
    add $s3, $s3, $t0
    sw $t1, 0($s0)                  # Draw the block at the absolute address in $s0
    sw $t1, 0($s1)                  # Draw the block at the absolute address in $s1
    sw $t1, 0($s2)                  # Draw the block at the absolute address in $s2
    sw $t1, 0($s3)                  # Draw the block at the absolute address in $s3
    sub $s0, $s0, $t0
    sub $s1, $s1, $t0
    sub $s2, $s2, $t0
    sub $s3, $s3, $t0
    jr $ra  
##############################################################################
# START GAME (Jump to Game Loop)
##############################################################################
done_paint:
 j game_loop         
##############################################################################
# LOOK FOR KEY PRESS
##############################################################################
game_loop:
    la $t0, ground                  # Load the address of the words array into $t0
    lw $t1, num_ground              # Load the array length into $t1
    li $t2, 0                       # Initialize index to 0 (for array iteration)
    li $t5, 0                       # Initialize match found flag to 0
look_for_bottom_collision:
    beq $t2, $t1, check_bottom_collision 
    lw $t4, 0($t0)                   # Load the current word from the array into $t4
    # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s0, match_collision_bottom
    beq $t4, $s1, match_collision_bottom
    beq $t4, $s2, match_collision_bottom
    beq $t4, $s3, match_collision_bottom
    addi $t0, $t0, 4                 # Move to the next word in the array
    addi $t2, $t2, 1                 # Increment the index
    j look_for_bottom_collision      # Jump back to the start of the loop
match_collision_bottom:
    li $t5, 1                        # Set match found flag
    j check_bottom_collision           
check_bottom_collision:
    beq $t5, 1, bottom_collision_detected    # If match found, jump
    j bottom_collision_not_detected          # Otherwise, jump
bottom_collision_detected:
    jal paint_block
    lw $t0, num_taken_spots   # Load the current number of elements in the array into $t0
    la $t1, taken_spots       # Load the address of the start of the array into $t1
    sll $t2, $t0, 2           # Calculate the byte offset ($t0 * 4) in the array for the new elements
    add $t1, $t1, $t2         # Add the offset to the base address of the array to find where to append
    sw $s0, 0($t1)            # Store $s0 in the array
    sw $s1, 4($t1)            # Store $s1 in the array
    sw $s2, 8($t1)            # Store $s2 in the array
    sw $s3, 12($t1)           # Store $s3 in the array
    addi $t0, $t0, 4          # Increment the number of elements in the array by 4
    sw $t0, num_taken_spots   # Update num_taken_spots
    jal start_the_L 
    j sleepy
bottom_collision_not_detected:
    j done_check_bottom                   
done_check_bottom:
# ##############################################################################
# # CHECK WHEN TO POP ROW 1
# ############################################################################## 
    jal checkRowsInTakenSpots_row1         
    j next_row1
checkRowsInTakenSpots_row1 :
    la $a0, row_1                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row1: 
     # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row1 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row1:
    bge $t7, $a3, checkMatch_row1  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row1    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row1
setMatch_row1:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row1:
    beqz $s4, unsetAllMatch_row1   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row1                 # Back to start of rowLoop
unsetAllMatch_row1:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row1                 # Continue checking remaining rows
checkAllMatched_row1:
    beqz $s5, no_pop_row1           # If not all matched, jump to colorLocation152
    j pop_rows_row1                 # All matched, jump to colorLocation4
pop_rows_row1:
         lw $t0, ADDR_DSPL          # Load the base address of the display into $t0.
         la $t1, row_1              # Load the address of the rows array into $t1.
         li $t2, 12                 # Load the length of the rows array into $t2.
         li $t3, 0                  # Index for iterating through rows.
         li $t4, 0xEABE6C           # Color. 
         li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
color_row1:
         bge $t3, $t2, endProgram_row1  # If we've colored all rows, exit the loop.
         lw $t5, 0($t1)            # Load the current row's offset into $t5.
         add $t6, $t0, $t5         # Calculate the actual memory address to color.
         sw $t4, 0($t6)            # Write white to the calculated address.
         addi $t1, $t1, 4          # Move to the next element in the rows array.
         addi $t3, $t3, 1          # Increment our index.
          j color_row1             # Jump back to the start of the loop to color the next row.
endProgram_row1:
        la $a0, row_1            # Address of rows
        li $a1, 12               # Length of rows
        la $a2, taken_spots      # Address of taken_spots
        lw $a3, num_taken_spots  # Length of taken_spots
        li $t0, 0
iterateTakenSpots_row1:
        bge $t0, $a3, exit_row1  # If done iterating through taken_spots, exit the loop
        lw $t1, 0($a2)            # Load the current taken_spot element
        la $t2, row_1             # Reset address of rows for each taken_spot element
        li $t3, 0                 # Reset index for iterating through rows
checkAgainstRows_row1:
        bge $t3, $a1, incrementTaken_row1
        lw $t4, 0($t2)         
        beq $t1, $t4, markAsRemoved_row1  
        addi $t2, $t2, 4          # Move to the next row element
        addi $t3, $t3, 1          # Increment rows index
        j checkAgainstRows_row1
markAsRemoved_row1:  
        li $t5, -4                # The value used to mark elements as "removed"
        sw $t5, 0($a2)            # Mark the current taken_spot element as "removed"
incrementTaken_row1:
        addi $a2, $a2, 4          # Move to the next taken_spot element
        addi $t0, $t0, 1          # Increment taken_spots index
        j iterateTakenSpots_row1
exit_row1:
        li $v0, 32                      # Set syscall number for sleep operation
        li $a0, 500                    # Set sleep duration in milliseconds
        syscall                         # Execute the syscall to sleep 
        jal checkerboard_repainter
        lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
        la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
        lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
        li $t3, 0                       # Initialize index for iterating through taken_spots.
        li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row1:
    bge $t3, $t2, end_loop_row1             # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                      # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row1
    li $t7, 3844
    bge $t5, $t7, skip_coloring_and_adding_row1
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row1:
    addi $t1, $t1, 4                 # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1                 # Increment the index.
    j color_spots_and_add_row1            # Jump back to color the next spot and add 128.
end_loop_row1: 
        li $v0, 32                   # Set syscall number for sleep operation
        li $a0, 500                 # Set sleep duration in milliseconds
        syscall                      # Execute the syscall to sleep  
        jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0
    la $t1, taken_spots             # Load the address of the ground array into $t1
    lw $t2, num_taken_spots         # Load the number of elements in ground into $t2
    li $t3, 0                       # Initialize index for iterating through ground
    li $t4, 0xFDA403                # Load the green color value into $t4
iterate_row1:
    bge $t3, $t2, finish_row1       # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                  # Load the current ground offset into $t5
    add $t6, $t0, $t5               # Calculate the memory address to color
    sw $t4, 0($t6)                  # Write the green color to the calculated address
    addi $t1, $t1, 4                # Move to the next element in ground
    addi $t3, $t3, 1                # Increment the ground index
    j iterate_row1                  # Jump back to iterate through the next ground spot
finish_row1:
    jal checkerboard_repainter
    j sleepy
no_pop_row1:
    jr $ra                         # Return from procedure
next_row1:
##############################################################################
# CHECK WHEN TO POP ROW 2
##############################################################################     
    jal checkRowsInTakenSpots_row2         
    j next_row2
checkRowsInTakenSpots_row2 :
    la $a0, row_2                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row2: 
     # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row2 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row2:
    bge $t7, $a3, checkMatch_row2  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row2    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row2
setMatch_row2:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row2:
    beqz $s4, unsetAllMatch_row2   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row2                 # Back to start of rowLoop
unsetAllMatch_row2:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row2                 # Continue checking remaining rows
checkAllMatched_row2:
    beqz $s5, no_pop_row2           # If not all matched, jump to colorLocation152
    j pop_rows_row2                 # All matched, jump to colorLocation4
pop_rows_row2: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
         lw $t0, ADDR_DSPL          # Load the base address of the display into $t0.
         la $t1, row_2              # Load the address of the rows array into $t1.
         li $t2, 12                 # Load the length of the rows array into $t2.
         li $t3, 0                  # Index for iterating through rows.
         li $t4, 0xEABE6C           # White color.
color_row2:
         bge $t3, $t2, endProgram_row2  # If we've colored all rows, exit the loop.
         lw $t5, 0($t1)            # Load the current row's offset into $t5.
         add $t6, $t0, $t5         # Calculate the actual memory address to color.
         sw $t4, 0($t6)            # Write white to the calculated address.
         addi $t1, $t1, 4          # Move to the next element in the rows array.
         addi $t3, $t3, 1          # Increment our index.
          j color_row2             # Jump back to the start of the loop to color the next row.
endProgram_row2:
        la $a0, row_2            # Address of rows
        li $a1, 12               # Length of rows
        la $a2, taken_spots      # Address of taken_spots
        lw $a3, num_taken_spots  # Length of taken_spots
        li $t0, 0
iterateTakenSpots_row2:
        bge $t0, $a3, exit_row2  # If done iterating through taken_spots, exit the loop
        lw $t1, 0($a2)            # Load the current taken_spot element
        la $t2, row_2             # Reset address of rows for each taken_spot element
        li $t3, 0                 # Reset index for iterating through rows
checkAgainstRows_row2:
        bge $t3, $a1, incrementTaken_row2
        lw $t4, 0($t2)         
        beq $t1, $t4, markAsRemoved_row2  
        addi $t2, $t2, 4          # Move to the next row element
        addi $t3, $t3, 1          # Increment rows index
        j checkAgainstRows_row2
markAsRemoved_row2:  
        li $t5, -4                # The value used to mark elements as "removed"
        sw $t5, 0($a2)            # Mark the current taken_spot element as "removed"
incrementTaken_row2:
        addi $a2, $a2, 4          # Move to the next taken_spot element
        addi $t0, $t0, 1          # Increment taken_spots index
        j iterateTakenSpots_row2
exit_row2:
        li $v0, 32                      # Set syscall number for sleep operation
        li $a0, 500                    # Set sleep duration in milliseconds
        syscall                         # Execute the syscall to sleep 
        jal checkerboard_repainter
        lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
        la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
        lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
        li $t3, 0                       # Initialize index for iterating through taken_spots.
        li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row2:
    bge $t3, $t2, end_loop_row2             # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                      # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row2
    li $t7, 3716
    bge $t5, $t7, skip_coloring_and_adding_row2
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row2:
    addi $t1, $t1, 4                 # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1                 # Increment the index.
    j color_spots_and_add_row2            # Jump back to color the next spot and add 128.
end_loop_row2: 
        li $v0, 32                   # Set syscall number for sleep operation
        li $a0, 500                 # Set sleep duration in milliseconds
        syscall                      # Execute the syscall to sleep  
        jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0
    la $t1, taken_spots             # Load the address of the ground array into $t1
    lw $t2, num_taken_spots         # Load the number of elements in ground into $t2
    li $t3, 0                       # Initialize index for iterating through ground
    li $t4, 0xFDA403                # Load the green color value into $t4
iterate_row2:
    bge $t3, $t2, finish_row2       # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                  # Load the current ground offset into $t5
    add $t6, $t0, $t5               # Calculate the memory address to color
    sw $t4, 0($t6)                  # Write the green color to the calculated address
    addi $t1, $t1, 4                # Move to the next element in ground
    addi $t3, $t3, 1                # Increment the ground index
    j iterate_row2                  # Jump back to iterate through the next ground spot
finish_row2:
    jal checkerboard_repainter
    j sleepy
no_pop_row2:
    jr $ra                         # Return from procedure
next_row2:
# #############################################################################
# CHECK WHEN TO POP ROW 3
# ############################################################################# 
jal checkRowsInTakenSpots_row3         
j next_row3
checkRowsInTakenSpots_row3 :
    la $a0, row_3                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row3: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row3 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row3:
    bge $t7, $a3, checkMatch_row3  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row3    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row3
setMatch_row3:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row3:
    beqz $s4, unsetAllMatch_row3   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row3                 # Back to start of rowLoop
unsetAllMatch_row3:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row3                 # Continue checking remaining rows
checkAllMatched_row3:
    beqz $s5, no_pop_row3           # If not all matched, jump to colorLocation152
    j pop_rows_row3                 # All matched, jump to colorLocation4
pop_rows_row3: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_3                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row3:
    bge $t3, $t2, endProgram_row3  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row3                   # Jump back to the start of the loop to color the next row.
endProgram_row3:
    la $a0, row_3                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row3:
    bge $t0, $a3, exit_row3        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_3                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row3:
    bge $t3, $a1, incrementTaken_row3
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row3  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row3
markAsRemoved_row3:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row3:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row3
exit_row3:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row3:
    bge $t3, $t2, end_loop_row3   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row3
    li $t7, 3588
    bge $t5, $t7, skip_coloring_and_adding_row3
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row3:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row3    # Jump back to color the next spot and add 128.
end_loop_row3: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                # Load the base address of the display into $t0
la $t1, taken_spots              # Load the address of the ground array into $t1
lw $t2, num_taken_spots          # Load the number of elements in ground into $t2
li $t3, 0                        # Initialize index for iterating through ground
li $t4, 0xFDA403                 # Load the green color value into $t4
iterate_row3:
    bge $t3, $t2, finish_row3    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row3               # Jump back to iterate through the next ground spot
finish_row3:
    jal checkerboard_repainter
    j sleepy
no_pop_row3:
    jr $ra                      # Return from procedure
next_row3:
# #############################################################################
# CHECK WHEN TO POP ROW 4
# ############################################################################# 
jal checkRowsInTakenSpots_row4         
j next_row4
checkRowsInTakenSpots_row4:
    la $a0, row_4                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row4:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row4 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row4:
    bge $t7, $a3, checkMatch_row4  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row4    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row4
setMatch_row4:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row4:
    beqz $s4, unsetAllMatch_row4   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row4                 # Back to start of rowLoop
unsetAllMatch_row4:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row4                 # Continue checking remaining rows
checkAllMatched_row4:
    beqz $s5, no_pop_row4          # If not all matched, jump to colorLocation152
    j pop_rows_row4                # All matched, jump to colorLocation4
pop_rows_row4: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_4                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row4:
    bge $t3, $t2, endProgram_row4  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row4                   # Jump back to the start of the loop to color the next row.
endProgram_row4:
    la $a0, row_4                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row4:
    bge $t0, $a3, exit_row4        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_4                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row4:
    bge $t3, $a1, incrementTaken_row4
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row4  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row4
markAsRemoved_row4:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row4:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row4
exit_row4:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row4:
    bge $t3, $t2, end_loop_row4   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row4
    li $t7, 3460
    bge $t5, $t7, skip_coloring_and_adding_row4
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row4:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row4    # Jump back to color the next spot and add 128.
end_loop_row4: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                # Load the base address of the display into $t0
la $t1, taken_spots              # Load the address of the ground array into $t1
lw $t2, num_taken_spots          # Load the number of elements in ground into $t2
li $t3, 0                        # Initialize index for iterating through ground
li $t4, 0xFDA403                 # Load the green color value into $t4
iterate_row4:
    bge $t3, $t2, finish_row4    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row4               # Jump back to iterate through the next ground spot
finish_row4:
    jal checkerboard_repainter
    j sleepy
no_pop_row4:
    jr $ra                      # Return from procedure
next_row4:
# #############################################################################
# CHECK WHEN TO POP ROW 4
# ############################################################################# 
jal checkRowsInTakenSpots_row5         
j next_row5
checkRowsInTakenSpots_row5:
    la $a0, row_5                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row5:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row5 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row5:
    bge $t7, $a3, checkMatch_row5  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row5    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row5
setMatch_row5:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row5:
    beqz $s4, unsetAllMatch_row5   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row5                 # Back to start of rowLoop
unsetAllMatch_row5:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row5                 # Continue checking remaining rows
checkAllMatched_row5:
    beqz $s5, no_pop_row5          # If not all matched, jump to colorLocation152
    j pop_rows_row5                # All matched, jump to colorLocation4
pop_rows_row5: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_5                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row5:
    bge $t3, $t2, endProgram_row5  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row5                   # Jump back to the start of the loop to color the next row.
endProgram_row5:
    la $a0, row_5                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row5:
    bge $t0, $a3, exit_row5        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_5                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row5:
    bge $t3, $a1, incrementTaken_row5
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row5  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row5
markAsRemoved_row5:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row5:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row5
exit_row5:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row5:
    bge $t3, $t2, end_loop_row5    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row5
    li $t7, 3332                   # Assuming the minimum value of the spots in row_5
    bge $t5, $t7, skip_coloring_and_adding_row5
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row5:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row5     # Jump back to color the next spot and add 128.
end_loop_row5: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row5:
    bge $t3, $t2, finish_row5      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row5                 # Jump back to iterate through the next ground spot
finish_row5:
    jal checkerboard_repainter
    j sleepy
no_pop_row5:
    jr $ra                        # Return from procedure
next_row5:
# #############################################################################
# CHECK WHEN TO POP ROW 5
# ############################################################################# 
jal checkRowsInTakenSpots_row5         
j next_row5
checkRowsInTakenSpots_row5:
    la $a0, row_5                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row5:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row5 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row5:
    bge $t7, $a3, checkMatch_row5  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row5    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row5
setMatch_row5:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row5:
    beqz $s4, unsetAllMatch_row5   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row5                 # Back to start of rowLoop
unsetAllMatch_row5:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row5                 # Continue checking remaining rows
checkAllMatched_row5:
    beqz $s5, no_pop_row5          # If not all matched, jump to colorLocation152
    j pop_rows_row5                # All matched, jump to colorLocation4
pop_rows_row5:
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_5                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row5:
    bge $t3, $t2, endProgram_row5  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row5                   # Jump back to the start of the loop to color the next row.
endProgram_row5:
    la $a0, row_5                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row5:
    bge $t0, $a3, exit_row5        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_5                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row5:
    bge $t3, $a1, incrementTaken_row5
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row5  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row5
markAsRemoved_row5:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row5:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row5
exit_row5:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row5:
    bge $t3, $t2, end_loop_row5    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row5
    li $t7, 3340                   # Assuming the minimum value of the spots in row_5
    bge $t5, $t7, skip_coloring_and_adding_row5
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row5:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row5     # Jump back to color the next spot and add 128.
end_loop_row5: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row5:
    bge $t3, $t2, finish_row5      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row5                 # Jump back to iterate through the next ground spot
finish_row5:
    jal checkerboard_repainter
    j sleepy
no_pop_row5:
    jr $ra                        # Return from procedure
next_row5:
# #############################################################################
# CHECK WHEN TO POP ROW 6
# #############################################################################
jal checkRowsInTakenSpots_row6         
j next_row6
checkRowsInTakenSpots_row6:
    la $a0, row_6                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row6:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row6 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row6:
    bge $t7, $a3, checkMatch_row6  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row6    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row6
setMatch_row6:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row6:
    beqz $s4, unsetAllMatch_row6   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row6                 # Back to start of rowLoop
unsetAllMatch_row6:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row6                 # Continue checking remaining rows
checkAllMatched_row6:
    beqz $s5, no_pop_row6          # If not all matched, jump to colorLocation152
    j pop_rows_row6                # All matched, jump to colorLocation4
pop_rows_row6: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_6                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row6:
    bge $t3, $t2, endProgram_row6  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row6                   # Jump back to the start of the loop to color the next row.
endProgram_row6:
    la $a0, row_6                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row6:
    bge $t0, $a3, exit_row6        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_6                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row6:
    bge $t3, $a1, incrementTaken_row6
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row6  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row6
markAsRemoved_row6:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row6:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row6
exit_row6:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row6:
    bge $t3, $t2, end_loop_row6    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row6
    li $t7, 3204                   # Assuming the minimum value of the spots in row_6
    bge $t5, $t7, skip_coloring_and_adding_row6
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row6:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row6     # Jump back to color the next spot and add 128.
end_loop_row6: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row6:
    bge $t3, $t2, finish_row6      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row6                 # Jump back to iterate through the next ground spot
finish_row6:
    jal checkerboard_repainter
    j sleepy
no_pop_row6:
    jr $ra                        # Return from procedure
next_row6:
################################################################################
# CHECK WHEN TO POP ROW 7
################################################################################
jal checkRowsInTakenSpots_row7         
j next_row7
checkRowsInTakenSpots_row7:
    la $a0, row_7                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row7:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row7 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row7:
    bge $t7, $a3, checkMatch_row7  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row7    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row7
setMatch_row7:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row7:
    beqz $s4, unsetAllMatch_row7   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row7                 # Back to start of rowLoop
unsetAllMatch_row7:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row7                 # Continue checking remaining rows
checkAllMatched_row7:
    beqz $s5, no_pop_row7          # If not all matched, jump to colorLocation152
    j pop_rows_row7                # All matched, jump to colorLocation4
pop_rows_row7: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_7                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row7:
    bge $t3, $t2, endProgram_row7  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row7                   # Jump back to the start of the loop to color the next row.
endProgram_row7:
    la $a0, row_7                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row7:
    bge $t0, $a3, exit_row7        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_7                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row7:
    bge $t3, $a1, incrementTaken_row7
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row7  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row7
markAsRemoved_row7:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row7:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row7
exit_row7:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row7:
    bge $t3, $t2, end_loop_row7    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row7
    li $t7, 3076                   # Assuming the minimum value of the spots in row_7
    bge $t5, $t7, skip_coloring_and_adding_row7
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row7:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row7     # Jump back to color the next spot and add 128.
end_loop_row7:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row7:
    bge $t3, $t2, finish_row7      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row7                 # Jump back to iterate through the next ground spot
finish_row7:
    jal checkerboard_repainter
    j sleepy
no_pop_row7:
    jr $ra                        # Return from procedure
next_row7:
################################################################################
# CHECK WHEN TO POP ROW 8
################################################################################
jal checkRowsInTakenSpots_row8         
j next_row8
checkRowsInTakenSpots_row8:
    la $a0, row_8                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row8:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row8 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row8:
    bge $t7, $a3, checkMatch_row8  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row8    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row8
setMatch_row8:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row8:
    beqz $s4, unsetAllMatch_row8   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row8                 # Back to start of rowLoop
unsetAllMatch_row8:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row8                 # Continue checking remaining rows
checkAllMatched_row8:
    beqz $s5, no_pop_row8          # If not all matched, jump to colorLocation152
    j pop_rows_row8                # All matched, jump to colorLocation4
pop_rows_row8: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_8                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row8:
    bge $t3, $t2, endProgram_row8  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row8                   # Jump back to the start of the loop to color the next row.
endProgram_row8:
    la $a0, row_8                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row8:
    bge $t0, $a3, exit_row8        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_8                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row8:
    bge $t3, $a1, incrementTaken_row8
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row8  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row8
markAsRemoved_row8:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row8:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row8
exit_row8:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row8:
    bge $t3, $t2, end_loop_row8    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row8
    li $t7, 2948                   # Assuming the minimum value of the spots in row_8
    bge $t5, $t7, skip_coloring_and_adding_row8
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row8:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row8     # Jump back to color the next spot and add 128.
end_loop_row8: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row8:
    bge $t3, $t2, finish_row8      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row8                 # Jump back to iterate through the next ground spot
finish_row8:
    jal checkerboard_repainter
    j sleepy
no_pop_row8:
    jr $ra                        # Return from procedure
next_row8:
################################################################################
# CHECK WHEN TO POP ROW 9
################################################################################
jal checkRowsInTakenSpots_row9         
j next_row9
checkRowsInTakenSpots_row9:
    la $a0, row_9                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row9:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row9 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row9:
    bge $t7, $a3, checkMatch_row9  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row9    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row9
setMatch_row9:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row9:
    beqz $s4, unsetAllMatch_row9   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row9                 # Back to start of rowLoop
unsetAllMatch_row9:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row9                 # Continue checking remaining rows
checkAllMatched_row9:
    beqz $s5, no_pop_row9          # If not all matched, jump to colorLocation152
    j pop_rows_row9                # All matched, jump to colorLocation4
pop_rows_row9: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_9                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row9:
    bge $t3, $t2, endProgram_row9  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row9                   # Jump back to the start of the loop to color the next row.
endProgram_row9:
    la $a0, row_9                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row9:
    bge $t0, $a3, exit_row9        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_9                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row9:
    bge $t3, $a1, incrementTaken_row9
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row9  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row9
markAsRemoved_row9:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row9:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row9
exit_row9:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row9:
    bge $t3, $t2, end_loop_row9    # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row9
    li $t7, 2820                   # Assuming the minimum value of the spots in row_9
    bge $t5, $t7, skip_coloring_and_adding_row9
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row9:
    addi $t1, $t1, 4               # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1               # Increment the index.
    j color_spots_and_add_row9     # Jump back to color the next spot and add 128.
end_loop_row9: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row9:
    bge $t3, $t2, finish_row9      # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)                 # Load the current ground offset into $t5
    add $t6, $t0, $t5              # Calculate the memory address to color
    sw $t4, 0($t6)                 # Write the green color to the calculated address
    addi $t1, $t1, 4               # Move to the next element in ground
    addi $t3, $t3, 1               # Increment the ground index
    j iterate_row9                 # Jump back to iterate through the next ground spot
finish_row9:
    jal checkerboard_repainter
    j sleepy
no_pop_row9:
    jr $ra                        # Return from procedure
next_row9:
################################################################################
# CHECK WHEN TO POP ROW 10
################################################################################
jal checkRowsInTakenSpots_row10         
j next_row10
checkRowsInTakenSpots_row10:
    la $a0, row_10                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row10:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row10 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row10:
    bge $t7, $a3, checkMatch_row10  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row10    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row10
setMatch_row10:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row10:
    beqz $s4, unsetAllMatch_row10   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row10                 # Back to start of rowLoop
unsetAllMatch_row10:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row10                 # Continue checking remaining rows
checkAllMatched_row10:
    beqz $s5, no_pop_row10          # If not all matched, jump to colorLocation152
    j pop_rows_row10                # All matched, jump to colorLocation4
pop_rows_row10: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_10                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row10:
    bge $t3, $t2, endProgram_row10  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row10                   # Jump back to the start of the loop to color the next row.
endProgram_row10:
    la $a0, row_10                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row10:
    bge $t0, $a3, exit_row10        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_10                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row10:
    bge $t3, $a1, incrementTaken_row10
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row10  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row10
markAsRemoved_row10:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row10:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row10
exit_row10:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row10:
    bge $t3, $t2, end_loop_row10   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row10
    li $t7, 2692                   # Assuming the minimum value of the spots in row_10
    bge $t5, $t7, skip_coloring_and_adding_row10
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row10:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row10    # Jump back to color the next spot and add 128.
end_loop_row10: 
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                  # Load the base address of the display into $t0
la $t1, taken_spots                # Load the address of the ground array into $t1
lw $t2, num_taken_spots            # Load the number of elements in ground into $t2
li $t3, 0                          # Initialize index for iterating through ground
li $t4, 0xFDA403                   # Load the green color value into $t4
iterate_row10:
    bge $t3, $t2, finish_row10    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row10               # Jump back to iterate through the next ground spot
finish_row10:
    jal checkerboard_repainter
    j sleepy
no_pop_row10:
    jr $ra                        # Return from procedure
next_row10:
################################################################################
# CHECK WHEN TO POP ROW 11
################################################################################
jal checkRowsInTakenSpots_row11         
j next_row11
checkRowsInTakenSpots_row11:
    la $a0, row_11                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row11:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row11 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row11:
    bge $t7, $a3, checkMatch_row11  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row11    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row11
setMatch_row11:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row11:
    beqz $s4, unsetAllMatch_row11   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row11                 # Back to start of rowLoop
unsetAllMatch_row11:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row11                 # Continue checking remaining rows
checkAllMatched_row11:
    beqz $s5, no_pop_row11          # If not all matched, jump to colorLocation152
    j pop_rows_row11                # All matched, jump to colorLocation4
pop_rows_row11: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_11                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row11:
    bge $t3, $t2, endProgram_row11  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row11                   # Jump back to the start of the loop to color the next row.
endProgram_row11:
    la $a0, row_11                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row11:
    bge $t0, $a3, exit_row11        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_11                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row11:
    bge $t3, $a1, incrementTaken_row11
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row11  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row11
markAsRemoved_row11:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row11:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row11
exit_row11:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
    la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
    li $t3, 0                       # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row11:
    bge $t3, $t2, end_loop_row11   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row11
    li $t7, 2564                  # Assuming the minimum value of the spots in row_11
    bge $t5, $t7, skip_coloring_and_adding_row11
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row11:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row11    # Jump back to color the next spot and add 128.
end_loop_row11: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row11:
    bge $t3, $t2, finish_row11    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row11               # Jump back to iterate through the next ground spot
finish_row11:
    jal checkerboard_repainter
    j sleepy
no_pop_row11:
    jr $ra                       # Return from procedure
next_row11:
################################################################################
# CHECK WHEN TO POP ROW 12
################################################################################
jal checkRowsInTakenSpots_row12         
j next_row12
checkRowsInTakenSpots_row12:
    la $a0, row_12                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row12:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row12 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row12:
    bge $t7, $a3, checkMatch_row12  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row12    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row12
setMatch_row12:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row12:
    beqz $s4, unsetAllMatch_row12   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row12                 # Back to start of rowLoop
unsetAllMatch_row12:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row12                 # Continue checking remaining rows
checkAllMatched_row12:
    beqz $s5, no_pop_row12          # If not all matched, jump to colorLocation152
    j pop_rows_row12                # All matched, jump to colorLocation4
pop_rows_row12: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_12                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row12:
    bge $t3, $t2, endProgram_row12  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row12                   # Jump back to the start of the loop to color the next row.
endProgram_row12:
    la $a0, row_12                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row12:
    bge $t0, $a3, exit_row12        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_12                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row12:
    bge $t3, $a1, incrementTaken_row12
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row12  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row12
markAsRemoved_row12:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row12:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row12
exit_row12:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
    la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
    li $t3, 0                       # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row12:
    bge $t3, $t2, end_loop_row12   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row12
    li $t7, 2436                  # Assuming the minimum value of the spots in row_12
    bge $t5, $t7, skip_coloring_and_adding_row12
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row12:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row12    # Jump back to color the next spot and add 128.
end_loop_row12: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row12:
    bge $t3, $t2, finish_row12    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row12               # Jump back to iterate through the next ground spot
finish_row12:
    jal checkerboard_repainter
    j sleepy
no_pop_row12:
    jr $ra                       # Return from procedure
next_row12:
################################################################################
# CHECK WHEN TO POP ROW 13
################################################################################
jal checkRowsInTakenSpots_row13         
j next_row13
checkRowsInTakenSpots_row13:
    la $a0, row_13                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row13:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row13 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row13:
    bge $t7, $a3, checkMatch_row13  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row13    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row13
setMatch_row13:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row13:
    beqz $s4, unsetAllMatch_row13   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row13                 # Back to start of rowLoop
unsetAllMatch_row13:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row13                 # Continue checking remaining rows
checkAllMatched_row13:
    beqz $s5, no_pop_row13          # If not all matched, jump to colorLocation152
    j pop_rows_row13                # All matched, jump to colorLocation4
pop_rows_row13: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_13                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row13:
    bge $t3, $t2, endProgram_row13  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row13                   # Jump back to the start of the loop to color the next row.
endProgram_row13:
    la $a0, row_13                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row13:
    bge $t0, $a3, exit_row13        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_13                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row13:
    bge $t3, $a1, incrementTaken_row13
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row13  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row13
markAsRemoved_row13:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row13:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row13
exit_row13:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
    la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
    li $t3, 0                       # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row13:
    bge $t3, $t2, end_loop_row13   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row13
    li $t7, 2308                  # Assuming the minimum value of the spots in row_13
    bge $t5, $t7, skip_coloring_and_adding_row13
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row13:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row13    # Jump back to color the next spot and add 128.
end_loop_row13: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row13:
    bge $t3, $t2, finish_row13    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row13               # Jump back to iterate through the next ground spot
finish_row13:
    jal checkerboard_repainter
    j sleepy
no_pop_row13:
    jr $ra                       # Return from procedure
next_row13:
################################################################################
# CHECK WHEN TO POP ROW 14
################################################################################
jal checkRowsInTakenSpots_row14         
j next_row14
checkRowsInTakenSpots_row14:
    la $a0, row_14                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row14:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row14 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row14:
    bge $t7, $a3, checkMatch_row14  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row14    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row14
setMatch_row14:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row14:
    beqz $s4, unsetAllMatch_row14   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row14                 # Back to start of rowLoop
unsetAllMatch_row14:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row14                 # Continue checking remaining rows
checkAllMatched_row14:
    beqz $s5, no_pop_row14          # If not all matched, jump to colorLocation152
    j pop_rows_row14                # All matched, jump to colorLocation4
pop_rows_row14: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_14                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row14:
    bge $t3, $t2, endProgram_row14  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row14                   # Jump back to the start of the loop to color the next row.
endProgram_row14:
    la $a0, row_14                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row14:
    bge $t0, $a3, exit_row14        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_14                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row14:
    bge $t3, $a1, incrementTaken_row14
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row14  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row14
markAsRemoved_row14:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row14:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row14
exit_row14:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
    la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
    li $t3, 0                       # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row14:
    bge $t3, $t2, end_loop_row14   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row14
    li $t7, 2180                  # Assuming the minimum value of the spots in row_14
    bge $t5, $t7, skip_coloring_and_adding_row14
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row14:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row14    # Jump back to color the next spot and add 128.
end_loop_row14: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row14:
    bge $t3, $t2, finish_row14    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row14               # Jump back to iterate through the next ground spot
finish_row14:
    jal checkerboard_repainter
    j sleepy
no_pop_row14:
    jr $ra                       # Return from procedure
next_row14:
################################################################################
# CHECK WHEN TO POP ROW 15
################################################################################
jal checkRowsInTakenSpots_row15         
j next_row15
checkRowsInTakenSpots_row15:
    la $a0, row_15                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row15:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row15 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row15:
    bge $t7, $a3, checkMatch_row15  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row15    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row15
setMatch_row15:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row15:
    beqz $s4, unsetAllMatch_row15   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row15                 # Back to start of rowLoop
unsetAllMatch_row15:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row15                 # Continue checking remaining rows
checkAllMatched_row15:
    beqz $s5, no_pop_row15          # If not all matched, jump to colorLocation152
    j pop_rows_row15                # All matched, jump to colorLocation4
pop_rows_row15: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_15                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row15:
    bge $t3, $t2, endProgram_row15  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row15                   # Jump back to the start of the loop to color the next row.
endProgram_row15:
    la $a0, row_15                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row15:
    bge $t0, $a3, exit_row15        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_15                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row15:
    bge $t3, $a1, incrementTaken_row15
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row15  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row15
markAsRemoved_row15:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row15:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row15
exit_row15:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL               # Load the base address of the display into $t0.
    la $t1, taken_spots             # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots         # Load the length of the taken_spots array into $t2.
    li $t3, 0                       # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C                # Load the color value for red into $t4.
color_spots_and_add_row15:
    bge $t3, $t2, end_loop_row15   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row15
    li $t7, 2052                  # Assuming the minimum value of the spots in row_15
    bge $t5, $t7, skip_coloring_and_adding_row15
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row15:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row15    # Jump back to color the next spot and add 128.
end_loop_row15: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row15:
    bge $t3, $t2, finish_row15    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row15               # Jump back to iterate through the next ground spot
finish_row15:
    jal checkerboard_repainter
    j sleepy
no_pop_row15:
    jr $ra                       # Return from procedure
next_row15:
################################################################################
# CHECK WHEN TO POP ROW 16
################################################################################
jal checkRowsInTakenSpots_row16         
j next_row16
checkRowsInTakenSpots_row16:
    la $a0, row_16                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row16:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row16 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row16:
    bge $t7, $a3, checkMatch_row16  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row16    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row16
setMatch_row16:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row16:
    beqz $s4, unsetAllMatch_row16   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row16                 # Back to start of rowLoop
unsetAllMatch_row16:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row16                 # Continue checking remaining rows
checkAllMatched_row16:
    beqz $s5, no_pop_row16          # If not all matched, jump to colorLocation152
    j pop_rows_row16                # All matched, jump to colorLocation4
pop_rows_row16: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_16                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row16:
    bge $t3, $t2, endProgram_row16  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row16                   # Jump back to the start of the loop to color the next row.
endProgram_row16:
    la $a0, row_16                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row16:
    bge $t0, $a3, exit_row16        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_16                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row16:
    bge $t3, $a1, incrementTaken_row16
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row16  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row16
markAsRemoved_row16:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row16:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row16
exit_row16:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row16:
    bge $t3, $t2, end_loop_row16   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row16
    li $t7, 1924                  # Assuming the minimum value of the spots in row_16
    bge $t5, $t7, skip_coloring_and_adding_row16
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row16:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row16    # Jump back to color the next spot and add 128.
end_loop_row16: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row16:
    bge $t3, $t2, finish_row16    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row16               # Jump back to iterate through the next ground spot
finish_row16:
    jal checkerboard_repainter
    j sleepy
no_pop_row16:
    jr $ra                       # Return from procedure
next_row16:
################################################################################
# CHECK WHEN TO POP ROW 17
################################################################################
jal checkRowsInTakenSpots_row17         
j next_row17
checkRowsInTakenSpots_row17:
    la $a0, row_17                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row17:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row17 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row17:
    bge $t7, $a3, checkMatch_row17  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row17    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row17
setMatch_row17:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row17:
    beqz $s4, unsetAllMatch_row17   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row17                 # Back to start of rowLoop
unsetAllMatch_row17:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row17                 # Continue checking remaining rows
checkAllMatched_row17:
    beqz $s5, no_pop_row17          # If not all matched, jump to colorLocation152
    j pop_rows_row17                # All matched, jump to colorLocation4
pop_rows_row17: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_17                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row17:
    bge $t3, $t2, endProgram_row17  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row17                   # Jump back to the start of the loop to color the next row.
endProgram_row17:
    la $a0, row_17                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row17:
    bge $t0, $a3, exit_row17        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_17                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row17:
    bge $t3, $a1, incrementTaken_row17
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row17  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row17
markAsRemoved_row17:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row17:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row17
exit_row17:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row17:
    bge $t3, $t2, end_loop_row17   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row17
    li $t7, 1796                  # Assuming the minimum value of the spots in row_17
    bge $t5, $t7, skip_coloring_and_adding_row17
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row17:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row17    # Jump back to color the next spot and add 128.
end_loop_row17: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row17:
    bge $t3, $t2, finish_row17    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row17               # Jump back to iterate through the next ground spot
finish_row17:
    jal checkerboard_repainter
    j sleepy
no_pop_row17:
    jr $ra                       # Return from procedure
next_row17:
################################################################################
# CHECK WHEN TO POP ROW 18
################################################################################
jal checkRowsInTakenSpots_row18         
j next_row18
checkRowsInTakenSpots_row18:
    la $a0, row_18                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row18:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row18 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row18:
    bge $t7, $a3, checkMatch_row18  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row18    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row18
setMatch_row18:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row18:
    beqz $s4, unsetAllMatch_row18   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row18                 # Back to start of rowLoop
unsetAllMatch_row18:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row18                 # Continue checking remaining rows
checkAllMatched_row18:
    beqz $s5, no_pop_row18          # If not all matched, jump to colorLocation152
    j pop_rows_row18                # All matched, jump to colorLocation4
pop_rows_row18: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_18                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row18:
    bge $t3, $t2, endProgram_row18  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row18                   # Jump back to the start of the loop to color the next row.
endProgram_row18:
    la $a0, row_18                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row18:
    bge $t0, $a3, exit_row18        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_18                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row18:
    bge $t3, $a1, incrementTaken_row18
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row18  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row18
markAsRemoved_row18:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row18:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row18
exit_row18:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row18:
    bge $t3, $t2, end_loop_row18   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row18
    li $t7, 1668                  # Assuming the minimum value of the spots in row_18
    bge $t5, $t7, skip_coloring_and_adding_row18
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row18:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row18    # Jump back to color the next spot and add 128.
end_loop_row18: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row18:
    bge $t3, $t2, finish_row18    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row18               # Jump back to iterate through the next ground spot
finish_row18:
    jal checkerboard_repainter
    j sleepy
no_pop_row18:
    jr $ra                       # Return from procedure
next_row18:
################################################################################
# CHECK WHEN TO POP ROW 19
################################################################################
jal checkRowsInTakenSpots_row19         
j next_row19
checkRowsInTakenSpots_row19:
    la $a0, row_19                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row19:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row19 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row19:
    bge $t7, $a3, checkMatch_row19  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row19    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row19
setMatch_row19:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row19:
    beqz $s4, unsetAllMatch_row19   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row19                 # Back to start of rowLoop
unsetAllMatch_row19:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row19                 # Continue checking remaining rows
checkAllMatched_row19:
    beqz $s5, no_pop_row19          # If not all matched, jump to colorLocation152
    j pop_rows_row19                # All matched, jump to colorLocation4
pop_rows_row19: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_19                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row19:
    bge $t3, $t2, endProgram_row19  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row19                   # Jump back to the start of the loop to color the next row.
endProgram_row19:
    la $a0, row_19                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row19:
    bge $t0, $a3, exit_row19        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_19                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row19:
    bge $t3, $a1, incrementTaken_row19
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row19  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row19
markAsRemoved_row19:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row19:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row19
exit_row19:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row19:
    bge $t3, $t2, end_loop_row19   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row19
    li $t7, 1540                  # Assuming the minimum value of the spots in row_19
    bge $t5, $t7, skip_coloring_and_adding_row19
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row19:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row19    # Jump back to color the next spot and add 128.
end_loop_row19: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row19:
    bge $t3, $t2, finish_row19    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row19               # Jump back to iterate through the next ground spot
finish_row19:
    jal checkerboard_repainter
    j sleepy
no_pop_row19:
    jr $ra                       # Return from procedure
next_row19:
################################################################################
# CHECK WHEN TO POP ROW 20
################################################################################
jal checkRowsInTakenSpots_row20         
j next_row20
checkRowsInTakenSpots_row20:
    la $a0, row_20                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row20:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row20 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row20:
    bge $t7, $a3, checkMatch_row20  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row20    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row20
setMatch_row20:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row20:
    beqz $s4, unsetAllMatch_row20   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row20                 # Back to start of rowLoop
unsetAllMatch_row20:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row20                 # Continue checking remaining rows
checkAllMatched_row20:
    beqz $s5, no_pop_row20          # If not all matched, jump to colorLocation152
    j pop_rows_row20                # All matched, jump to colorLocation4
pop_rows_row20: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_20                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row20:
    bge $t3, $t2, endProgram_row20  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row20                   # Jump back to the start of the loop to color the next row.
endProgram_row20:
    la $a0, row_20                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row20:
    bge $t0, $a3, exit_row20        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_20                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row20:
    bge $t3, $a1, incrementTaken_row20
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row20  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row20
markAsRemoved_row20:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row20:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row20
exit_row20:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row20:
    bge $t3, $t2, end_loop_row20   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row20
    li $t7, 1412                  # Assuming the minimum value of the spots in row_20
    bge $t5, $t7, skip_coloring_and_adding_row20
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row20:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row20    # Jump back to color the next spot and add 128.
end_loop_row20: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row20:
    bge $t3, $t2, finish_row20    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row20               # Jump back to iterate through the next ground spot
finish_row20:
    jal checkerboard_repainter
    j sleepy
no_pop_row20:
    jr $ra                       # Return from procedure
next_row20:
################################################################################
# CHECK WHEN TO POP ROW 21
################################################################################
jal checkRowsInTakenSpots_row21         
j next_row21
checkRowsInTakenSpots_row21:
    la $a0, row_21                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row21:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row21 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row21:
    bge $t7, $a3, checkMatch_row21  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row21    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row21
setMatch_row21:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row21:
    beqz $s4, unsetAllMatch_row21   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row21                 # Back to start of rowLoop
unsetAllMatch_row21:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row21                 # Continue checking remaining rows
checkAllMatched_row21:
    beqz $s5, no_pop_row21          # If not all matched, jump to colorLocation152
    j pop_rows_row21                # All matched, jump to colorLocation4
pop_rows_row21: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_21                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row21:
    bge $t3, $t2, endProgram_row21  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row21                   # Jump back to the start of the loop to color the next row.
endProgram_row21:
    la $a0, row_21                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row21:
    bge $t0, $a3, exit_row21        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_21                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row21:
    bge $t3, $a1, incrementTaken_row21
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row21  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row21
markAsRemoved_row21:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row21:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row21
exit_row21:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row21:
    bge $t3, $t2, end_loop_row21   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row21
    li $t7, 1284                   # Assuming the minimum value of the spots in row_21
    bge $t5, $t7, skip_coloring_and_adding_row21
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row21:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row21   # Jump back to color the next spot and add 128.
end_loop_row21: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row21:
    bge $t3, $t2, finish_row21    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row21               # Jump back to iterate through the next ground spot
finish_row21:
    jal checkerboard_repainter
    j sleepy
no_pop_row21:
    jr $ra                       # Return from procedure
next_row21:
################################################################################
# CHECK WHEN TO POP ROW 22
################################################################################
jal checkRowsInTakenSpots_row22         
j next_row22
checkRowsInTakenSpots_row22:
    la $a0, row_22                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row22:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row22 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row22:
    bge $t7, $a3, checkMatch_row22  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row22    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row22
setMatch_row22:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row22:
    beqz $s4, unsetAllMatch_row22   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row22                 # Back to start of rowLoop
unsetAllMatch_row22:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row22                 # Continue checking remaining rows
checkAllMatched_row22:
    beqz $s5, no_pop_row22          # If not all matched, jump to colorLocation152
    j pop_rows_row22                # All matched, jump to colorLocation4
pop_rows_row22: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_22                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row22:
    bge $t3, $t2, endProgram_row22  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row22                   # Jump back to the start of the loop to color the next row.
endProgram_row22:
    la $a0, row_22                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row22:
    bge $t0, $a3, exit_row22        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_22                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row22:
    bge $t3, $a1, incrementTaken_row22
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row22  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row22
markAsRemoved_row22:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row22:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row22
exit_row22:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row22:
    bge $t3, $t2, end_loop_row22   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row22
    li $t7, 1156                   # Assuming the minimum value of the spots in row_22
    bge $t5, $t7, skip_coloring_and_adding_row22
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row22:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row22   # Jump back to color the next spot and add 128.
end_loop_row22: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row22:
    bge $t3, $t2, finish_row22    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row22               # Jump back to iterate through the next ground spot
finish_row22:
    jal checkerboard_repainter
    j sleepy
no_pop_row22:
    jr $ra                       # Return from procedure
next_row22:
################################################################################
# CHECK WHEN TO POP ROW 23
################################################################################
jal checkRowsInTakenSpots_row23         
j next_row23
checkRowsInTakenSpots_row23:
    la $a0, row_23                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row23:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row23 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row23:
    bge $t7, $a3, checkMatch_row23  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row23    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row23
setMatch_row23:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row23:
    beqz $s4, unsetAllMatch_row23   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row23                 # Back to start of rowLoop
unsetAllMatch_row23:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row23                 # Continue checking remaining rows
checkAllMatched_row23:
    beqz $s5, no_pop_row23          # If not all matched, jump to colorLocation152
    j pop_rows_row23                # All matched, jump to colorLocation4
pop_rows_row23: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_23                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row23:
    bge $t3, $t2, endProgram_row23  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row23                   # Jump back to the start of the loop to color the next row.
endProgram_row23:
    la $a0, row_23                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row23:
    bge $t0, $a3, exit_row23        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_23                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row23:
    bge $t3, $a1, incrementTaken_row23
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row23  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row23
markAsRemoved_row23:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row23:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row23
exit_row23:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row23:
    bge $t3, $t2, end_loop_row23   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row23
    li $t7, 1028                   # Assuming the minimum value of the spots in row_23
    bge $t5, $t7, skip_coloring_and_adding_row23
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row23:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row23   # Jump back to color the next spot and add 128.
end_loop_row23: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row23:
    bge $t3, $t2, finish_row23    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row23               # Jump back to iterate through the next ground spot
finish_row23:
    jal checkerboard_repainter
    j sleepy
no_pop_row23:
    jr $ra                       # Return from procedure
next_row23: 
################################################################################
# CHECK WHEN TO POP ROW 24
################################################################################
jal checkRowsInTakenSpots_row24         
j next_row24
checkRowsInTakenSpots_row24:
    la $a0, row_24                 # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row24:
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row24 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row24:
    bge $t7, $a3, checkMatch_row24  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row24    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row24
setMatch_row24:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row24:
    beqz $s4, unsetAllMatch_row24   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row24                 # Back to start of rowLoop
unsetAllMatch_row24:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row24                 # Continue checking remaining rows
checkAllMatched_row24:
    beqz $s5, no_pop_row24          # If not all matched, jump to colorLocation152
    j pop_rows_row24                # All matched, jump to colorLocation4
pop_rows_row24: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_24                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row24:
    bge $t3, $t2, endProgram_row24  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row24                   # Jump back to the start of the loop to color the next row.
endProgram_row24:
    la $a0, row_24                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row24:
    bge $t0, $a3, exit_row24        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_24                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row24:
    bge $t3, $a1, incrementTaken_row24
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row24  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row24
markAsRemoved_row24:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row24:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row24
exit_row24:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row24:
    bge $t3, $t2, end_loop_row24   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row24
    li $t7, 900                   # Assuming the minimum value of the spots in row_24
    bge $t5, $t7, skip_coloring_and_adding_row24
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row24:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row24   # Jump back to color the next spot and add 128.
end_loop_row24: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row24:
    bge $t3, $t2, finish_row24    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row24               # Jump back to iterate through the next ground spot
finish_row24:
    jal checkerboard_repainter
    j sleepy
no_pop_row24:
    jr $ra                       # Return from procedure
next_row24:
################################################################################
# CHECK WHEN TO POP ROW 25
################################################################################
jal checkRowsInTakenSpots_row25         
j next_row25
checkRowsInTakenSpots_row25 :
    la $a0, row_25                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row25: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row25 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row25:
    bge $t7, $a3, checkMatch_row25  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row25    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row25
setMatch_row25:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row25:
    beqz $s4, unsetAllMatch_row25   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row25                 # Back to start of rowLoop
unsetAllMatch_row25:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row25                 # Continue checking remaining rows
checkAllMatched_row25:
    beqz $s5, no_pop_row25           # If not all matched, jump to colorLocation152
    j pop_rows_row25                 # All matched, jump to colorLocation4
pop_rows_row25: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_25                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row25:
    bge $t3, $t2, endProgram_row25  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row25                   # Jump back to the start of the loop to color the next row.
endProgram_row25:
    la $a0, row_25                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row25:
    bge $t0, $a3, exit_row25        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_25                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row25:
    bge $t3, $a1, incrementTaken_row25
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row25  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row25
markAsRemoved_row25:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row25:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row25
exit_row25:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row25:
    bge $t3, $t2, end_loop_row25   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row25
    li $t7, 772                   # Assuming the minimum value of the spots in row_25
    bge $t5, $t7, skip_coloring_and_adding_row25
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row25:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row25   # Jump back to color the next spot and add 128.
end_loop_row25: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row25:
    bge $t3, $t2, finish_row25    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row25               # Jump back to iterate through the next ground spot
finish_row25:
    jal checkerboard_repainter
    j sleepy
no_pop_row25:
    jr $ra                       # Return from procedure
next_row25:
################################################################################
# CHECK WHEN TO POP ROW 26
################################################################################
jal checkRowsInTakenSpots_row26         
j next_row26
checkRowsInTakenSpots_row26 :
    la $a0, row_26                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row26: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row26 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row26:
    bge $t7, $a3, checkMatch_row26  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row26    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row26
setMatch_row26:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row26:
    beqz $s4, unsetAllMatch_row26   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row26                 # Back to start of rowLoop
unsetAllMatch_row26:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row26                 # Continue checking remaining rows
checkAllMatched_row26:
    beqz $s5, no_pop_row26           # If not all matched, jump to colorLocation152
    j pop_rows_row26                 # All matched, jump to colorLocation4
pop_rows_row26: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_26                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row26:
    bge $t3, $t2, endProgram_row26  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row26                   # Jump back to the start of the loop to color the next row.
endProgram_row26:
    la $a0, row_26                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row26:
    bge $t0, $a3, exit_row26        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_26                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row26:
    bge $t3, $a1, incrementTaken_row26
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row26  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row26
markAsRemoved_row26:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row26:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row26
exit_row26:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row26:
    bge $t3, $t2, end_loop_row26   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row26
    li $t7, 644                   # Assuming the minimum value of the spots in row_26
    bge $t5, $t7, skip_coloring_and_adding_row26
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row26:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row26   # Jump back to color the next spot and add 128.
end_loop_row26: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row26:
    bge $t3, $t2, finish_row26    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row26               # Jump back to iterate through the next ground spot
finish_row26:
    jal checkerboard_repainter
    j sleepy
no_pop_row26:
    jr $ra                       # Return from procedure
next_row26:
################################################################################
# CHECK WHEN TO POP ROW 27
################################################################################
jal checkRowsInTakenSpots_row27         
j next_row27
checkRowsInTakenSpots_row27 :
    la $a0, row_27                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row27: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row27 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row27:
    bge $t7, $a3, checkMatch_row27  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row27    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row27
setMatch_row27:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row27:
    beqz $s4, unsetAllMatch_row27   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row27                 # Back to start of rowLoop
unsetAllMatch_row27:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row27                 # Continue checking remaining rows
checkAllMatched_row27:
    beqz $s5, no_pop_row27           # If not all matched, jump to colorLocation152
    j pop_rows_row27                 # All matched, jump to colorLocation4
pop_rows_row27: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_27                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row27:
    bge $t3, $t2, endProgram_row27  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row27                   # Jump back to the start of the loop to color the next row.
endProgram_row27:
    la $a0, row_27                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row27:
    bge $t0, $a3, exit_row27        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_27                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row27:
    bge $t3, $a1, incrementTaken_row27
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row27  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row27
markAsRemoved_row27:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row27:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row27
exit_row27:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row27:
    bge $t3, $t2, end_loop_row27   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row27
    li $t7, 516                   # Assuming the minimum value of the spots in row_27
    bge $t5, $t7, skip_coloring_and_adding_row27
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row27:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row27   # Jump back to color the next spot and add 128.
end_loop_row27: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row27:
    bge $t3, $t2, finish_row27    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row27               # Jump back to iterate through the next ground spot
finish_row27:
    jal checkerboard_repainter
    j sleepy
no_pop_row27:
    jr $ra                       # Return from procedure
next_row27:
################################################################################
# CHECK WHEN TO POP ROW 28
################################################################################
jal checkRowsInTakenSpots_row28         
j next_row28
checkRowsInTakenSpots_row28 :
    la $a0, row_28                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row28: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row28 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row28:
    bge $t7, $a3, checkMatch_row28  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row28    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row28
setMatch_row28:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row28:
    beqz $s4, unsetAllMatch_row28   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row28                 # Back to start of rowLoop
unsetAllMatch_row28:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row28                 # Continue checking remaining rows
checkAllMatched_row28:
    beqz $s5, no_pop_row28           # If not all matched, jump to colorLocation152
    j pop_rows_row28                 # All matched, jump to colorLocation4
pop_rows_row28: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_28                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row28:
    bge $t3, $t2, endProgram_row28  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row28                   # Jump back to the start of the loop to color the next row.
endProgram_row28:
    la $a0, row_28                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row28:
    bge $t0, $a3, exit_row28        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_28                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row28:
    bge $t3, $a1, incrementTaken_row28
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row28  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row28
markAsRemoved_row28:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row28:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row28
exit_row28:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row28:
    bge $t3, $t2, end_loop_row28   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row28
    li $t7, 388                   # Assuming the minimum value of the spots in row_28
    bge $t5, $t7, skip_coloring_and_adding_row28
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row28:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row28   # Jump back to color the next spot and add 128.
end_loop_row28: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row28:
    bge $t3, $t2, finish_row28    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row28               # Jump back to iterate through the next ground spot
finish_row28:
    jal checkerboard_repainter
    j sleepy
no_pop_row28:
    jr $ra                       # Return from procedure
next_row28:
################################################################################
# CHECK WHEN TO POP ROW 29
################################################################################
jal checkRowsInTakenSpots_row29         
j next_row29
checkRowsInTakenSpots_row29 :
    la $a0, row_29                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row29: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row29 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row29:
    bge $t7, $a3, checkMatch_row29  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row29    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row29
setMatch_row29:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row29:
    beqz $s4, unsetAllMatch_row29   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row29                 # Back to start of rowLoop
unsetAllMatch_row29:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row29                 # Continue checking remaining rows
checkAllMatched_row29:
    beqz $s5, no_pop_row29           # If not all matched, jump to colorLocation152
    j pop_rows_row29                  # All matched, jump to colorLocation4
pop_rows_row29: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_29                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row29:
    bge $t3, $t2, endProgram_row29  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row29                   # Jump back to the start of the loop to color the next row.
endProgram_row29:
    la $a0, row_29                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row29:
    bge $t0, $a3, exit_row29        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_29                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row29:
    bge $t3, $a1, incrementTaken_row29
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row29  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row29
markAsRemoved_row29:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row29:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row29
exit_row29:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row29:
    bge $t3, $t2, end_loop_row29   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row29
    li $t7, 260                   # Assuming the minimum value of the spots in row_29
    bge $t5, $t7, skip_coloring_and_adding_row29
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row29:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row29   # Jump back to color the next spot and add 128.
end_loop_row29: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row29:
    bge $t3, $t2, finish_row29    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row29               # Jump back to iterate through the next ground spot
finish_row29:
    jal checkerboard_repainter
    j sleepy
no_pop_row29:
    jr $ra                       # Return from procedure
next_row29:
################################################################################
# CHECK WHEN TO POP ROW 30
################################################################################
jal checkRowsInTakenSpots_row30         
j next_row30
checkRowsInTakenSpots_row30 :
    la $a0, row_30                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row30: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row30 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row30:
    bge $t7, $a3, checkMatch_row30  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row30    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row30
setMatch_row30:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row30:
    beqz $s4, unsetAllMatch_row30   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row30                 # Back to start of rowLoop
unsetAllMatch_row30:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row30                 # Continue checking remaining rows
checkAllMatched_row30:
    beqz $s5, no_pop_row30           # If not all matched, jump to colorLocation152
    j pop_rows_row30                 # All matched, jump to colorLocation4
pop_rows_row30: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_30                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row30:
    bge $t3, $t2, endProgram_row30  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row30                   # Jump back to the start of the loop to color the next row.
endProgram_row30:
    la $a0, row_30                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row30:
    bge $t0, $a3, exit_row30        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_30                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row30:
    bge $t3, $a1, incrementTaken_row30
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row30  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row30
markAsRemoved_row30:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row30:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row30
exit_row30:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row30:
    bge $t3, $t2, end_loop_row30   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row30
    li $t7, 132                   # Assuming the minimum value of the spots in row_30
    bge $t5, $t7, skip_coloring_and_adding_row30
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row30:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row30   # Jump back to color the next spot and add 128.
end_loop_row30: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row30:
    bge $t3, $t2, finish_row30    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row30               # Jump back to iterate through the next ground spot
finish_row30:
    jal checkerboard_repainter
    j sleepy
no_pop_row30:
    jr $ra                       # Return from procedure
next_row30:
################################################################################
# CHECK WHEN TO POP ROW 31
################################################################################
jal checkRowsInTakenSpots_row31         
j next_row31
checkRowsInTakenSpots_row31 :
    la $a0, row_31                  # Address of rows
    li $a1, 12                     # Length of rows
    li $t5, 0                      # Rows index reset
    li $s5, 1                      # Assume allMatched is true initially reset
rowLoop_row31: 
    # Check if all rows are matched after loop
    bge $t5, $a1, checkAllMatched_row31 
    lw $t6, 0($a0)                 # Load current row element
    la $a2, taken_spots            # Address of taken_spots, reset for each row element
    lw $a3, num_taken_spots        # Length of taken_spots, reset for each check
    li $t7, 0                      # Taken_spots index reset for each row element
    li $s4, 0                      # Match found flag reset for current row element
takenLoop_row31:
    bge $t7, $a3, checkMatch_row31  # End of taken_spots, check match
    lw $t8, 0($a2)                 # Load current taken_spots element
    beq $t6, $t8, setMatch_row31    # Match found, set flag
    addi $a2, $a2, 4               # Next taken_spots element
    addi $t7, $t7, 1               # Increment taken_spots index
    j takenLoop_row31
setMatch_row31:
    li $s4, 1                      # Set match found flag for current row element
checkMatch_row31:
    beqz $s4, unsetAllMatch_row31   # No match found, unset allMatched flag
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row31                 # Back to start of rowLoop
unsetAllMatch_row31:
    li $s5, 0                      # Set allMatched to false
    addi $a0, $a0, 4               # Next row element
    addi $t5, $t5, 1               # Increment rows index
    j rowLoop_row31                 # Continue checking remaining rows
checkAllMatched_row31:
    beqz $s5, no_pop_row31           # If not all matched, jump to colorLocation152
    j pop_rows_row31                 # All matched, jump to colorLocation4
pop_rows_row31: 
        li $v0, 31    # async play note syscall
        li $a0, 45    # midi pitch
        li $a1, 1000  # duration
        li $a2, 0     # instrument
        li $a3, 100   # volume
        syscall
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, row_31                  # Load the address of the rows array into $t1.
    li $t2, 12                     # Load the length of the rows array into $t2.
    li $t3, 0                      # Index for iterating through rows.
    li $t4, 0xEABE6C               # White color.
color_row31:
    bge $t3, $t2, endProgram_row31  # If we've colored all rows, exit the loop.
    lw $t5, 0($t1)                 # Load the current row's offset into $t5.
    add $t6, $t0, $t5              # Calculate the actual memory address to color.
    sw $t4, 0($t6)                 # Write white to the calculated address.
    addi $t1, $t1, 4               # Move to the next element in the rows array.
    addi $t3, $t3, 1               # Increment our index.
    j color_row31                   # Jump back to the start of the loop to color the next row.
endProgram_row31:
    la $a0, row_31                  # Address of rows
    li $a1, 12                     # Length of rows
    la $a2, taken_spots            # Address of taken_spots
    lw $a3, num_taken_spots        # Length of taken_spots
    li $t0, 0
iterateTakenSpots_row31:
    bge $t0, $a3, exit_row31        # If done iterating through taken_spots, exit the loop
    lw $t1, 0($a2)                 # Load the current taken_spot element
    la $t2, row_31                  # Reset address of rows for each taken_spot element
    li $t3, 0                      # Reset index for iterating through rows
checkAgainstRows_row31:
    bge $t3, $a1, incrementTaken_row31
    lw $t4, 0($t2)         
    beq $t1, $t4, markAsRemoved_row31  
    addi $t2, $t2, 4               # Move to the next row element
    addi $t3, $t3, 1               # Increment rows index
    j checkAgainstRows_row31
markAsRemoved_row31:  
    li $t5, -4                     # The value used to mark elements as "removed"
    sw $t5, 0($a2)                 # Mark the current taken_spot element as "removed"
incrementTaken_row31:
    addi $a2, $a2, 4               # Move to the next taken_spot element
    addi $t0, $t0, 1               # Increment taken_spots index
    j iterateTakenSpots_row31
exit_row31:
    li $v0, 32                     # Set syscall number for sleep operation
    li $a0, 500                    # Set sleep duration in milliseconds
    syscall                        # Execute the syscall to sleep 
    jal checkerboard_repainter
    lw $t0, ADDR_DSPL              # Load the base address of the display into $t0.
    la $t1, taken_spots            # Load the address of the taken_spots array into $t1.
    lw $t2, num_taken_spots        # Load the length of the taken_spots array into $t2.
    li $t3, 0                      # Initialize index for iterating through taken_spots.
    li $t4, 0xEABE6C               # Load the color value for red into $t4.
color_spots_and_add_row31:
    bge $t3, $t2, end_loop_row31   # Check if all spots have been colored; if so, exit loop.
    lw $t5, 0($t1)                 # Load the current offset from the taken_spots array into $t5.
    li $t6, -4
    beq $t5, $t6, skip_coloring_and_adding_row31
    li $t7, 4                   # Assuming the minimum value of the spots in row_31
    bge $t5, $t7, skip_coloring_and_adding_row31
    add $t8, $t0, $t5
    sw $t4, 0($t8)
    addi $t5, $t5, 128
    sw $t5, 0($t1)
skip_coloring_and_adding_row31:
    addi $t1, $t1, 4              # Move to the next element in the taken_spots array.
    addi $t3, $t3, 1              # Increment the index.
    j color_spots_and_add_row31   # Jump back to color the next spot and add 128.
end_loop_row31: 
    li $v0, 32                    # Set syscall number for sleep operation
    li $a0, 500                   # Set sleep duration in milliseconds
    syscall                       # Execute the syscall to sleep  
    jal checkerboard_repainter
lw $t0, ADDR_DSPL                 # Load the base address of the display into $t0
la $t1, taken_spots               # Load the address of the ground array into $t1
lw $t2, num_taken_spots           # Load the number of elements in ground into $t2
li $t3, 0                         # Initialize index for iterating through ground
li $t4, 0xFDA403                  # Load the green color value into $t4
iterate_row31:
    bge $t3, $t2, finish_row31    # If all ground spots have been checked, exit loop
    lw $t5, 0($t1)               # Load the current ground offset into $t5
    add $t6, $t0, $t5            # Calculate the memory address to color
    sw $t4, 0($t6)               # Write the green color to the calculated address
    addi $t1, $t1, 4             # Move to the next element in ground
    addi $t3, $t3, 1             # Increment the ground index
    j iterate_row31               # Jump back to iterate through the next ground spot
finish_row31:
    jal checkerboard_repainter
    j sleepy
no_pop_row31:
    jr $ra                       # Return from procedure
next_row31:
##############################################################################
# CHECK KEYBOARD
##############################################################################     
    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    beq $t8, 1, keyboard_input      # If first word 1, key is pressed 
    j sleepy                        # If no key is pressed, go to end of loop
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
    # Check for 'P' key
    li $t9, 112       # Load ASCII code for 'P' into $t9
    beq $a0, $t9, pause_or_unpause   # If 'P' is pressed, branch to the rotate label
    # Check for 'F' key
    li $t9, 102       # Load ASCII code for 'F' into $t9
    beq $a0, $t9, Exit   # If 'P' is pressed, branch to the rotate label
    b game_loop
#----------------  2a,b, 3. Check for collisions, Update & Draw ------------------
pause_or_unpause: 
    # Check the current pause state
    la $t0, pause_state       # Load the address of pause_state into $t0
    lw $t1, 0($t0)            # Load the current pause state
    # Toggle the pause state
    li $t2, -1                # Set $t2 to -1
    bne $t1, $t2, set_paused  # If pause_state is not -1, set it to -1 (pause the game)
    j unset_paused            # Otherwise, set pause_state to 0 (unpause the game)
set_paused:
    # Set pause_state to -1 (game is paused)
    sw $t2, 0($t0)           # Store -1 in pause_state
    li $t9, 0xFDA403      # Set the color code for white
    lw $t7, ADDR_DSPL        # Load base address of the display
    sw $t9, 1088($t7) 
    sw $t9, 1092($t7) 
    sw $t9, 964($t7) 
    sw $t9, 836($t7) 
    sw $t9, 832($t7) 
    sw $t9, 828($t7) 
    sw $t9, 956($t7) 
    sw $t9, 1084($t7) 
    sw $t9, 1212($t7)        
    sw $t9, 1340($t7)
    li $v0, 33    # async play note syscall
    li $a0, 30    # midi pitch
    li $a1, 100  # duration
    li $a2, 0     # instrument
    li $a3, 100   # volume
    syscall     
    j wait_for_p_press       # Jump to wait for 'P' press to unpause
     # Jump to wait for 'P' press
unset_paused:
    # Set pause_state to 0 to indicate the game is not paused
    li $t2, 0                # Set $t2 to 0
    sw $t2, 0($t0)           # Store 0 in pause_state
    j game_loop              # Return to the game loop
wait_for_p_press:
    lw $t0, ADDR_KBRD         # $t0 = base address for keyboard
    lw $t8, 0($t0)            # Check if a key is pressed
    beqz $t8, wait_for_p_press # If no key is pressed, loop
    lw $a0, 4($t0)            # Load the pressed key code
    li $t9, 112               # ASCII for 'P'
    bne $a0, $t9, wait_for_p_press # If 'P' is not pressed, keep waiting
    # 'P' is pressed again, toggle pause state
    la $t0, pause_state
    lw $t1, 0($t0)
    bne $t1, $t2, unset_paused  # If pause_state is -1, set it to 0
    li $t9, 0xFFEDD8      # Set the color code for white
    lw $t7, ADDR_DSPL        # Load base address of the display
    sw $t9, 1088($t7) 
    sw $t9, 1092($t7) 
    sw $t9, 964($t7) 
    sw $t9, 836($t7) 
    sw $t9, 832($t7) 
    sw $t9, 828($t7) 
    sw $t9, 956($t7) 
    sw $t9, 1084($t7) 
    sw $t9, 1212($t7)        
    sw $t9, 1340($t7)
    j game_loop               # Return to the game loop
move_right: 
    jal checkerboard_repainter
    li $v0, 31    # async play note syscall
    li $a0, 90    # midi pitch
    li $a1, 100  # duration
    li $a2, 0     # instrument
    li $a3, 100   # volume 
    syscall
    # Offset positions for moving down
    addi $s0, $s0, 4 
    addi $s1, $s1, 4
    addi $s2, $s2, 4 
    addi $s3, $s3, 4
    # First, check against walls
    la $t0, walls
    lw $t1, num_walls
    li $t2, 0
find_collision_right_walls:
    beq $t2, $t1, check_taken_spots_right  # Go to check taken spots if no collision with walls
    lw $t3, 0($t0)
    beq $t3, $s0, wall_collision_right
    beq $t3, $s1, wall_collision_right
    beq $t3, $s2, wall_collision_right
    beq $t3, $s3, wall_collision_right
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_right_walls
check_taken_spots_right:
    # Check against num_taken_spots
    la $t0, taken_spots
    lw $t1, num_taken_spots
    li $t2, 0
find_collision_right_taken_spots:
    beq $t2, $t1, no_collision  # Proceed if no collisions found
    lw $t3, 0($t0)
    beq $t3, $s0, piece_collision_right
    beq $t3, $s1, piece_collision_right
    beq $t3, $s2, piece_collision_right
    beq $t3, $s3, piece_collision_right
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_right_taken_spots
wall_collision_right:
    addi $s0, $s0, -4  
    addi $s1, $s1, -4
    addi $s2, $s2, -4  
    addi $s3, $s3, -4
    jal paint_block
    j end_collision_right
piece_collision_right:
    addi $s0, $s0, -4  
    addi $s1, $s1, -4
    addi $s2, $s2, -4  
    addi $s3, $s3, -4
    jal paint_block
    j end_collision_right
no_collision_right:
    jal paint_block
    j end_collision_right 
end_collision_right:
    j sleepy
move_left: 
    jal checkerboard_repainter 
    li $v0, 31    # async play note syscall
    li $a0, 90    # midi pitch
    li $a1, 100  # duration
    li $a2, 0     # instrument
    li $a3, 100   # volume 
    syscall
    addi $s0, $s0, -4 
    addi $s1, $s1, -4
    addi $s2, $s2, -4 
    addi $s3, $s3, -4
    # First, check against walls
    la $t0, walls
    lw $t1, num_walls
    li $t2, 0
find_collision_left_walls:
    beq $t2, $t1, check_taken_spots_left  # Go to check taken spots if no collision with walls
    lw $t3, 0($t0)
    beq $t3, $s0, wall_collision_left
    beq $t3, $s1, wall_collision_left
    beq $t3, $s2, wall_collision_left
    beq $t3, $s3, wall_collision_left
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_left_walls

check_taken_spots_left:
    # Check against num_taken_spots
    la $t0, taken_spots
    lw $t1, num_taken_spots
    li $t2, 0
find_collision_left_taken_spots:
    beq $t2, $t1, no_collision  # Proceed if no collisions found
    lw $t3, 0($t0)
    beq $t3, $s0, piece_collision_left
    beq $t3, $s1, piece_collision_left
    beq $t3, $s2, piece_collision_left
    beq $t3, $s3, piece_collision_left
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_left_taken_spots
wall_collision_left:
    addi $s0, $s0, 4  
    addi $s1, $s1, 4
    addi $s2, $s2, 4  
    addi $s3, $s3, 4
    jal paint_block
    j end_collision_left
piece_collision_left:
    addi $s0, $s0, 4  
    addi $s1, $s1, 4
    addi $s2, $s2, 4  
    addi $s3, $s3, 4
    jal paint_block
    j end_collision_left
no_collision_left:
    jal paint_block
    j end_collision_left  
end_collision_left:
    j sleepy
move_down: 
    jal checkerboard_repainter 
    li $v0, 31    # async play note syscall
    li $a0, 90    # midi pitch
    li $a1, 100  # duration
    li $a2, 0     # instrument
    li $a3, 100   # volume 
    syscall
    # Offset positions for moving down
    addi $s0, $s0, 128 
    addi $s1, $s1, 128
    addi $s2, $s2, 128 
    addi $s3, $s3, 128
    # First, check against walls
    la $t0, walls
    lw $t1, num_walls
    li $t2, 0
find_collision_down_walls:
    beq $t2, $t1, check_taken_spots  # Go to check taken spots if no collision with walls
    lw $t3, 0($t0)
    beq $t3, $s0, wall_collision
    beq $t3, $s1, wall_collision
    beq $t3, $s2, wall_collision
    beq $t3, $s3, wall_collision
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_down_walls
check_taken_spots:
    # Check against num_taken_spots
    la $t0, taken_spots
    lw $t1, num_taken_spots
    li $t2, 0
find_collision_down_taken_spots:
    beq $t2, $t1, no_collision  # Proceed if no collisions found
    lw $t3, 0($t0)
    beq $t3, $s0, piece_collision
    beq $t3, $s1, piece_collision
    beq $t3, $s2, piece_collision
    beq $t3, $s3, piece_collision
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j find_collision_down_taken_spots
wall_collision:
    addi $s0, $s0, -128  
    addi $s1, $s1, -128
    addi $s2, $s2, -128  
    addi $s3, $s3, -128
    jal paint_block
    j end_collision_down
piece_collision:
    addi $s0, $s0, -128  
    addi $s1, $s1, -128
    addi $s2, $s2, -128  
    addi $s3, $s3, -128
    jal paint_block
    lw $t0, num_taken_spots   # Load the current number of elements in the array into $t0
    la $t1, taken_spots       # Load the address of the start of the array into $t1
    sll $t2, $t0, 2           # Calculate the byte offset ($t0 * 4) in the array for the new elements
    add $t1, $t1, $t2         # Add the offset to the base address of the array to find where to append
    sw $s0, 0($t1)            # Store $s0 in the array
    sw $s1, 4($t1)            # Store $s1 in the array
    sw $s2, 8($t1)            # Store $s2 in the array
    sw $s3, 12($t1)           # Store $s3 in the array
    addi $t0, $t0, 4          # Increment the number of elements in the array by 4
    sw $t0, num_taken_spots   # Update num_taken_spots
    jal start_the_L
    jal paint_block
    j end_collision_down
no_collision:
    jal paint_block
    j end_collision_down  
end_collision_down:
    j sleepy
rotate: 
    li $v0, 31    # async play note syscall
    li $a0, 80    # midi pitch
    li $a1, 100  # duration
    li $a2, 0     # instrument
    li $a3, 100   # volume
    syscall
    lw $t4, rotation_state
    # Increment the rotation state
    addi $t4, $t4, 1
    li $t5, 4
    div $t4, $t5
    mfhi $t4                # Use the remainder to keep the state within [0,3]
    sw $t4, rotation_state  # Store the updated state back
    la $a0, piece_state  # Load the address of piece_state into $a0
    lw $t0, 0($a0)       # Load the value of piece_state into $t0
    # Check the value of piece_state and jump to the corresponding label
    li $t1, 0
    beq $t0, $t1, state_zero
    li $t1, 1
    beq $t0, $t1, state_one
    li $t1, 2
    beq $t0, $t1, state_two
    li $t1, 3
    beq $t0, $t1, state_three
    li $t1, 4
    beq $t0, $t1, state_four
    li $t1, 5
    beq $t0, $t1, state_five
    li $t1, 6
    beq $t0, $t1, state_six
    j rotation_next  
state_zero:
# ##############################################################################
# # ROTATE THE O
# #############################################################################
    li $t2, 10
    j rotation_next
state_one:
# ##############################################################################
# # ROTATE THE I
# #############################################################################
   # Based on the rotation state, select the Tetrimino's color
    lw $t0, ADDR_DSPL       # Base address for the display
    beq $t4, 0, rotate_I_state_1
    beq $t4, 1, rotate_I_state_2
    beq $t4, 2, rotate_I_state_3
    beq $t4, 3, rotate_I_state_4
rotate_I_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, 124 
    addi $s1, $s1, 0 
    addi $s2, $s2, -124
    addi $s3, $s3, -248
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_I_state_2:
    beq $t2, $t1, check_collision_I_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_I_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_I_state_2
    beq $t4, $s2, match_collision_I_state_2
    beq $t4, $s3, match_collision_I_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_I_state_2               # Jump back to the start of the loop
match_collision_I_state_2:
    li $t5, 1              # Set match found flag
    j check_collision_I_state_2           
check_collision_I_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_I_state_2  # If match found, jump to collision
    j no_collision_I_state_2          # Otherwise, no collision
no_collision_I_state_2:
    jal paint_block
    j end_collision_I_state_2                
found_collision_I_state_2:
    addi $s0, $s0, -124 
    addi $s1, $s1, 0 
    addi $s2, $s2, 124
    addi $s3, $s3, 248
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_I_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_I_state_2
wrap_around_I_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_I_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_I_state_2                  
end_collision_I_state_2: 
    j sleepy
rotate_I_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, -124 
    addi $s1, $s1, 0 
    addi $s2, $s2, 124
    addi $s3, $s3, 248
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_I_state_3:
    beq $t2, $t1, check_collision_I_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_I_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_I_state_3
    beq $t4, $s2, match_collision_I_state_3
    beq $t4, $s3, match_collision_I_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_I_state_3               # Jump back to the start of the loop
match_collision_I_state_3:
    li $t5, 1              # Set match found flag
    j check_collision_I_state_3           
check_collision_I_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_I_state_3  # If match found, jump to collision
    j no_collision_I_state_3          # Otherwise, no collision
no_collision_I_state_3:
    jal paint_block
    j end_collision_I_state_3                
found_collision_I_state_3:
    addi $s0, $s0, 124 
    addi $s1, $s1, 0 
    addi $s2, $s2, -124
    addi $s3, $s3, -248
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_I_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_I_state_3
wrap_around_I_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_I_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_I_state_3                  
end_collision_I_state_3:
    j sleepy
rotate_I_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, 124 
    addi $s1, $s1, 0 
    addi $s2, $s2, -124
    addi $s3, $s3, -248
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_I_state_4:
    beq $t2, $t1, check_collision_I_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_I_state_4
    beq $t4, $s1, match_collision_I_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_I_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_I_state_4           # Repeat for next element
match_collision_I_state_4:
    li $t5, 1              # Collision detected
    j check_collision_I_state_4
check_collision_I_state_4:
    beq $t5, 1, collision_found_I_state_4  # Branch if collision detected
    j no_collision_I_state_4
no_collision_I_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_I_state_4
collision_found_I_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -124 
    addi $s1, $s1, 0 
    addi $s2, $s2, 124
    addi $s3, $s3, 248
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_I_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_I_state_4
    wrap_around_I_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
    store_update_I_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_I_state_4
end_collision_I_state_4:
    j sleepy
rotate_I_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, -124 
    addi $s1, $s1, 0 
    addi $s2, $s2, 124
    addi $s3, $s3, 248
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_I_state_1:
    beq $t2, $t1, check_collision_I_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_I_state_1
    beq $t4, $s1, match_collision_I_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_I_state_1 # Repeat for next element
match_collision_I_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_I_state_1
check_collision_I_state_1:
    beq $t5, 1, collision_found_I_state_1  # Branch if collision detected
    j no_collision_I_state_1
no_collision_I_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_I_state_1
collision_found_I_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 124 
    addi $s1, $s1, 0 
    addi $s2, $s2, -124
    addi $s3, $s3, -248
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_I_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_I_state_1
wrap_around_I_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_I_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_I_state_1
end_collision_I_state_1:
    j sleepy
    li $t2, 20
    j rotation_next
state_two:
# ##############################################################################
# # ROTATE THE S
# #############################################################################
    # Based on the rotation state, select the Tetrimino's color
    lw $t0, ADDR_DSPL       # Base address for the display
    beq $t4, 0, rotate_S_state_1
    beq $t4, 1, rotate_S_state_2
    beq $t4, 2, rotate_S_state_3
    beq $t4, 3, rotate_S_state_4
rotate_S_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, 0 
    addi $s1, $s1, -128
    addi $s2, $s2, -128
    addi $s3, $s3, 8  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_S_state_2:
    beq $t2, $t1, check_collision_S_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_S_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_S_state_2
    beq $t4, $s2, match_collision_S_state_2
    beq $t4, $s3, match_collision_S_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_S_state_2               # Jump back to the start of the loop
match_collision_S_state_2:
    li $t5, 1              # Set match found flag
    j check_collision_S_state_2           
check_collision_S_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_S_state_2  # If match found, jump to collision
    j no_collision_S_state_2          # Otherwise, no collision
no_collision_S_state_2:
    jal paint_block
    j end_collision_S_state_2                
found_collision_S_state_2:
    addi $s0, $s0, 0 
    addi $s1, $s1, 128
    addi $s2, $s2, 128
    addi $s3, $s3, -8 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_S_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_S_state_2
wrap_around_S_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_S_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_S_state_2                  
end_collision_S_state_2: 
    j sleepy
rotate_S_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, 0 
    addi $s1, $s1, 128
    addi $s2, $s2, 128
    addi $s3, $s3, -8 
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_S_state_3:
    beq $t2, $t1, check_collision_S_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_S_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_S_state_3
    beq $t4, $s2, match_collision_S_state_3
    beq $t4, $s3, match_collision_S_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_S_state_3               # Jump back to the start of the loop
match_collision_S_state_3:
    li $t5, 1              # Set match found flag
    j check_collision_S_state_3           
check_collision_S_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_S_state_3  # If match found, jump to collision
    j no_collision_S_state_3          # Otherwise, no collision
no_collision_S_state_3:
    jal paint_block
    j end_collision_S_state_3                
found_collision_S_state_3:
    addi $s0, $s0, 0 
    addi $s1, $s1, -128
    addi $s2, $s2, -128
    addi $s3, $s3, 8 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_S_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_S_state_3
wrap_around_S_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_S_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_S_state_3                  
end_collision_S_state_3:
    j sleepy
rotate_S_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, -4 
    addi $s1, $s1, -132
    addi $s2, $s2, -132
    addi $s3, $s3, 4  
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_S_state_4:
    beq $t2, $t1, check_collision_S_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_S_state_4
    beq $t4, $s1, match_collision_S_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_S_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_S_state_4           # Repeat for next element
match_collision_S_state_4:
    li $t5, 1              # Collision detected
    j check_collision_S_state_4
check_collision_S_state_4:
    beq $t5, 1, collision_found_S_state_4  # Branch if collision detected
    j no_collision_S_state_4
no_collision_S_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_S_state_4
collision_found_S_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 4 
    addi $s1, $s1, 132
    addi $s2, $s2, 132
    addi $s3, $s3, -4 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_S_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_S_state_4
    wrap_around_S_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
    store_update_S_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_S_state_4
end_collision_S_state_4:
    j sleepy
rotate_S_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, 4 
    addi $s1, $s1, 132
    addi $s2, $s2, 132
    addi $s3, $s3, -4 
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_S_state_1:
    beq $t2, $t1, check_collision_S_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_S_state_1
    beq $t4, $s1, match_collision_S_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_S_state_1 # Repeat for next element
match_collision_S_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_S_state_1
check_collision_S_state_1:
    beq $t5, 1, collision_found_S_state_1  # Branch if collision detected
    j no_collision_S_state_1
no_collision_S_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_S_state_1
collision_found_S_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -4 
    addi $s1, $s1, -132
    addi $s2, $s2, -132
    addi $s3, $s3, 4 
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_S_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_S_state_1
wrap_around_S_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_S_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_S_state_1
end_collision_S_state_1:
    j sleepy
    li $t2, 30
    j rotation_next

state_three:
# ##############################################################################
# # ROTATE THE Z
# #############################################################################
    # Based on the rotation state, select the Tetrimino's color
    lw $t0, ADDR_DSPL       # Base address for the display
    beq $t4, 0, rotate_Z_state_1
    beq $t4, 1, rotate_Z_state_2
    beq $t4, 2, rotate_Z_state_3
    beq $t4, 3, rotate_Z_state_4
rotate_Z_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, 0 
    addi $s1, $s1, 8 
    addi $s2, $s2, 0
    addi $s3, $s3, -256  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_Z_state_2:
    beq $t2, $t1, check_collision_Z_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_Z_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_Z_state_2
    beq $t4, $s2, match_collision_Z_state_2
    beq $t4, $s3, match_collision_Z_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_Z_state_2               # Jump back to the start of the loop
match_collision_Z_state_2:
    li $t5, 1              # Set match found flag
    j check_collision_Z_state_2           
check_collision_Z_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_Z_state_2  # If match found, jump to collision
    j no_collision_Z_state_2          # Otherwise, no collision
no_collision_Z_state_2:
    jal paint_block
    j end_collision_Z_state_2                
found_collision_Z_state_2:
    addi $s0, $s0, 0 
    addi $s1, $s1, -8 
    addi $s2, $s2, 0
    addi $s3, $s3, 256 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_Z_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_Z_state_2
wrap_around_Z_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_Z_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_Z_state_2                  
end_collision_Z_state_2: 
    j sleepy
rotate_Z_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, 0 
    addi $s1, $s1, -8 
    addi $s2, $s2, 0
    addi $s3, $s3, 256  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collision_Z_state_3:
    beq $t2, $t1, check_collision_Z_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_Z_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_Z_state_3
    beq $t4, $s2, match_collision_Z_state_3
    beq $t4, $s3, match_collision_Z_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collision_Z_state_3               # Jump back to the start of the loop
match_collision_Z_state_3:
    li $t5, 1              # Set match found flag
    j check_collision_Z_state_3           
check_collision_Z_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_Z_state_3  # If match found, jump to collision
    j no_collision_Z_state_3          # Otherwise, no collision
no_collision_Z_state_3:
    jal paint_block
    j end_collision_Z_state_3                
found_collision_Z_state_3:
    addi $s0, $s0, 0 
    addi $s1, $s1, 8 
    addi $s2, $s2, 0
    addi $s3, $s3, -256 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_Z_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_Z_state_3
wrap_around_Z_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_Z_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_Z_state_3                  
end_collision_Z_state_3:
    j sleepy
rotate_Z_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, -4 
    addi $s1, $s1, 4 
    addi $s2, $s2, -4
    addi $s3, $s3, -260 
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_Z_state_4:
    beq $t2, $t1, check_collision_Z_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_Z_state_4
    beq $t4, $s1, match_collision_Z_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_Z_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_Z_state_4           # Repeat for next element
match_collision_Z_state_4:
    li $t5, 1              # Collision detected
    j check_collision_Z_state_4
check_collision_Z_state_4:
    beq $t5, 1, collision_found_Z_state_4  # Branch if collision detected
    j no_collision_Z_state_4
no_collision_Z_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_Z_state_4
collision_found_Z_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 4 
    addi $s1, $s1, -4 
    addi $s2, $s2, 4
    addi $s3, $s3, 260 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_Z_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_Z_state_4
    wrap_around_Z_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
    store_update_Z_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_Z_state_4
end_collision_Z_state_4:
    j sleepy
rotate_Z_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, 4
    addi $s1, $s1, -4 
    addi $s2, $s2, 4
    addi $s3, $s3, 260 
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_Z_state_1:
    beq $t2, $t1, check_collision_Z_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_Z_state_1
    beq $t4, $s1, match_collision_Z_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_Z_state_1 # Repeat for next element
match_collision_Z_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_Z_state_1
check_collision_Z_state_1:
    beq $t5, 1, collision_found_Z_state_1  # Branch if collision detected
    j no_collision_Z_state_1
no_collision_Z_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_Z_state_1
collision_found_Z_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -4
    addi $s1, $s1, 4 
    addi $s2, $s2, -4
    addi $s3, $s3, -260 
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_Z_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_Z_state_1
wrap_around_Z_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_Z_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_Z_state_1
end_collision_Z_state_1:
    j sleepy
    li $t2, 40
    j rotation_next
state_four:
# #############################################################################
# ROTATE THE L
# #############################################################################
    # Based on the rotation state, select the Tetrimino's color
    lw $t0, ADDR_DSPL       # Base address for the display
    beq $t4, 0, rotate_L_state_1
    beq $t4, 1, rotate_L_state_2
    beq $t4, 2, rotate_L_state_3
    beq $t4, 3, rotate_L_state_4
rotate_L_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, 124 
    #addi $s1, $s1, 0 
    addi $s2, $s2, -4
    addi $s3, $s3, -128  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_L_state_2:
    beq $t2, $t1, check_collison_L_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_L_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_L_state_2
    beq $t4, $s2, match_collision_L_state_2
    beq $t4, $s3, match_collision_L_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_L_state_2               # Jump back to the start of the loop
match_collision_L_state_2:
    li $t5, 1              # Set match found flag
    j check_collison_L_state_2           
check_collison_L_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_L_state_2  # If match found, jump to collision
    j no_collision_L_state_2          # Otherwise, no collision
no_collision_L_state_2:
    jal paint_block
    j end_collison_L_state_2                
found_collision_L_state_2:
    addi $s0, $s0, -124 
    #addi $s1, $s1, 0 
    addi $s2, $s2, 4
    addi $s3, $s3, 128  
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_L_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_L_state_2
wrap_around_L_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_L_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_L_state_2                  
end_collison_L_state_2: 
    j sleepy
rotate_L_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, -128
    # No adjustment for $s1
    addi $s2, $s2, 4
    addi $s3, $s3, -132
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_L_state_3:
    beq $t2, $t1, check_collison_L_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_L_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_L_state_3
    beq $t4, $s2, match_collision_L_state_3
    beq $t4, $s3, match_collision_L_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_L_state_3               # Jump back to the start of the loop
match_collision_L_state_3:
    li $t5, 1              # Set match found flag
    j check_collison_L_state_3           
check_collison_L_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_L_state_3  # If match found, jump to collision
    j no_collision_L_state_3          # Otherwise, no collision
no_collision_L_state_3:
    jal paint_block
    j end_collison_L_state_3                
found_collision_L_state_3:
    addi $s0, $s0, 128
    # No adjustment for $s1
    addi $s2, $s2, -4
    addi $s3, $s3, 132 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_L_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_L_state_3
wrap_around_L_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_L_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_L_state_3                  
end_collison_L_state_3:
    j sleepy
rotate_L_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, 256
    addi $s1, $s1, 4
    # $s2 does not change
    addi $s3, $s3, 260
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_L_state_4:
    beq $t2, $t1, check_collision_L_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_L_state_4
    beq $t4, $s1, match_collision_L_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_L_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_L_state_4           # Repeat for next element
match_collision_L_state_4:
    li $t5, 1              # Collision detected
    j check_collision_L_state_4
check_collision_L_state_4:
    beq $t5, 1, collision_found_L_state_4  # Branch if collision detected
    j no_collision_L_state_4
no_collision_L_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_L_state_4
collision_found_L_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -256
    addi $s1, $s1, -4
    # No adjustment needed for $s2 if it wasn't changed
    addi $s3, $s3, -260
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_L_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_L_state_4
    wrap_around_L_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
    store_update_L_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_L_state_4
end_collision_L_state_4:
    j sleepy
rotate_L_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, -252
    addi $s1, $s1, -4
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_L_state_1:
    beq $t2, $t1, check_collision_L_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_L_state_1
    beq $t4, $s1, match_collision_L_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_L_state_1 # Repeat for next element
match_collision_L_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_L_state_1
check_collision_L_state_1:
    beq $t5, 1, collision_found_L_state_1  # Branch if collision detected
    j no_collision_L_state_1
no_collision_L_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_L_state_1
collision_found_L_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 252
    addi $s1, $s1, 4
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_L_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_L_state_1
wrap_around_L_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_L_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_L_state_1
end_collision_L_state_1:
    j sleepy
    li $t2, 50
    j rotation_next
state_five:
# #############################################################################
# ROTATE THE J
# #############################################################################
# Based on the rotation state, select the Tetrimino's color
lw $t0, ADDR_DSPL       # Base address for the display
beq $t4, 0, rotate_J_state_1
beq $t4, 1, rotate_J_state_2
beq $t4, 2, rotate_J_state_3
beq $t4, 3, rotate_J_state_4
rotate_J_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, 260 
    addi $s1, $s1, -4 
    addi $s2, $s2, 0
    addi $s3, $s3, 0  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_J_state_2:
    beq $t2, $t1, check_collison_J_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_J_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_J_state_2
    beq $t4, $s2, match_collision_J_state_2
    beq $t4, $s3, match_collision_J_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_J_state_2               # Jump back to the start of the loop
match_collision_J_state_2:
    li $t5, 1              # Set match found flag
    j check_collison_J_state_2           
check_collison_J_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_J_state_2  # If match found, jump to collision
    j no_collision_J_state_2          # Otherwise, no collision
no_collision_J_state_2:
    jal paint_block
    j end_collison_J_state_2                
found_collision_J_state_2:
    addi $s0, $s0, -260 
    addi $s1, $s1, 4 
    addi $s2, $s2, 0
    addi $s3, $s3, 0  
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_J_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_J_state_2
wrap_around_J_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_J_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_J_state_2                  
end_collison_J_state_2: 
    j sleepy
rotate_J_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, -256 
    addi $s1, $s1, -124
    addi $s2, $s2, 0
    addi $s3, $s3, -124  
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_J_state_3:
    beq $t2, $t1, check_collison_J_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_J_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_J_state_3
    beq $t4, $s2, match_collision_J_state_3
    beq $t4, $s3, match_collision_J_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_J_state_3               # Jump back to the start of the loop
match_collision_J_state_3:
    li $t5, 1              # Set match found flag
    j check_collison_J_state_3           
check_collison_J_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_J_state_3  # If match found, jump to collision
    j no_collision_J_state_3          # Otherwise, no collision
no_collision_J_state_3:
    jal paint_block
    j end_collison_J_state_3                
found_collision_J_state_3:
    addi $s0, $s0, 256 
    addi $s1, $s1, 124
    addi $s2, $s2, 0
    addi $s3, $s3, 124 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_J_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_J_state_3
wrap_around_J_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_J_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_J_state_3                  
end_collison_J_state_3:
    j sleepy
rotate_J_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, 128 
    addi $s1, $s1, 124
    addi $s2, $s2, 4
    addi $s3, $s3, 0 
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_J_state_4:
    beq $t2, $t1, check_collision_J_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_J_state_4
    beq $t4, $s1, match_collision_J_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_J_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_J_state_4           # Repeat for next element
match_collision_J_state_4:
    li $t5, 1              # Collision detected
    j check_collision_J_state_4
check_collision_J_state_4:
    beq $t5, 1, collision_found_J_state_4  # Branch if collision detected
    j no_collision_J_state_4
no_collision_J_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_J_state_4
collision_found_J_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -128 
    addi $s1, $s1, -124
    addi $s2, $s2, -4
    addi $s3, $s3, 260 
    # No adjustment needed for $s2 if it wasn't changed
    addi $s3, $s3, -260
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_J_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_J_state_4
wrap_around_J_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_J_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_J_state_4
end_collision_J_state_4:
    j sleepy
rotate_J_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, -132 
    addi $s1, $s1, 4
    addi $s2, $s2, -4
    addi $s3, $s3, 124
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_J_state_1:
    beq $t2, $t1, check_collision_J_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_J_state_1
    beq $t4, $s1, match_collision_J_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_J_state_1 # Repeat for next element
match_collision_J_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_J_state_1
check_collision_J_state_1:
    beq $t5, 1, collision_found_J_state_1  # Branch if collision detected
    j no_collision_J_state_1
no_collision_J_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_J_state_1
collision_found_J_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 132 
    addi $s1, $s1, -4
    addi $s2, $s2, 4
    addi $s3, $s3, -124 
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_J_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_J_state_1
wrap_around_J_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_J_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_J_state_1
end_collision_J_state_1:
    j sleepy
    li $t2, 60
    j rotation_next
state_six:
# #############################################################################
# ROTATE THE T
# #############################################################################
# Based on the rotation state, select the Tetrimino's color
lw $t0, ADDR_DSPL       # Base address for the display
beq $t4, 0, rotate_T_state_1
beq $t4, 1, rotate_T_state_2
beq $t4, 2, rotate_T_state_3
beq $t4, 3, rotate_T_state_4
rotate_T_state_2: 
    jal checkerboard_repainter 
    addi $s0, $s0, -128
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, -252 
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_T_state_2:
    beq $t2, $t1, check_collison_T_state_2 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_T_state_2  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_T_state_2
    beq $t4, $s2, match_collision_T_state_2
    beq $t4, $s3, match_collision_T_state_2
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_T_state_2               # Jump back to the start of the loop
match_collision_T_state_2:
    li $t5, 1              # Set match found flag
    j check_collison_T_state_2           
check_collison_T_state_2:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_T_state_2  # If match found, jump to collision
    j no_collision_T_state_2          # Otherwise, no collision
no_collision_T_state_2:
    jal paint_block
    j end_collison_T_state_2                
found_collision_T_state_2:
    addi $s0, $s0, 128
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, 252 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_T_state_2
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_T_state_2
wrap_around_T_state_2:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_T_state_2:
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_T_state_2                  
end_collison_T_state_2: 
    j sleepy
rotate_T_state_3: 
    jal checkerboard_repainter 
    addi $s0, $s0, 0 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, 124 
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0
find_collisson_T_state_3:
    beq $t2, $t1, check_collison_T_state_3 # If index equals array length, check for match
    lw $t4, 0($t0)         # Load the current word from the array into $t4
    beq $t4, $s0, match_collision_T_state_3  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_T_state_3
    beq $t4, $s2, match_collision_T_state_3
    beq $t4, $s3, match_collision_T_state_3
    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_T_state_3               # Jump back to the start of the loop
match_collision_T_state_3:
    li $t5, 1              # Set match found flag
    j check_collison_T_state_3           
check_collison_T_state_3:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_T_state_3  # If match found, jump to collision
    j no_collision_T_state_3          # Otherwise, no collision
no_collision_T_state_3:
    jal paint_block
    j end_collison_T_state_3                
found_collision_T_state_3:
    addi $s0, $s0, 0 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, -124 
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_T_state_3
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_T_state_3
wrap_around_T_state_3:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_T_state_3:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collison_T_state_3                  
end_collison_T_state_3:
    j sleepy
rotate_T_state_4:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Offset the blocks for collision detection or positioning
    addi $s0, $s0, -132 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, 0 
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_T_state_4:
    beq $t2, $t1, check_collision_T_state_4 # End loop if we've checked all elements
    lw $t4, 0($t0)         # Load current element for comparison
    beq $t4, $s0, match_collision_T_state_4
    beq $t4, $s1, match_collision_T_state_4
    # $s2 comparison could be added here if $s2 is also subject to change
    beq $t4, $s3, match_collision_T_state_4
    addiu $t0, $t0, 4       # Move to the next element
    addiu $t2, $t2, 1       # Increment index
    j find_collision_T_state_4           # Repeat for next element
match_collision_T_state_4:
    li $t5, 1              # Collision detected
    j check_collision_T_state_4
check_collision_T_state_4:
    beq $t5, 1, collision_found_T_state_4  # Branch if collision detected
    j no_collision_T_state_4
no_collision_T_state_4:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_T_state_4
collision_found_T_state_4:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, 132 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, 0
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_T_state_4
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_T_state_4
wrap_around_T_state_4:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_T_state_4:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_T_state_4
end_collision_T_state_4:
    j sleepy
rotate_T_state_1:
    jal checkerboard_repainter  # Refresh the game board before attempting rotation
    # Temporarily adjust the blocks for collision detection or positioning
    addi $s0, $s0, 260 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, 128 
    # Since $s2 and $s3 are not being offset, they're not adjusted here
    # Prepare for collision detection with the array (assuming walls or similar)
    la $t0, walls              # Load the address of the walls array
    lw $t1, num_walls          # Load the number of elements in the walls array
    li $t2, 0                  # Initialize index for array iteration
    li $t5, 0                  # Initialize collision flag to 0
find_collision_T_state_1:
    beq $t2, $t1, check_collision_T_state_1 # End loop if we've checked all elements
    lw $t4, 0($t0)             # Load current element for comparison
    beq $t4, $s0, match_collision_T_state_1
    beq $t4, $s1, match_collision_T_state_1
    # Checks for $s2 and $s3 could be added here if they are subject to change
    addiu $t0, $t0, 4          # Move to the next element
    addiu $t2, $t2, 1          # Increment index
    j find_collision_T_state_1 # Repeat for next element
match_collision_T_state_1:
    li $t5, 1                  # Collision detected
    j check_collision_T_state_1
check_collision_T_state_1:
    beq $t5, 1, collision_found_T_state_1  # Branch if collision detected
    j no_collision_T_state_1
no_collision_T_state_1:
    # If no collision, proceed with painting the Tetrimino
    jal paint_block
    j end_collision_T_state_1
collision_found_T_state_1:
    # Reverse the offset adjustment due to collision
    addi $s0, $s0, -260 
    addi $s1, $s1, 0
    addi $s2, $s2, 0
    addi $s3, $s3, -128 
    # No adjustment needed for $s2 and $s3 if they weren't changed
    # Load the address of rotation_state into $t0
    la $t0, rotation_state
    # Load the current value of rotation_state into $t1
    lw $t1, 0($t0)
    # Check if rotation_state is 0, to wrap around to 3
    beq $t1, 0, wrap_around_T_state_1
    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update_T_state_1
wrap_around_T_state_1:
    # Wrap around to 3 if it was 0
    li $t1, 3
store_update_T_state_1:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)
    jal paint_block
    j end_collision_T_state_1
end_collision_T_state_1:
    j sleepy
    li $t2, 70
    j rotation_next
rotation_next:
    j sleepy
Exit:
li $v0, 10 # terminate the program gracefully
syscall
sleepy:
    # Perform the sleep syscall once at the end of the game loop iteration
    li $v0, 32                      # Set syscall number for sleep operation
    li $a0, 20                      # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep
    j game_loop                     # Jump back to the start of the game loop