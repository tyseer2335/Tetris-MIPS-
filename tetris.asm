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
    72, 200, 328, 456, 584, 712, 840, 968, 1096, 1224, 1352, 1480, 1608, 1736, 1864, 1992, 2120, 2248, 2376, 2504, 2632, 2760, 2888, 3016, 3144, 3272, 3400, 3528, 3656, 3784, 3912, 4040
    4168, 4296, 4424, 4552, 4680, 4808, 4936, 5064, 5192, 5320, 5448, 5576, 5704, 5832, 5960, 6088, 6216, 6344, 6472, 6600, 6728, 6856, 6984, 7112, 7240, 7368, 7496, 7624, 7752, 7880, 
    8008, 8136, 8264, 8392, 8520, 8648, 8776, 8904, 9032, 9160, 9288, 9416, 9544, 9672, 9800, 9928, 10056, 10184, 10312, 10440, 10568, 10696, 10824, 10952, 11080, 11208, 11336, 11464, 11592, 11720, 11848, 11976, 12104, 
    
    12232, 12360, 12488, 12616, 12744, 12872, 13000, 13128, 13256, 13384, 13512, 13640, 13768, 13896, 14024, 14152, 14280, 14408, 14536, 14664, 14792, 14920, 15048, 15176, 15304, 15432, 15560, 15688, 15816, 15944, 16072, 16200, 
    16200, 16328, 16456, 16584, 16712, 16840, 16968, 17096, 17224, 17352, 17480, 17608, 17736, 17864, 17992, 18120, 18248, 18376, 18504, 18632, 18760, 18888, 19016, 19144, 19272, 19400, 19528, 19656, 19784, 19912, 20040, 20168,  
    20296, 20424, 20552, 20680, 20808, 20936, 21064, 21192, 21320, 21448, 21576, 21704, 21832, 21960, 22088, 22216, 22344, 22472, 22600, 22728, 22856, 22984, 23112, 23240, 23368, 23496, 23624, 23752, 23880, 24008, 24136, 24264, 
    24392, 24520, 24648, 24776, 24904, 25032, 25160, 25288, 25416, 25544, 25672, 25800, 25928, 26056, 26184, 26312, 26440, 26568, 26696, 26824, 26952, 27080, 27208, 27336, 27464, 27592, 27720, 27848, 27976, 28104, 28232, 28360, 
    28488, 28616, 28744, 28872, 29000, 29128, 29256, 29384, 29512, 29640, 29768, 29896, 30024, 30152, 30280, 30408, 30536, 30664, 30792, 30920, 31048, 31176, 31304, 31432, 31560, 31688, 31816, 31944, 32072, 32200, 32328, 32456,  
    32584, 32712, 32840, 32968, 33096, 33224, 33352, 33480, 33608, 33736, 33864, 33992, 34120, 34248, 34376, 34504, 34632, 34760, 34888, 35016, 35144, 35272, 35400, 35528, 35656, 35784, 35912, 36040, 36168, 36296, 36424, 36552
    
good_spots: 
    .word 4, 12, 20, 28, 36, 136, 144, 152, 160, 168, 260, 268, 276, 284, 292, 392, 400, 408, 416, 424, 516, 524, 532,  
    540, 548, 648, 656, 664, 672, 680, 772, 780, 788, 796, 804, 904, 912, 920, 928, 936, 1028, 1036, 1044, 1052, 1060,  
    1160, 1168, 1176, 1184, 1192, 1284, 1292, 1300, 1308, 1316, 1416, 1424, 1432, 1440, 1448, 1540, 1548, 1556, 1564,  
    1572, 1672, 1680, 1688, 1696, 1704, 1796, 1804, 1812, 1820, 1828, 1928, 1936, 1944, 1952, 1960, 2052, 2060, 2068,  
    2076, 2084, 2184, 2192, 2200, 2208, 2216, 2308, 2316, 2324, 2332, 2340, 2440, 2448, 2456, 2464, 2472, 2564, 2572,  
    2580, 2588, 2596, 2696, 2704, 2712, 2720, 2728, 2820, 2828, 2836, 2844, 2852, 2952, 2960, 2968, 2976, 2984, 3076,  
    3084, 3092, 3100, 3108, 3208, 3216, 3224, 3232, 3240, 3332, 3340, 3348, 3356, 3364, 3464, 3472, 3480, 3488, 3496,  
    3588, 3596, 3604, 3612, 3620, 3720, 3728, 3736, 3744, 3752, 3844, 3852, 3860, 3868, 3876, 44, 300, 556, 812, 1068, 
    1324, 1580, 1836, 2092, 2348, 2604, 2860, 3116, 3372, 3628, 3884, 8, 16, 24, 32, 40, 132, 140, 148, 156, 164, 172, 264, 272,  
    280, 288, 296, 388, 396, 404, 412, 420, 428, 520, 528, 536, 544,  
    552, 644, 652, 660, 668, 676, 684, 776, 784, 792, 800, 808, 900, 908, 916, 924, 932, 940, 1032, 1040, 1048, 1056, 1064, 1156,  
    1164, 1172, 1180, 1188, 1196, 1288, 1296, 1304, 1312, 1320, 1412, 1420, 1428, 1436, 1444, 1452, 1544, 1552, 1560, 1568, 1576, 
    1668, 1676, 1684, 1692, 1700, 1708, 1800, 1808, 1816, 1824, 1832, 1924, 1932, 1940, 1948, 1956, 1964, 2056, 2064, 2072, 2080, 
    2088, 2180, 2188, 2196, 2204, 2212, 2220, 2312, 2320, 2328, 2336, 2344, 2436, 2444, 2452, 2460, 2468, 2476, 2568, 2576, 2584, 
    2592, 2600, 2692, 2700, 2708, 2716, 2724, 2732, 2824, 2832, 2840, 2848, 2856, 2948, 2956, 2964, 2972, 2980, 2988, 3080, 3088, 
    3096, 3104, 3112, 3204, 3212, 3220, 3228, 3236, 3244, 3336, 3344, 3352, 3360, 3368, 3460, 3468, 3476, 3484, 3492, 3500, 3592, 
    3600, 3608, 3616, 3624, 3716, 3724, 3732, 3740, 3748, 3756, 3848, 3856, 3864, 3872, 3880,  
    
    
    
    
all_check: 
    .word 0     
    
    
    
num_good_spots: 
    .word 280
    
    
num_walls: 
    .word 384 
taken_spots: 
    .word 
num_taken_spots: 
    .word 2
num_squares: 
    .word 171       
taken_spots_by_trimino: 
    .word 24, 152, 280, 284 
possible_taken_spots_by_trimino: 
    .word -1, -1, -1, -1
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
# DRAW WALL
# ---------------------------------------------------------------------------- 
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
# ----------------------------------------------------------------------------
# CHECKERBOARD PATTERN (Used Later also to repaint board)
# ----------------------------------------------------------------------------
jal checkerboard_repainter
j checkerboard_done

checkerboard_repainter:
li $t2, 0x31363F                  # Red color for painting squares 0x31363F
    lw $t0, ADDR_DSPL             # Load base address of the display into $t0
    la $t1, black_squares         # Load the address of the black_squares array into $t1
    lw $t3, num_squares           # Total number of elements in black_squares
    li $t4, 0                     # Index counter for iterating through black_squares

loop_squares:
    beq $t4, $t3, end_loop         # End loop if all squares are checked
    lw $t5, 0($t1)                 # Load the current square offset into $t5

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
    sw $t2, 0($a1)          # Paint the square

update_index:
    addiu $t1, $t1, 4       # Move to the next element in the array
    addiu $t4, $t4, 1       # Increment the index counter
    j loop_squares          # Jump back to iterate over the next square

end_loop:
    # Add logic here to continue after the loop

li $t2, 0x222831 # Red color for painting squares 0x222831
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
    j loop_squares2         # Jump back to iterate over the next square

end_loop2:
    lw $t0, ADDR_DSPL
    li $t1, 0xFFEDD8 	# $t1 stores the red colour code
    sw $t1, 0($t0) 		# paint the first pixle of wall because for some reason its grey
jr $ra  

checkerboard_done:
    
# ----------------------------------------------------------------------------
# DRAW TRIMINO (L - Shape [Orange])
# ---------------------------------------------------------------------------- 
    li $s0, 24     # Top left pixel of the Tetrimino
    li $s1, 152    # Next pixel down
    li $s2, 280    # Next pixel down
    li $s3, 284    # Pixel to the right of the last one, making the 'L' shape

# ----------------------------------------------------------------------------
# REPAINT BLOCK
# ----------------------------------------------------------------------------      
jal paint_block
j done_paint 
paint_block: 

    lw $t0, ADDR_DSPL      # Load base address for the display
    li $t1, 0xFDA403       # Load t1 with the colour Orange
    
    add $s0, $s0, $t0
    add $s1, $s1, $t0
    add $s2, $s2, $t0
    add $s3, $s3, $t0

    sw $t1, 0($s0)    # Draw the block at the absolute address in $s0
    sw $t1, 0($s1)    # Draw the block at the absolute address in $s1
    sw $t1, 0($s2)    # Draw the block at the absolute address in $s2
    sw $t1, 0($s3)    # Draw the block at the absolute address in $s3
        
    sub $s0, $s0, $t0
    sub $s1, $s1, $t0
    sub $s2, $s2, $t0
    sub $s3, $s3, $t0
     
     jr $ra  

# ----------------------------------------------------------------------------
# START GAME (Jump to Game Loop)
# ----------------------------------------------------------------------------  
done_paint:
 j game_loop          # Jump to the game loop


##############################################################################
# IMPLEMENT CONTROLS (MILESTONE 2)
############################################################################## 
#------------  1a. Check if key has been pressed  ------------------------ 
game_loop:
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
    
   # Check for 'L' key
    li $t9, 108                   # ASCII code for 'L'
    beq $a0, $t9, Exit
    
    b game_loop


   #-----------------------  2a. Check for collisions  -------------------------



   #------------------  2b. Update locations (paddle, ball)  --------------------
   
   
   
   
   #---------------------------  Draw the screen  --------------------------------  


    
move_right: 
    jal checkerboard_repainter 
    
    addi $s0, $s0, 4  
    addi $s1, $s1, 4
    addi $s2, $s2, 4  
    addi $s3, $s3, 4
    
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0

find_collisson_right:
    beq $t2, $t1, check_collison_right # If index equals array length, check for match

    lw $t4, 0($t0)         # Load the current word from the array into $t4
   
    beq $t4, $s0, match_collision_right  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_right
    beq $t4, $s2, match_collision_right
    beq $t4, $s3, match_collision_right

    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_right               # Jump back to the start of the loop

match_collision_right:
    li $t5, 1              # Set match found flag
    j check_collison_right           

check_collison_right:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_right  # If match found, jump to collision
    j no_collision_right          # Otherwise, no collision

no_collision_right:
    jal paint_block
    j end_collison_right                 

found_collision_right:
    addi $s0, $s0, -4  
    addi $s1, $s1, -4
    addi $s2, $s2, -4  
    addi $s3, $s3, -4
    
    jal paint_block
    j end_collison_right                   

end_collison_right:
    j sleepy
    
    
move_left: 
    jal checkerboard_repainter 
    
    addi $s0, $s0, -4  
    addi $s1, $s1, -4
    addi $s2, $s2, -4  
    addi $s3, $s3, -4
    
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0

find_collisson_left:
    beq $t2, $t1, check_collison_left # If index equals array length, check for match

    lw $t4, 0($t0)         # Load the current word from the array into $t4
   
    beq $t4, $s0, match_collision_left  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_left
    beq $t4, $s2, match_collision_left
    beq $t4, $s3, match_collision_left

    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_left               # Jump back to the start of the loop

match_collision_left:
    li $t5, 1              # Set match found flag
    j check_collison_left           

check_collison_left:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_left  # If match found, jump to collision
    j no_collision_left          # Otherwise, no collision

no_collision_left:
    jal paint_block
    j end_collison_left                

found_collision_left:
    addi $s0, $s0, 4  
    addi $s1, $s1, 4
    addi $s2, $s2, 4  
    addi $s3, $s3, 4
    
    jal paint_block
    j end_collison_left                  

end_collison_left:
    j sleepy

       
move_down: 
    jal checkerboard_repainter 
    
    addi $s0, $s0, 128 
    addi $s1, $s1, 128
    addi $s2, $s2, 128 
    addi $s3, $s3, 128
    
    la $t0, walls          # Load the address of the words array into $t0
    lw $t1, num_walls      # Load the array length into $t1
    li $t2, 0              # Initialize index to 0 (for array iteration)
    li $t5, 0              # Initialize match found flag to 0

find_collisson_down:
    beq $t2, $t1, check_collison_down # If index equals array length, check for match

    lw $t4, 0($t0)         # Load the current word from the array into $t4
   
    beq $t4, $s0, match_collision_down  # Compare $t4 with $s0, $s1, $s2, $s3
    beq $t4, $s1, match_collision_down
    beq $t4, $s2, match_collision_down
    beq $t4, $s3, match_collision_down

    addi $t0, $t0, 4       # Move to the next word in the array
    addi $t2, $t2, 1       # Increment the index
    j find_collisson_down               # Jump back to the start of the loop

match_collision_down:
    li $t5, 1              # Set match found flag
    j check_collison_down           

check_collison_down:
    # Determine pixel location based on match
    beq $t5, 1, found_collision_down  # If match found, jump to collision
    j no_collision_down          # Otherwise, no collision

no_collision_down:
    jal paint_block
    j end_collison_down                

found_collision_down:
    addi $s0, $s0, -128  
    addi $s1, $s1, -128
    addi $s2, $s2, -128  
    addi $s3, $s3, -128
    
    jal paint_block
    j end_collison_down                  

end_collison_down:
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
    beq $t1, 0, wrap_around

    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update

    wrap_around:
    # Wrap around to 3 if it was 0
    li $t1, 3

    store_update:
    # Store the updated value back to rotation_state
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
    beq $t1, 0, wrap_around

    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update

    wrap_around:
    # Wrap around to 3 if it was 0
    li $t1, 3

    store_update:
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
    beq $t1, 0, wrap_around

    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update

    wrap_around:
    # Wrap around to 3 if it was 0
    li $t1, 3

    store_update:
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
    beq $t1, 0, wrap_around

    # If not 0, simply decrement rotation_state
    addi $t1, $t1, -1
    j store_update

    wrap_around:
    # Wrap around to 3 if it was 0
    li $t1, 3

    store_update:
    # Store the updated value back to rotation_state
    sw $t1, 0($t0)



    jal paint_block
    j end_collision_L_state_1

end_collision_L_state_1:
    j sleepy

    
    
    
    
    
    
    
    
    
    
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    

Exit:
li $v0, 10 # terminate the program gracefully
syscall











   
   
   

   #---------------------------  Sleep  --------------------------------
sleepy:
    # Perform the sleep syscall once at the end of the game loop iteration
    li $v0, 32                      # Set syscall number for sleep operation
    li $a0, 20                      # Set sleep duration in milliseconds
    syscall                         # Execute the syscall to sleep
    j game_loop                     # Jump back to the start of the game loop


    























    #5. Go back to 1
    b game_loop
