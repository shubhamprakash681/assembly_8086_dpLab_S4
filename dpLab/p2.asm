;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084

data segment
msg db 0ah, 0dh, "Sum of 3 and 4 is: $"
data ends

code segment
assume cs:code, ds:data
start: mov AX,data
        mov DS, AX

LEA DX, msg
mov AH, 09h
INT 21h    ;;;;prints msg

mov BL, 03h   
add BL, 04h   ;;;numbers to be added are 03 + 04

add BL, 30h   ;;;result converted to ASCII
mov DL, BL
mov AH, 02h
INT 21h       ;;;prints result

mov AH, 4ch
INT 21h

code ends
end start