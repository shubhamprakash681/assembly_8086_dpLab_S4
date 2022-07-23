;;median of digits of mobile number arranged in ascending order

data segment
m1 db 0ah, 0dh, "Enter mobile no.: $"
m2 db 0ah, 0dh, "Median is: $"
m3 db 0ah, 0dh, "INVALID ENTRY$"
m4 db 0ah, 0dh, "Digits in Ascending order: $"
mobNum db 0bh, 00h, 0ch dup("$")
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, mobNum  ;;string i/p
mov AH, 0Ah
int 21h

LEA SI, mobNum + 1
mov BH, byte ptr[SI]   ;;no. of inputs
cmp BH, 0ah
jne invMsg   ;;;if less than 10 digits are entered

;;converting all entries to decimal
mov CX, 000ah
inc SI
ascii2Dec:  sub [si], 30h
            inc SI
            loop ascii2Dec

;;Bubble sort
mov CL, BH 
dec CL
mov CH, 00h 
mov BL, 01h  ;;outer counterNum
oLoop:  push CX
        mov CL, BH
        sub CL, BL

        LEA DI, mobNum + 2  ;;int i
        iLoop:  mov SI, DI
                inc SI  ;;int i+1
                mov DH, byte ptr[DI]
                mov DL, byte ptr[SI]
                cmp DH, DL
                jbe continue
                mov AL, DH  ;;int temp
                mov byte ptr[DI], DL
                mov byte ptr[SI], AL

                continue:   inc DI
                            loop iLoop
        pop CX
        inc BL
        loop oLoop
LEA DX, m4  ;;display m4
call disp
LEA SI, mobNum + 2
mov CX, 000ah
check:      mov DL, byte ptr[SI]
            add DL, 30h
            mov AH, 02H
            int 21h 
            inc SI
            loop check

;;median calculation
mov AL, 00h 
LEA SI, mobNum + 6
add AL, [SI]
LEA SI, mobNum + 7
add AL, [SI]
mov AH, 00h 
mov BL, 02h 
AAD 
div BL
mov BL, AH  ;;remainder backup
mov BH, AL  ;;final ans in BH

;;printing result
LEA DX, m2  ;;display m2
call disp
call charPrinter  ;;display ans stored in BH
mov DL, "."   ;;to print a dot(.)
mov AH, 02h 
int 21h 

;;to print decimal
cmp BL, 00h 
        jnz nonZero
        mov DL, BL 
        add DL, 30h 
        mov AH, 02h 
        int 21h 
        jmp exit

nonZero:        mov DL, BL
                add DL, 34h 
                mov AH, 02h 
                int 21h 
                jmp exit

invMsg: LEA DX, m3  ;;display m3
        call disp

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

charPrinter proc near
;;;;to extract and display upper nibble of ans
mov AL, BH
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
mov AL, BH
AND AL,0fh   ;;mask upper half
CMP AL,0Ah
        JC  makeasciinumeric2
                ADD AL,07h
        makeasciinumeric2:        ADD AL,30h

MOV DL,AL
Mov AH,02h
INT 21h
ret
endp

code ends
end START