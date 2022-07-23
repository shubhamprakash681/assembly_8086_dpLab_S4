;;;uncompress input string

data segment
m1 db 0ah, 0dh, "Enter a string: $"
m2 db 0ah, 0dh, "Input string is: $"
m3 db 0ah, 0dh, "UNCOMPRESSED string is: $"
m4 db 0ah, 0dh, "INVALID INPUT$"
str db 1fh, 00h, 20h dup("&")
data ends

code segment
ASSUME CS:code, DS:data
START:  mov AX, data
        mov DS, AX

        LEA DX, m1  ;;display m1
        call disp

LEA DX, str  ;;string i/p
mov AH, 0Ah
int 21h

LEA SI, str + 1
mov AL, byte ptr[SI]
mov BL, AL  ;bkp
AND AL, 01h
cmp AL, 01h
jz printInvalid

LEA DX, m2
call disp

LEA SI, str + 1
mov CL, byte ptr[SI]
mov CH, 00h
inc SI
orgStr: mov DL, byte ptr[SI]
        call charPrint
        inc SI
        loop orgStr

LEA DX, m3
call disp

mov CL, BL
shr CL, 01h 
mov CH, 00h
LEA SI, str + 1
mainLoop:   inc SI
            mov DL, byte ptr[SI]
            inc SI
            push CX   ;;main loop counter backup
            mov CL, byte ptr[SI]
            sub CL, 30h
            mov CH, 00h 
            printLoop:  call charPrint
                        loop printLoop

            pop CX
            loop mainLoop
            jmp exit


printInvalid:   LEA DX, m4
                call disp 
                jmp exit

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

charPrint proc near
mov AH, 02h ;;char to stdout
int 21h 
ret
endp

code ends
end START