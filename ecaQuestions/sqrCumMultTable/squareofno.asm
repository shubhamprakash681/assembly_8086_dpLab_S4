data segment  
num1 db 00h
result dw 00h   
msg1 db 0ah,0dh,"enter the number:$"
msg2 db 0ah,0dh,"square of the no. is:$"
msg3 db 0ah,0dh,"table:$" 
msg4 db "X$"
msg5 db "=$"
data ends
code segment
assume cs:code, ds:data
start:mov ax,data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov ah,01h
int 21h
sub al,30h
mov num1,al
mov bl,al  
mul bl
AAM 
add ax,3030h
mov bx,ax
lea dx,msg2
mov ah,09h
int 21h
mov dl,bh
mov ah,02h
int 21h
mov dl,bl
mov ah,02h 
int 21h 
lea dx,msg3
mov ah,09h
int 21h
mov bl,01h
loop2:mov al,num1
mul bl
AAM
add ax,3030h
mov result,ax
mov dl,num1
add dl,30h
mov ah,02h
int 21h
lea dx,msg4
mov ah,09h
int 21h
cmp bl,0ah
jne loop1
mov bl,10h
loop1:mov dl,bl
mov cl,04h
and dl,0f0h
ror dl,cl
add dl,30h
mov ah,02h
int 21h
mov dl,bl
and dl,0fh
add dl,30h
mov ah,02h
int 21h
lea dx,msg5
mov ah,09h
int 21h
mov ax,result
mov dl,ah
mov ah,02h
int 21h
mov ax,result
mov dl,al
mov ah,02h
int 21h
inc bl
cmp bl,11h 
mov dl,0ah
mov ah,02h
int 21h
jne loop2
mov ah,4ch
int 21h
code ends
end start