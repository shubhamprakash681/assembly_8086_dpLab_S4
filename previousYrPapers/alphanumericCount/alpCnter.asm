;;pgm. to count no. of alphabets & numerals in alphanumeric chracter entered

data segment
m1 db 0ah, 0dh, "Enter an alphanumeric string: $"
str db 1fh, 00h, 20h dup("$") 
m2 db 0ah, 0dh, "No. of alphabets: $"
m3 db 0ah, 0dh, "No. of numerals: $"
invMsg db 0ah, 0dh, "INVALID characters present$"
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, str  ;;string input
mov AH, 0ah
int 21h 

mov BH, 00h  ;;numCount
mov BL, 00h  ;;alpCount
LEA SI, str + 1
mov CL, byte ptr[SI]
mov CH, 00h 
myLoop: inc SI
        mov DH, byte ptr[SI]
        cmp DH, 30h 
            jb printInvalid
        cmp DH, 39h
            jbe  incNumCount
        cmp DH, 41h 
            jb printInvalid
        cmp DH, 5ah 
            jbe incAlpCount
        cmp DH, 61h 
            jb printInvalid
        cmp DH, 7ah 
            jbe incAlpCount
        ja printInvalid

    incNumCount:    inc BH
                    jmp continue

    incAlpCount:    inc BL
                    jmp continue

    continue:   loop myLoop

LEA DX, m3  ;;display m3
call disp
call numPrinter
mov DL, 'h'  ;;;to append 'h' to answer
mov AH, 02h 
int 21h

LEA DX, m2  ;;display m2
call disp
mov BH, BL
call numPrinter

mov DL, 'h'  ;;;to append 'h' to answer
mov AH, 02h 
int 21h
jmp exit  

printInvalid:   LEA DX, invMsg
                call disp
                jmp exit

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

numPrinter proc near
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

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START