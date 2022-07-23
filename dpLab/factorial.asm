;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Program to find the factorial of a number
;;;;input range:- 1 to 8

data segment
m1 db 0ah, 0dh, "Enter a 1-digit number: $"
m2 db 0ah, 0dh, "Factorial of the entered number is: $"
m3 db 0ah, 0dh, "INVALID INPUT$"
num db 03h, 00h, 04h dup("$")
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

mov AH, 01h   ;;char stdin
int 21H

sub AL, 30h 
mov CL, AL
mov CH, 00h 
mov AL, 01h 
mov AH, 00h 
factLoop:   MUL CX
            loop factLoop

mov BX, AX  ;;bkp

LEA DX, m2   ;;display m2
call disp

mov AX, BX
call hex2Dec
jmp exit

printInvalid:   LEA DX, m3  ;;display m3
                call disp
                jmp exit

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

;;;converts hex value in AX to it's equivalent decimal value & print
;;similar to dec to hex conversion in dec no. system
;;continously dividing hex no. by '0a' & storing remainders
hex2Dec proc near
mov CX, 00h  ;;stack push count
mov BX, 10

myLoop1:    mov DX, 00h 
            div BX  ;;AX=AX/BX  ;;DX=rem.
            add DL, 30h 
            push DX  ;;pushing ascii of rem. obtained to stack
            inc CX 
            cmp AX, 0000h 
            jg myLoop1

;;pop & print remainders..
myLoop2:    pop BX
            mov DL, BL
            call charOut
            loop myLoop2
ret
endp

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

charOut proc near
mov AH, 02h 
int 21H
ret
endp

code ends
end START