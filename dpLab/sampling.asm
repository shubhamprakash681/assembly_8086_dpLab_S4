;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Program to do up and down sampling of a  sequence  entered through keyboard

data segment
m1 db 0ah, 0dh, "Enter the signal: $"
m2 db 0ah, 0dh, "Actual signal is: $"
m3 db 0ah, 0dh, "After Downsampling signal is: $"
m4 db 0ah, 0dh, "After Upsampling signal is:  $"
str1 db 1fh, 00h, 20h dup("$")  ;;original string
str2 db 1fh dup("$")
str3 db 1fh dup("$")
data ends

code segment
ASSUME CS:code, DS:data, ES:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, str1  ;;string i/p
mov AH, 0Ah
int 21h

;;downsampling
LEA SI, str1
LEA DI, str2
inc SI  ;;pointing at string length
mov AL, [SI]
mov AH, 00h
mov BL, 02h
div BL   ;;AL = AX/operand(BL)
mov BL, AL ;;backup
cmp AH, 01h
    jz mthd2
        mov CL, BL  ;;;n=l/2 (for even)
        mov CH, 00h
        inc SI ;;pointing at 1st char
            call dslfn
        jmp res1 

    mthd2:  mov CL, BL
            inc CL   ;;;n=l/2 +1 (for odd)
            mov CH, 00h
            inc SI ;;pointing at 1st char
                call dslfn 

res1:   LEA DX, m2
        call disp
        LEA DX, str1 + 2
        call disp
        LEA DX, m3 
        call disp
        LEA DX, str2 
        call disp

;;upsampling
LEA SI, str1
LEA DI, str3
inc SI  ;;pointing at string length
mov CL, [SI]
mov CH, 00h
inc SI ;;pointing at 1st char
    usl:mov DH, byte ptr[SI]
        mov byte ptr[DI], DH
        inc DI 
        mov byte ptr[DI], DH
        inc DI
        mov byte ptr[DI], DH
        inc DI 
        inc SI 
        loop usl

LEA DX, m2
call disp
LEA DX, str1 + 2
call disp
LEA DX, m4
call disp
LEA DX, str3
call disp

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

dslfn proc near
dsl:mov DH, byte ptr[SI]
    mov byte ptr[DI], DH
    inc SI
    inc SI
    inc DI
loop dsl
ret
endp

code ends
end START