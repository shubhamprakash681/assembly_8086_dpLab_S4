data segment
m1 db 0ah, 0dh, "Enter a 4-digit decimal number: $"
num db 05h, 00h, 06h dup("$")
m2 db 0ah, 0dh, "Binary equivalent of the entered number is:  $"
bin db 10h dup(30h), "$"
STR1 DB 20 DUP('$')
STR2 DB 20 DUP('$')
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA SI, STR1
MOV AX,100
MOV BH,00
MOV BL,2
L1:     DIV BL
        ADD AH,'0'
        MOV BYTE PTR[SI],AH
        MOV AH,00
        INC SI
        INC BH
        CMP AL,00
        JNE L1

        MOV CL,BH
        LEA SI,STR1
        LEA DI,STR2
        MOV CH,00
        ADD SI,CX
        DEC SI
L2:     MOV AH,BYTE PTR[SI]
        MOV BYTE PTR[DI],AH
        DEC SI
        INC DI
        LOOP L2

LEA DX, STR2
mov AH, 09H
int 21h

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START