DATA SEGMENT
M1 DB 0AH, 0DH,"ENTER THE SIGNAL $"
M2 DB 0AH, 0DH,"AFTER DOWNSAMPLING SIGNAL IS $" 
keys DB 0Ah dup (00h) 
Msg2 db 0ah, 0dh, "The final sum is $"
N1 DB 1FH, 00h, 20H DUP("$")
N2 DB 20H DUP ("$")
sum db 00h
DATA ENDS

CODE SEGMENT
ASSUME CS: CODE,DS: DATA
START: MOV AX, DATA
MOV DS, AX
LEA DX, M1
MOV AH, 09H
INT 21H
LEA DX, N1
MOV AH, 0AH
INT 21H
LEA DX, M2
MOV AH, 09H
INT 21H
LEA SI, N1
LEA DI, N2
INC SI
MOV CL, [SI]
INC SI
MOV CH, 00H
Apple: MOV DH, BYTE PTR[SI]
  MOV BYTE PTR[DI], DH
  INC SI
  INC SI
  INC DI
   Loop Apple
LEA DX, N2
MOV AH, 09H
INT 21H  
;;ADDITION
MOV AX,0000H
MOV CX,0005h
Mov BX,0000h 

MOV DI,0000H
LEA DI,N2

mov Bl, 00h 
santara: MOV AL,BYTE PTR[DI]  
          SUB AL,30H
          ADD BL,AL
    INC DI
    LOOP santara
    MOV AX,0000H
    DISPLAY : MOV AL,BL
                mov BH, AL  ;;bkp
  
  LEA DX, Msg2
  mov AH, 09h  
  int 21h 

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

mov AH,4CH
INT 21H 
 CODE ENDS
 END START