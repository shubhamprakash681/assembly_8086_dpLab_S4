;;;check whether entered 16bit number is even or odd
;;;& display the no. of 1's & 0's in its binary equivalent
;;note:- ans in hex

data segment
m1 db 0ah, 0dh, "Enter a 4 decimal digits: $"
m2 db 0ah, 0dh, "'0' is present $"
m3 db 0ah, 0dh, "'1' is present $"
m4 db " times $"
evMsg db 0ah, 0dh, "EVEN NUMBER $"
odMsg db 0ah, 0dh, "ODD NUMBER $"
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

mov CX, 0004h 
mov BX, 0000h ;;storing num here
charRead:   mov AH, 01h 
            int 21H
            sub AL, 30h 
            add BL, AL
            cmp CL, 01h 
            je inExit
            push CX  ;;outer count bkp
            mov CL, 04h 
            shl BX, CL
            pop CX
            loop charRead
        inExit: mov DX, BX  ;;bkp

AND DL, 01h 
cmp DL, 00h 
je printEven
    printOdd:   LEA DX, odMsg
                call disp
                jmp bcdCount
printEven:  LEA DX, evMsg
            call disp
            jmp bcdCount

bcdCount:   mov DL, 00h  ;;zero count
            mov DH, 00h  ;;one count
            mov CX, 10h 
            myCountLop: RCR BX, 01h 
            jc incOne
            incZer: inc DL
                    jmp done
            incOne: inc DH
            done:   loop myCountLop

push DX   ;;ans bkp
push DX   ;;ans bkp

LEA DX, m3
call disp
pop DX
mov BH, DH  ;;disp one count
call numPrint
LEA DX, m4
call disp  

LEA DX, m2
call disp
pop DX
mov BH, DL   ;;disp zero count
call numPrint
LEA DX, m4
call disp 

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

numPrint proc near
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