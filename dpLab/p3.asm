;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084

data segment
msg1 db 0ah, 0dh, "Enter two Numbers: $"
msg2 db 0ah, 0dh, "Sum is: $"
data ends

code segment
assume cs:code, ds:data
start: mov AX,data
        mov DS, AX

LEA DX, msg1
mov AH, 09h
INT 21h    ;;;;prints msg1

mov AH, 01h
INT 21h       ;;;input num1
mov BL, AL    ;;;num1 copied to BL

mov AH, 01h
INT 21h       ;;;input num2
add BL, AL    ;;;num1 + num2

LEA DX, msg2
mov AH, 09h
INT 21h    ;;;;prints msg2

sub BL, 30h   ;;;result converted to ASCII
mov DL, BL
mov AH, 02h
INT 21h       ;;;prints result

mov AH, 4ch
INT 21h

code ends
end start