data segment
num db 10 dup(00h)
msg1 db 0ah,0dh,"enter the no. between 0-99 :$"
msg2 db 0ah,0dh,"largest no.:$"
msg3 db 0ah,0dh,"second largest no.:$"
msg4 db 0ah,0dh,"ascending order:$" 
data ends
code segment
assume cs:code,ds:data
start:mov ax,data			
mov ds,ax				
lea dx,msg1				
mov ah,09h				
int 21h 
lea si,num				
mov bl,0ah				
abc:mov ah,01h		
      int 21h
      mov cl,04
      shl al,cl			 
      mov [si],al		 
      mov ah,01h		
      int 21h
      sub al,30h		
      add [si],al 		
      mov dl,0ah		
      mov ah,02h		 
      int 21h
      inc si			
      dec bl			
      jne abc		
      lea si,num		
      mov cx,00h		
      mov cl,09h		
     jkl:mov bl,cl		
     mov di,si			
     inc di			
     ghi:mov al,[si]	
      mov ah,[di]		 
      cmp al,ah		
      jnae def		 
      mov [si],ah		
      mov [di],al		
  def:inc di		
      dec bl			
      jnz ghi		
      inc si			
      loop jkl		
      lea dx,msg2
      mov ah,09h		
      int 21h
      call print			
      dec si			
      lea dx,msg3		
      mov ah,09h		
      int 21h
      call print			
      mov bl,0ah		
      lea dx,msg4		
      mov ah,09h		
      int 21h
      lea si,num		
      mno:call print		
      inc si			
      dec bl			
      jnz mno		
      mov ah,4ch		
      int 21h
                            
      print proc near
        mov dl,[si]
        and dl,0f0h
        mov cl,04h		
        ror dl,cl			
        add dl,30h		
        mov ah,02h		
        int 21h	
        mov dl,[si]		
        and dl,0fh		 
        add dl,30h
	mov ah,02h	
        int 21h
        mov dl,20h		
        mov ah,02h		
        int 21h
        ret
        print endp
     
code ends
end start
