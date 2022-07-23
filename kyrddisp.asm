
DATA SEGMENT
keys DB  0Ah dup (00h)
DATA ENDS


CODE SEGMENT
ASSUME CS: CODE,DS: DATA
START: MOV AX, DATA
MOV DS, AX


MOV DS, AX
MOV CX,000Ah
Mov BX,0000h


Apple: CALL keyrd
              mov keys[bx],AL
              inc bx
              LOOP Apple  ;; Reading N keys

 

MOV Cx,0005h
MOV BX,0000h
 orange:mov AL,keys[BX]
                 add AL, keys[BX+1]
              CALL hex2ascii
	INC BX
	INC BX
LOOP orange               ;;; displaying the pairwise sum
          

MOV AH,4ch
INT 21h                        ;;Exit to DOS

;;;;;; inserting Procedures  
keyrd  PROC NEAR
            mov ah,01h
            int 21h      ; gets key pressed in ASCII
           cmp AL,3Ah
           jc   ASCII2hex
                		AND AL, 0DFh ;; Why???
                		 sub AL,07h
         ASCII2hex:          sub AL,30h
                                          RET
keyrd  ENDP   
                 
hex2ascii  PROC NEAR
; assuming that the byte in AL is to be converted to ascii values
PUSH CX
PUSH BX
Mov BL,AL ;; bcak up
Mov CX,04h
AND AL,0f0h              ;; mask lower half
ROR AL,CL
CMP AL,0Ah
	                    JC  makeasciinumeric
	                          ADD AL,07h
makeasciinumeric:        ADD AL,30h

MOV DL,AL         ; required to print a charater on display
Mov AH,02h
INT 21h
 ; now to extract and display lower nibble of sum
   
MOV  AL,BL
AND AL,0fh   ; mask upper half
CMP AL,0Ah
	                    JC  makeasciinumeric2
	                          ADD AL,07h
makeasciinumeric2:        ADD AL,30h

MOV DL,AL         ; required to print a charater on display
Mov AH,02h
INT 21h
POP BX
POP CX
RET
  hex2ascii  ENDP
            

CODE ENDS
END START
                            ;OUTPUT: ????