;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Program to add two BCD numbers and display sum
;;;;(sum is less than 99)

data segment
m1 db 0ah, 0dh, "Enter decimal1: $"
m2 db 0ah, 0dh, "Enter decimal2: $"
m3 db 0ah, 0dh, "Sum of entered number is: $"
num1 db 03h, 00h, 04h dup("$")
num2 db 03h, 00h, 04h dup("$")
num db 00h, 00h, 24h
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp
LEA DX, num1  ;;num1 i/p
mov AH, 0Ah
int 21H

LEA DX, m1  ;;display m2
call disp
LEA DX, num2  ;;num2 i/p
mov AH, 0Ah
int 21H

LEA DI, num
mov CX, 0002h
LEA SI, num1
add SI, 0002h
ascii2dec:  mov BL, byte ptr[SI]
            sub BL, 30h   ;;ascii to digit
            rol BL, 04h   ;;to upper nibble
            mov BH, BL    ;;local backup
            inc SI        
            mov BL, byte ptr[SI]
            sub BL, 30h   ;;ascii to digit
            OR BH, BL     ;;append lower half to upper half
            mov byte ptr[DI], BH

            inc DI   ;;to sec. pos. in num
            LEA SI, num2
            add SI, 0002h
        loop ascii2dec

mov CX, 0002h
mov BX, 0000h
mov AL, 00h 
addition:   add AL, num[BX]
            DAA      ;;decimal adjust after addition
            inc BX
        loop addition

mov BL, AL ;;;backup of the answer

LEA DX, m3  ;;display m3
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

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START