;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Reversing a string entered through keyboard

data segment
m1 db 0ah, 0dh, "Enter the string $"
m2 db 0ah, 0dh, "Reversed string is $"
str1 db 1fh, 00h, 20h dup("$")
str2 db 1fh dup("$")
data ends

code segment
ASSUME CS:code, DS:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
mov AH, 09h
int 21h

LEA DX, str1  ;;string i/p
mov AH, 0Ah
int 21h

LEA DX, m2  ;;display m2
mov AH, 09h
int 21h

LEA si, str1 ;;source string
LEA di, str2 ;;dest string

inc SI  ;;now pointing at the actual length of entered string
mov cl, [SI] 
mov ch, 00h
add si, cx ;;now pointing at last char

apple: MOV DH, BYTE PTR[SI]
	   MOV BYTE PTR[DI], DH

       dec SI
       inc DI
loop apple

lea DX, str2  ;;display str2
mov AH, 09h
int 21h

mov AH, 4ch
int 21h
code ends
end START