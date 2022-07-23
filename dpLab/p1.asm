;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084

data segment
msg db 0ah, 0dh, "My name is Shubham $"
data ends

code segment
assume cs:code, ds:data
start: mov AX,data
        mov DS,AX;

LEA DX,msg
mov AH, 09h
INT 21h

mov AH, 4ch
INT 21h

code ends
end start