;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084
;;;;Decimal to binary converter

data segment 
m1 db 0ah, 0dh, "Enter a 4-digit number in decimal: $"
m2 db 0ah, 0dh, "Entered number is: $"
m3 db 0ah, 0dh, "INVALID INPUT $"
m4 db 0ah, 0dh, "Binary equivalent:- $"
bool db 00h 
num db 05h, 00h, 06h dup("$")
res db 14h dup("$")

data ends 

code segment
ASSUME CS:code, DS:data
START:  mov AX, data
        mov DS, AX

LEA DX, m1  ;;display m1
call disp

LEA DX, num  ;;string i/p
mov AH, 0Ah
int 21h

LEA DX, m2  ;;display m2
call disp

LEA DX, num + 2  ;;displaying entered number
call disp

LEA SI, num + 1
mov CH, 00h 
mov CL, [SI]
cmp CL, 04
jne printInvalid
checkLoop:      inc SI    ;;loop to check whether all entered characters are digits or not
                mov AL, byte ptr[SI]
                cmp AL, 30h 
                jb printInvalid
                cmp AL, 39h 
                ja printInvalid
                loop checkLoop



LEA DX, m4
call disp

;;converting entered decimal to hex
;;1234d = (1*1000 + 2*100 + 3*10 + 4)h
;;doing this b/c input number was in dec
;;since all calc. are done in hex
;;so it will update the answer in hex.....
decInp2Hex:     LEA SI, num + 2  
                mov BX, 0000h  ;;storing converted hex here
                mov CL, 04h 
                mov CH, 00h 

                mov AX, 0000h 
                mov AL, [SI]
                sub AL, 30h 
                mov DX, 1000
                mul DX
                mov BX, AX
                inc SI

                mov AX, 0000h 
                mov AL, [SI]
                sub AL, 30h 
                mov DX, 100
                mul DX
                add BX, AX
                inc SI

                mov AX, 0000h 
                mov AL, [SI]
                sub AL, 30h 
                mov DX, 10
                mul DX
                add BX, AX
                inc SI

                mov AX, 0000h 
                mov AL, [SI]
                sub AL, 30h 
                add BX, AX
                inc SI
                ;;;prev loop over

;;hex to bin conversion
hex2Bin:        mov AX, BX  
                LEA SI, res
                mov CX,0000h
                mov BX, 0002h
                lb1:    mov DX, 0000h 
                        DIV BX
                        add DL, 30h   ;;remainder to ASCII
                        push DX  ;;pushing each byte to stack
                        inc CX  ;;using cx as a counter to use while popping out
                        cmp AX, 0001h   ;;last quotient is either 1 or 0
                        jg lb1  ;;jmp on greater

                add AL, 30h 
                mov [SI], AL
                lb2:    pop AX
                        inc SI
                        mov [SI], AL
                        loop lb2


LEA DX, res   ;;display ans
call disp
jmp exit

printInvalid:   LEA DX, m3  ;;display m3
                call disp
                jmp exit

exit:   mov AH, 4ch  ;;terminate pgm
        int 21h

disp proc near
mov AH, 09h    ;;;display string
int 21h
ret
endp

code ends
end START