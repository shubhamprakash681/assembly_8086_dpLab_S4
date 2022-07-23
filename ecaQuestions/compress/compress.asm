data segment
    string db 20,22 dup('$')
    msg1 db 0ah,0dh,"enter the string :$"  
    msg2 db 0ah,0dh,"Compressed string:$"
    data ends
code segment
    assume cs:code,ds:data
    start:
    mov ax,data			
    mov ds,ax
    lea dx,msg1	
    mov ah,09h		
    int 21h
    lea dx,string 
    mov ah,0ah			
    int 21h
    lea si,string+2
    mov bl,01h	
    mov cx,00h		
    lea dx,msg2	
    mov ah,09h	
    int 21h
   loop4:mov al,[si]		
  loop5:mov ah,[si+1]	
    cmp al,ah			
    jne loop2			
    inc bl			
    inc si 			
    jmp loop5			
    loop2:mov dl,al		
   loop3:mov ah,02h	
    int 21h
    add bl,30h		
    mov dl,bl			
    mov ah,02h		
    int 21h 
    inc si			
    mov bl,01h		
    mov al,[si]			
    cmp al,24h		
    jne loop4			
    mov ah,4ch		
    int 21h   
    code ends
    end start

