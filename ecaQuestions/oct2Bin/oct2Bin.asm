data segment 
    msg1 db 0ah,0dh,"enter the three digit octal number:$"
    msg2 db 0ah,0dh,"binary equivalent is:$"
    data ends
code segment
    assume cs:code, ds:data
    start:
    mov ax,data   
    mov ds,ax
    lea dx,msg1   
    mov ah,09h   
    int 21h
    mov dl,03h   
    mov bx,00h
    mov cx,00h   
loop1:mov ah,01h   
    int 21h
    mov cl,03h   
    shl bx,cl    
    sub al,30h   
    add bl,al   
    dec dl    
    jnz loop1   
    mov cl,07h  
    rol bx,cl   
    lea dx,msg2  
    mov ah,09h  
    int 21h
    mov cl,09h  
    loop3:mov dl,30h 
    rol bx,01h    
    jnc loop2   
    mov dl,31h  
    loop2:mov ah,02h 
    int 21h
    loop loop3
    mov ah,4ch  
    int 21h 
    code ends
    end start