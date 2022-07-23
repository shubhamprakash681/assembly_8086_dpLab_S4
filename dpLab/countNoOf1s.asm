;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;program to count the number of ones 
;;;;in a binary number entered trough keyboard

data segment
m1 db 0ah, 0dh, "Enter a number in binary: $"
m2 db 0ah, 0dh, "'1' is present $"
m3 db " times $"
binNum db 1fh, 00h, 20h dup("$") 
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, binNum  ;;binary string i/p
mov AH, 0Ah
int 21h

mov BL, 31h
mov AL, 00h  ;;store counting here..
LEA si, binNum  ;;pointing to max length
inc si    ;;pointing to actual length of entered sting
mov cl, [SI] 
mov ch, 00h
inc si   ;;pointing to first char

myLoop: mov BH, byte ptr[SI]
        cmp BH, BL
        jnz noMatch 
        inc AL
        DAA 
        noMatch:inc si
                loop myLoop

mov BH, AL  ;;ans bkp
LEA DX, m2  ;;display m2
call disp

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

LEA DX, m3  ;;display m3
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