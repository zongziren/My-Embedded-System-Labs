    EXPORT compare
    AREA SUMMING, CODE, READONLY

compare
        mov     r3, r0
        mov     r4, r1
        mov     r7, #1          ;i=1      
loop
        cmp     r7, r2
        bgt     end 
        ldrb     r5, [r3]
        ldrb     r6, [r4]
        cmp     r5, r6    
        blt     end             ;s1<s2
        bgt     exchange        ;s1>s2
        add     r3, r3, #1
        add     r4, r4, #1
        add     r7, r7, #1
        b       loop



exchange
        mov     r7, #1          ;i=1
        mov     r3, r0
        mov     r4, r1

loop_exchange
        cmp     r7, r2
        bgt     end
        ldrb    r5, [r3]
        ldrb    r6, [r4]
        strb    r5, [r4]
        strb    r6, [r3]
        add     r3, r3, #1
        add     r4, r4, #1
        add     r7, r7, #1
        b       loop_exchange

end 
        mov     pc, lr
                END
