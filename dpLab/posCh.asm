;;;;Shubham Prakash
;;;;EC - B
;;;;Roll: 36
;;;;Reg No.: 20319084

data segment
list db "QWERTYUIOPASDFGHJKLZXCVBNM"  ;;;prestored string
pr db "CHARACTER PRESENT AT $"
notp db "CHARACTER NOT PRESENT$"
data ends

code segment
assume cs:code, ds:data, es:data
start: mov AX, data
        mov DS, AX
        mov ES, AX

        LEA DI, list + 19h
        std    ;;;to go from right to left
        mov CX, 001Ah  ;;;length of string
        mov AL, 'X'  ;;;;character to be scanned

        repne scasb
        jz msg
        LEA DX, notp
        jmp disp

msg:    LEA dx, pr
        

disp:   mov AH, 09H
        int 21H
        jz dispval
        
dispval: mov AL, CL
        mov BL, AL ;;;backup of the answer

        ;;;;to extract and display upper nibble of ans
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
        mov AL, BL
        AND AL,0fh   ;;mask upper half
        CMP AL,0Ah
                JC  makeasciinumeric2
                        ADD AL,07h
                makeasciinumeric2:        ADD AL,30h

        MOV DL,AL
        Mov AH,02h
        INT 21h

        mov AH, 4ch
        int 21H
code ends
end start