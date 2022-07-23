;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Program to find whether a string is palindrome or not

data segment
m1 db 0ah, 0dh, "Enter the string: $"
m2 db 0ah, 0dh, "Entered string is PALINDROME$"
m3 db 0ah, 0dh, "Entered string is NOT PALINDROME$"
str1 db 1fh, 00h, 20h dup("$")
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

LEA si, str1 ;;source string
LEA di, str1 ;;dest string

inc SI  ;;now pointing at the actual length of entered string
inc DI
mov cl, [SI] 
mov ch, 00h
inc SI  ;;;pointing at first char
;inc DI
add DI, CX ;;now pointing at last char

;;alg to check palin or not
mov AX, CX  
mov BL, 02h
div BL  ;;AL = AX/operand(BL)
mov CL, AL 
mov CH, 00h

    apple:  mov BH, byte ptr[SI]
            mov BL, byte ptr[DI]
            cmp BH, BL
            jnz npld
        loop apple

    LEA DX, m2
    call disp
    jmp exit

npld:    LEA DX, m3
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