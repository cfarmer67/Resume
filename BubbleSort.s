@ Chase Farmer
.data                               @ Data Section
array:  .word 1                     @ Array varriable with values
        .word 32
        .word 10
        .word 8
        .word 33

.text                               @ Instruction Section
.global bubbleSort

bubbleSort:
    stmfd sp!, {r0-r8, LR}          @ Push 
    ldr     r8, =array              @ Load Array into r8
    mov     r2, #5                  @ Array size = 5
    b       reset                   @ Brach to reset

reset:                              @ Reset counters 
    mov     r5, #0                  @ r5 is set to 0 (Current element Counter)
    mov     r7, #0                  @ r7 is set to 0 (# of swaps Counter)
    b       innerLoop               @ Branch to innerLoop

swpCheck:                           @ Swap Check (To know when we are done sorting) 
    cmp     r7, #0                  @ Compare r7 to 0 
    bgt     reset                   @ If r7 > 0 then Branch to reset 
    b       loadRegisters           @ Branch to loadRegisters

innerLoop:                          @ Inner Loop
    add     r6, r5, #1              @ add 1 to r5 and load it into r6 (Offset counter) 
    cmp     r2, r6                  @ Is r2 > r6 (Comparing the Array size to the Offset to find the end of the array)
    ble     swpCheck                @ If we are at the end of the array, check to see if any swaps were made
    ldr     r3, [r8, r5, lsl #2]    @ Load the Current element Value using lsl based on the current element position into R5 (array[j])
    ldr     r4, [r8, r6, lsl #2]    @ Load the Offset element Value using lsl based on the offset element position into R6 (array[j+1])
    cmp     r4, r3                  @ Is r4 > r3 (Compare Current value to Offset value)
    strlt   r4, [r8, r5, lsl #2]    @ If r4 > r3, Store the Current Value at Offset using lsl to move the values
    strlt   r3, [r8, r6, lsl #2]    @ If r4 > r3, Store the Offset Value at Current using lsl to move the values
    addlt   r7, r7, #1              @ If a swap was made add 1 to r7  
    mov     r5, r6                  @ move offset element position to current element position (moves us to the next element in the array)
    b       innerLoop               @ Branch back to innerLoop 

loadRegisters:
    mov     r5, #0                  @ r5 is set to 0 (Current element Counter)
    ldr     r0, [r8, r5, lsl #2]    @ Load the Current element Value using lsl based on the current element position into R5 (array[j])
    add     r5, r5, #1              @ Add 1 to r5 (Current element Counter)
    ldr     r1, [r8, r5, lsl #2]
    add     r5, r5, #1
    ldr     r2, [r8, r5, lsl #2]
    add     r5, r5, #1
    ldr     r3, [r8, r5, lsl #2]
    add     r5, r5, #1
    ldr     r4, [r8, r5, lsl #2]    @ Repeat all the way down to fill registers r0-r4 with the array in ascending order
    b       quit
    

quit:                               @ quit 
    ldmfd sp!, {r0-r8, PC}          @ Pop 
    bx lr