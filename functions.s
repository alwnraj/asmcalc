.section .text
    .global add
add:
    ADD r0, r0, r1      // r0 = r0 + r1
    bx lr               // Return

.section .text
    .global subtract
subtract:
    SUB r0, r0, r1      // r0 = r0 - r1
    bx lr               // Return

.section .text
    .global multiply
multiply:
    MUL r0, r0, r1      // r0 = r0 * r1
    bx lr               // Return

.section .text
    .global divide
divide:
    push {r4, r5, r6, lr}   // Save registers
    mov r4, r0              // r4 = dividend
    mov r5, r1              // r5 = divisor
    

    // Initialize quotient and remainder as zero
    mov r0, #0              // r0 = quotient
    mov r1, #0              // r1 = remainder
    mov r3, #0              // r3 = controls the sign flags

    // Handle negative dividend
    cmp r4, #0				// Compare divident with zero
    bge dividend_positive   // If dividend is greater than or equal to
							// zero then skip
    neg r4, r4              // Make dividend positive
    add r3, r3, #1          // Increment the sign flag

dividend_positive:
    // Handle negative divisor
    cmp r5, #0				// Compare divisor by zero
    bge divisor_positive    // If divisor is greater than or equal to
							// zero then skip
    neg r5, r5              // Make divisor positive
    add r3, r3, #1          // Toggle the sign flag

divisor_positive:
    // Perform division by repeated subtraction
division_loop:
    cmp r4, r5              // Compare dividend and divisor
    blt division_done       // If dividend is less than divisor,branch  
							// to division_done 
    sub r4, r4, r5          // Subtract divisor from dividend
    add r0, r0, #1          // Increment quotient
    b division_loop         // Repeat loop

division_done:
    mov r1, r4              // r1 is the remaining dividend

    // Applies correct sign to the quotient by checking if num is even 
    //or odd. Even is positive and odd is negative.
    ands r6, r3, #1         // Check if sign flag is odd
    beq result_positive     // If even, quotient is positive
    neg r0, r0              // Make the quotient negative

result_positive:
    pop {r4, r5, r6, lr}    // Restore registers
    bx lr                   // Return quotient in r0 and remainder in r1
