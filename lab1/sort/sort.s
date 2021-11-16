    EXPORT sort
    IMPORT compare
    AREA SUMMING, CODE, READONLY

sort
        STMFD   SP!, {R4-R5}
        ldr     r1, [r0]            ;r1=num
        ldr     r2, [r0,#4]         ;r2=len
        add     r3, r0, #8          ;将r3指向s二维数组

        mov     r4, #0
        sub     r4, r4, #1          ;i=-1   
        sub     r1, r1, #1          ;r1=num-1
        
loop1                               ;冒泡排序
        add     r4, r4, #1          ;i++
        cmp     r1, r4              
        ble     back                ;if num-1<=i 返回
        mov     r5, #0              ;j=0
        sub     r6, r1, r4          ;r6=num-1-i
        
loop2   
        cmp     r6, r5              ;if num-1-i<=j 跳出第一重循环
        ble     loop1

        STMFD   SP!,{R0-R6,lr}
        mul     r0, r2, r5
        add     r0, r0, r3          ;r0 指向第一个字符串
        add     r1, r0, r2          ;r1 指向第二个字符串
        bl      compare
        ldmfd   SP!,{R0-R6,lr}

        add     r5, r5, #1          ;j++
        b       loop2

back
        ldmfd   SP!,{R4-R5}
        mov     pc,lr
        END

