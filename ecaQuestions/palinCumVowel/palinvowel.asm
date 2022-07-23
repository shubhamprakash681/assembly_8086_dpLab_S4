data segment  
str1 db 10 dup('$')
str2 db 10 dup('$')   
msg1 db 0ah,0dh,"Enter the string <max : 10 character>:$"
msg2 db 0ah,0dh,"Entered string is palindrome$" 
msg4 db 0ah,0dh,"Vowels present in the string:$"
msg3 db 0ah,0dh,"Entered string is not palindrome$"
vowels db "AEIOU"
data ends
code segment
assume cs:code, ds:data
start:mov ax,data
mov ds,ax
lea dx,msg1
mov ah,09h
int 21h
mov str1,15h
lea dx,str1 
mov ah,0ah
int 21h
mov cx,00h
lea si,str1+1
mov cl,[si]
mov bl,cl
add si,cx
lea di,str2
loop1:mov al,[si]
mov [di],al
dec si
inc di
loop loop1
mov cl,bl
lea si,str1+2
lea di,str2
loop3:mov al,[si]
mov ah,[di]
cmp ah,al
je loop2
lea dx,msg3
mov ah,09h
int 21h
jmp loop4
loop2:inc si
inc di
loop loop3
lea dx,msg2
mov ah,09h
int 21h 
loop4:lea dx,msg4
mov ah,09h
int 21h
mov bh,05h
lea di,vowels
loop8:lea si,str1
add si,02h
mov ah,[di]
mov cl,bl
loop7:mov al,[si]
cmp al,ah
je loop5 
xor ah,20h
cmp al,ah
jne loop6
loop5:mov dl,[di]
mov ah,02h
int 21h
jmp loop9
loop6:inc si
loop loop7
loop9:inc di
dec bh
jnz loop8
mov ah,4ch
int 21h
code ends
end start
