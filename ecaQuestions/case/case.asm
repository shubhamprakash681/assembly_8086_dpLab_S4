data segment
    string db 50,52 dup('$')
    msg1 db 0ah,0dh,"Enter the string: $"
    msg2 db 0ah,0dh,"Enter 0 for upper case ,1 for lower case ,2 for title case , 3 for toggle CaSe:$" 
    msg3 db 0ah,0dh,"UPPER CASE:$"
    msg4 db 0ah,0dh,"lower case:$"
    msg5 db 0ah,0dh,"Title Case:$"
    msg6 db 0ah,0dh,"toggle CaSe:$"
    msg7 db 0ah,0dh,"invalid input$"
    value dw 415ah
data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data			;initialize data segment
    mov ds,ax
    lea dx,msg1			;load effective address of msg1 to DX register
    mov ah,09h			;print the string in msg1
    int 21h
    lea dx,string			;load effective address of string to DX register
    mov ah,0ah			;read string from keyboard
    int 21h
    mov cx,00h			;CX =00h
    mov bx,00h 			;BX = 00h
    
p6:lea dx,msg2			;load effective address of msg2 to DX register
    mov ah,09h			;print the string in msg2
    int 21h
    mov ah,01h			;read number from keyboard
    int 21h
    cmp al,30h			;compare value in AL with 30h
    jne p1				;jump if ZF = 0 to p1
    lea si,value			;load effective address of value to SI register
    mov ax,617ah			;AX = 617ah(61h � ascii of  �a� ,7ah � ascii of  �z�)
    mov [si],ax			;copy the value in AX to address in SI register
    lea dx,msg3			;load effective address of msg3 to DX register
    mov ah,09h			;print the string in msg3
    int 21h
    call lowerorupper		;call lowerorupper subprogram
    jmp p5				;jump directly to p5
    
p1:cmp al,31h			;compare value in AL with 31h
    jne p2				;jump if ZF = 0 to p2
    lea dx,msg4			;load effective address of msg4 to DX register
    mov ah,09h			;print the string in msg4
    int 21h
    call lowerorupper		;call lowerorupper subprogram
    jmp p5 				;jump directly to p5
    
p2:cmp al,32h			;compare value in AL with 32h
    jne p3				;jump if ZF = 0 to p3
    lea dx,msg5			;load effective address of msg5 to DX register
    mov ah,09h			;print the string in msg5
    int 21h
    call lowerorupper 		;call lowerorupper subprogram
    call titlecase			;call titlecase subprogram
    jmp p5 				;jump directly to p5
    
p3:cmp al,33h			;compare value in AL with 33h   
    jne p4				;jump if ZF = 0 to p4
    lea dx,msg6			;load effective address of msg6 to DX register
    mov ah,09h			;print the string in msg6
    int 21h 
    call toggle				;call toggle subprogram
    jmp p5				;jump directly to p5
     
    p4:lea dx,msg7			;load effective address of msg7 to DX register
    mov ah,09h			;print the string in msg7
    int 21h
    jmp p6				;jump directly to p6
    
p5:lea dx,string+2			;load effective address of string + 2 to DX register
      mov ah,09h			;print the string in string +2 
      int 21h
      mov ah,4ch			;return the control back to operating system
      int 21h   
      
    lowerorupper proc near 
        lea si,string			;load effective address of string to SI register
        add si,02h			;SI = address in SI + 2
        mov bx,value		;BX = value in value(DS)
 subp1of3:mov al,[si]	;AL = value in address saved in SI register
        cmp al,24h		;compare value in AL with 24h
        je subp1of1		;jump if ZF = 1 to subp10f1
        cmp al,bh		;compare value in AL and BH register
        jnae subp1of2		;jump to subp10f2 if AL is not above or equal to BH
        cmp al,bl		;compare value in AL and BL register
        ja subp1of2		;jump to subp1of2 if value in AL is above BH
        xor al,20h		;do EXOR  operation with AL and 20h
        mov [si],al		;copy the value in AL to address in SI register
       subp1of2:inc si		;increment SI register
       jmp subp1of3  		;jump directly to subp10f3
       subp1of1:ret		
     lowerorupper endp 	
    
    titlecase proc near	
         lea si,string		;load effective address of string to SI register
         add si,02h		;SI = address in SI + 2
         mov al,[si]		;AL = value in address saved in SI register
         xor al,20h		;do EXOR operation with AL with 20h 
         mov [si],al		;copy value in AL to address in SI register
         inc si			;increment SI register
subp2of3:mov al,[si]		;AL = value in address saved in SI register
         cmp al,20h			;compare value in AL with 20h
         jne subp2of1			;jump if ZF = 0 to subp20f1
         inc si				;increment SI register
         mov al,[si]			;AL = value in address saved in SI register
         xor al,20h			;do EXOR operation with AL and 20h
         mov [si],al 			;copy the value in AL to address in SI register
subp2of1:cmp al,24h		;compare value AL with 24h
         je subp2of2			;jump if ZF = 1 to subp20f2
         inc si				;increment Si register
         jmp subp2of3			;jump directly to subp20f3
subp2of2:ret 			
    titlecase endp    
    
    toggle proc near
        lea si,string		;load effective address of string to SI register
        add si,02h		;SI = address in SI + 02h
        mov cl,string+1	;CL = value in address string + 1
subp3of2:mov al,[si]	;AL = value in address saved in SI register
        cmp al,20h		;compare value in AL with 20h
        je subp3of1		;jump if ZF  = 1 to sub3of1
        xor al,20h		;do EXOR operation with AL and 20h
        mov [si],al		;copy value in AL to address in SI register
 subp3of1:inc si		;increment SI register
        loop subp3of2 	;loop to subp3of2 if CX is not equal to 0000
        ret
    toggle endp 
    
    code ends
    end start
