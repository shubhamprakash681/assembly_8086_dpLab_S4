data segment
m1 db 0ah, 0dh, "Enter the string $"
m2 db 0ah, 0dh, "Reversed string is $"
epmsg db 0ah, 0dh, "EVEN parity $"
opmsg db 0ah, 0dh, "ODD parity $"
str1 db 1fh, 00h, 20h dup("$")
str2 db 1fh dup("$")
data ends

code segment
ASSUME CS:code, DS:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, str1  ;;string i/p
mov AH, 0Ah
int 21h

LEA DX, m2  ;;display m2
call disp

LEA si, str1 ;;source string
LEA di, str2 ;;dest string

inc SI  ;;now pointing at the actual length of entered string
mov cl, [SI] 
mov ch, 00h
add si, cx ;;now pointing at last char

mov BL, 00h ;;parity Counter
mov BH, 31h
apple:  MOV DH, BYTE PTR[SI]
        MOV BYTE PTR[DI], DH
        cmp DH, BH
        jnz continue
        inc BL
    continue:   dec SI
                inc DI
loop apple

lea DX, str2  ;;display str2
call disp

AND BL, 01h 
cmp BL, 01h
jz oddPar
    evePar: LEA DX, epmsg
            call disp
            jmp exit

    oddPar: LEA DX, opmsg
            call disp
            jmp exit

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START