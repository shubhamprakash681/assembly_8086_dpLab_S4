;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;change the case of alphabets in a string entered through keyboard

data segment
m1 db 0ah, 0dh, "Enter a string $"
m2 db 0ah, 0dh, "Entered string is : $"
m3 db 0ah, 0dh, "Final string is : $"
invmsg db 0ah, 0dh, "Invalid string entered $"
str1 db 1fh, 00h, 20h dup("$")
str2 db 1fh dup("$")
data ends

code segment
ASSUME cs:code, DS:data
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

LEA DX, str1 +2  ;;original string display
mov AH, 09h
int 21h

lea SI, str1
inc si
mov cl, [si]
mov ch, 00h
inc si
lea di, str2
apple:  mov bl, byte ptr[SI]
        mov bh, bl  ;;backup

        cmp bl, 41h
        jb invalid

        mov bl, bh
        cmp bl, 5bh
        jb lwr

        mov bl, bh
        cmp bl,61h
	jb invalid

        mov bl, bh
        cmp bl,7bh
	jb upr

        lwr:    add bh, 20h
                mov byte ptr[DI], bh
                jmp inexit

        upr:    sub bh,20h
                mov byte ptr[DI], bh
                jmp inexit

inexit: inc si
        inc di
        loop apple


LEA DX, m3  ;;display m3
mov AH, 09h
int 21h

lea dx, str2
mov AH, 09h
int 21h
jmp exit

invalid:  lea dx, invmsg
          mov ah, 09h
          int 21h
          jmp exit

exit:   mov AH, 4ch
        int 21h
code ends
end START