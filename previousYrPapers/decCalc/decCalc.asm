;;single digit decimal calculator

data segment
m1 db 0ah, 0dh, "Enter a: $"
m2 db 0ah, 0dh, "Enter b: $"
m3 db 0ah, 0dh, "Enter operator (+,-,*,/) : $"
resMsg db 0ah, 0dh, "Result is: $"
invMsg db 0ah, 0dh, "INVALID OPERATOR$"
data ends

code segment
ASSUME CS:code, DS:data
START:  mov AX, data
        mov DS, AX

        LEA DX, m1  ;;display m1
        call disp
        call charReader
        sub AL, 30h
        mov BH, AL   ;;num1 in BH

        LEA DX, m2  ;;display m2
        call disp
        call charReader
        sub AL, 30h
        mov BL, AL   ;;num2 in BL

        LEA DX, m3  ;;display m3
        call disp
        call charReader  ;;oprt in AL

        ;;cmparing entered option
        cmp AL, '+'
        jz myAdd
        cmp AL, '-'
        jz mySub
        cmp AL, '*'
        jz myMult
        cmp AL, '/'
        jz myDiv
invInput:       LEA DX, invMsg
                call disp
                jmp exit
        
myAdd:  LEA DX, resMsg  ;;print resMsg
        call disp
        mov AL, BH
        add AL, BL
        DAA
        mov BH, AL
        call charPrinter
        jmp exit

mySub:  LEA DX, resMsg  ;;print resMsg
        call disp
        mov AL, BH
        sub AL, BL
        AAS
        mov BH, AL
        call charPrinter
        jmp exit

myMult: LEA DX, resMsg  ;;print resMsg
        call disp
        mov AL, BH
        mul BL
        AAM
        mov CX, 0004h 
        mov BH, AH
        rol BH, CL
        or BH, AL
        call charPrinter
        jmp exit

myDiv:  LEA DX, resMsg  ;;print resMsg
        call disp
        mov AH, 00h 
        mov AL, BH
        AAD
        div BL
        mov BH, AL
        call charPrinter
        jmp exit


exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

charReader proc near
mov AH, 01h   ;;char with echo reader
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