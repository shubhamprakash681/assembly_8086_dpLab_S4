;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Decimal to binary converter

data segment
m1 db 0ah, 0dh, "Enter a 4-digit decimal number: $"
num db 05h, 00h, 06h dup("$")
m2 db 0ah, 0dh, "Binary equivalent of the entered number is:  $"
revBin db 20 dup("$")
bin db 20 dup("$")
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, num  ;;string i/p
mov AH, 0Ah
int 21h

LEA DX, m2  ;;display m2
call disp

LEA SI, num + 2
mov CX, 0004h
mov AX, 0000h

;;loop to load entered number into AX
myLoop: push CX  ;;pushing up outer CX
        mov CL, 04h
        mov BH, byte ptr[SI]
        sub BH, 30h
        or AL, BH
        rol AX, CL
        inc SI
        pop CX   ;;poping up outer CX
        loop myLoop

    mov CL, 04h 
    ror AX, CL  ;;b/c rotated left extra 1 time

LEA SI, revBin
MOV BH,00
MOV BL,2
L1:DIV BL
    ADD AH,'0'
    MOV BYTE PTR[SI],AH
    MOV AH,00
    INC SI
    INC BH
    CMP AL,00
    JNE L1

    MOV CL,BH
    LEA SI,revBin
    LEA DI,bin
    MOV CH,00
    ADD SI,CX
    DEC SI

L2:MOV AH,BYTE PTR[SI]
    MOV BYTE PTR[DI],AH
    DEC SI
    INC DI
    LOOP L2

LEA DX, bin  ;;display answer tring
call disp

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START