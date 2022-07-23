data segment
    num db 10 dup(00h) 
    result db 00h
    msg1 db 0ah,0dh,"Enter your number:$"  
    msg2 db 0ah,0dh,"Sum:$"
    msg3 db 0ah,0dh,"Sum is divisible by 7$"
    msg4 db 0ah,0dh,"Sum is not divisible by 7$"
    data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data			;initialize data segment
    mov ds,ax
    lea dx,msg1			;load effective address of msg1 to DX register
    mov ah,09h			;print the string in msg1
    int 21h
    mov cx,00h			;CX = 00h
    mov cl,0ah    			;CL = 0Ah
    lea si,num				;load effective address of num to SI register
    loop1:mov ah,01h		;read number from keyboard
    int 21h
    sub al,30h				;AL = value  in AL - 30h
    mov [si],al				;copy value in AL to the address in SI register
    inc si				;increment SI register
    loop loop1			;loop to loop1 if CX is not equal to 0000
    lea si,num				;load effective address of num to SI register
    mov cl,0ah			;CL = 0Ah
    mov bh,00h			;BH = 00h
    loop2:mov al,result		;AL = value in result
    mov bl,[si] 			;BL = value in address saved in SI register
    add al,bl				;AL = value in AL + value in BL
    daa					;decimal adjust after addition
    inc si				;increment SI register
    mov result,al			;copy value in AL to result
    loop loop2			;loop to loop1 if CX is not equal to 0000
    lea dx,msg2			;load effective address of msg2 to DX register
    mov ah,09h			;print the string in msg2
    int 21h
    mov dl,result			;DL = value in result
    and dl,0f0h		;do AND operation with DL and 0F0h
    mov cl,04h		;CL = 04h
    ror dl,cl			;rotate DL right without through carry by value in CL
    add dl,30h		;DL = value in DL + 30h
    mov ah,02h		;print the number
    int 21h	
    mov dl,result		;DL = value in result
    and dl,0fh			;do AND operation with DL and 0Fh
    add dl,30h		;DL = value in DL + 30h
    mov ah,02h		;print the number
    int 21h
    mov ah,00h		;AH = 00h
    mov al,result		;AL = value in result
    mov cl,04h		;CL = 04h
    rol ax,cl  			;rotate AX to left without through carry by value in CL
    shr al,cl 			;shift AL to right by value in CL
    mov bl,07h		;BL = 07h
    aad				;ASCII adjust before division
    div bl			;divide AL with BL
    lea dx,msg3		;load effective address of msg3 to DX register
    cmp ah,01h		;compare AH with 01h
    jnae loop3		;jump to loop3 if value in AH is not above or equal to 1
    lea dx,msg4			;load effective address of msg4 to DX register
    loop3:mov ah,09h		;print the string
    int 21h
    mov ah,4ch			;return control back to operating system
    int 21h   
    code ends
    end start
