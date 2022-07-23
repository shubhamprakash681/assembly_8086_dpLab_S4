data segment
msg1 db 0ah,0dh,"Enter the binary string of 8 bits :$"
msg2 db 0ah,0dh,"reverse of binary string is:$" 
msg3 db 0ah,0dh,"even parity$"
msg4 db 0ah,0dh,"odd parity$"
data ends
code segment
assume cs:code,ds:data		
start:mov ax,data			
mov ds,ax
lea dx,msg1				 
mov ah,09h				
int 21h
mov cx,00h
mov cl,08h				
mov bl,00h								
abc:mov ah,01h			
int 21h
shl bl,01h		
sub al,30h 			
add bl,al			
loop abc
lea dx,msg2			
mov ah,09h			
int 21h
mov cl,08h			
def:mov dl,30h		
ror bl,01h			
jnc ghi			
mov dl,31h			
ghi:mov ah,02h		
int 21h
loop def			
lea dx,msg3			
jp jkl			
lea dx,msg4			
jkl:mov ah,09h		
int 21h
mov ah,4ch			
int 21h
code ends
end start
