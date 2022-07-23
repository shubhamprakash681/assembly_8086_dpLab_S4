;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;change the case of an alphabet entered through keyboard

data segment
m1 db 0ah, 0dh, "Enter an alphabet $"
m2 db 0ah, 0dh, "Final alphabet is : $"
invmsg db 0ah, 0dh, "Invalid character entered $"
data ends

code segment
ASSUME cs:code, DS:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
mov AH, 09h
int 21h

mov AH, 01h  ;;i/p taken
int 21h
mov cl, al  ;;backup
mov ch,cl

cmp cl, 41h
jb invalid

mov cl, ch
cmp cl, 5bh
jb lwr

mov cl, ch
cmp cl,61h
jb invalid

mov cl, ch
cmp cl,7bh
jb upr

lwr:    add ch, 20h
        jmp disp

upr:    sub ch,20h
        jmp disp

disp:   LEA DX, m2  ;;display m2
        mov AH, 09h
        int 21h

        mov dl, ch
        mov ah, 02h
        int 21h
        jmp exit

invalid:  lea dx, invmsg
          mov ah, 09h
          int 21h

exit:   mov AH, 4ch
        int 21h
code ends
end START