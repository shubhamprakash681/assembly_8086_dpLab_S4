;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Program to find the sum of 10 single digit
;;;;numbers entered through keyboard
;;;;Displaying ans in hex

data segment
m1 db 0ah, 0dh, "Enter 10 single digit numbers: $"
m2 db 0ah, 0dh, "Sum of entered number is: $"
num db 0bh, 00h, 0ch dup("$")
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

LEA BX, num + 2
mov CX, 000ah
mov AL, 00h  ;;sum store

myloop: mov DL, byte ptr[BX]
        sub DL, 30h
        add AL, DL
        inc BX
        loop myloop

mov BL, AL ;;;backup of the answer

LEA DX, m2  ;;display m2
call disp

;;;;to extract and display upper nibble of ans
mov AL, BL
Mov Cx,0004h
AND AL,0f0h              ;; mask lower half
ROR AL,CL
CMP AL,0Ah
        JC  makeasciinumeric
            ADD AL,07h

        makeasciinumeric:        ADD AL,30h

MOV DL,AL
mov AH, 02H
int 21H

;;;;to extract and display lower nibble of ans
mov AL, BL
AND AL,0fh   ;;mask upper half
CMP AL,0Ah
        JC  makeasciinumeric2
                ADD AL,07h
        makeasciinumeric2:        ADD AL,30h

MOV DL,AL
Mov AH,02h
INT 21h

MOV DL, 'h'  ;;to append 'h' in answer
Mov AH,02h
INT 21h

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START