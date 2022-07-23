DATA SEGMENT
Inputkeyascii DB  00h,00h
Sum1 db 00h  ; 
DATA ENDS

CODE SEGMENT
ASSUME CS: CODE,DS: DATA
START: MOV AX, DATA
MOV DS, AX

 key1:mov ah,01h
            int 21h      ; key press1
    cmp AL,3Ah
    jc   numeric
   		AND AL, 0DFh ;; Why???
    		sub AL,07h
         numeric:   sub AL,30h
                             mov Inputkeyascii,AL      ; savethe extracted upper nibble 
 ;;; Repeat for second key
key2:mov ah,01h
           int 21h      ; key press2
          cmp AL,3Ah
    jc   numeric2
   		 AND AL, 0DFh ;; Why???
    		sub AL,07h
    numeric2:   sub AL,30h
                           mov Inputkeyascii+1,AL

add AL, Inputkeyascii ;; add nibbles
mov sum1,AL ; save sum 
 ; now to extract and display upper nibble of sum
 
Mov Cx,04h
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
   
MOV  AL,Sum1
AND AL,0fh   ; mask upper half
CMP AL,0Ah
	                    JC  makeasciinumeric2
	                          ADD AL,07h
makeasciinumeric2:        ADD AL,30h

MOV DL,AL         ; required to print a charater on display
Mov AH,02h
INT 21h
               
MOV AH, 4CH
INT 21H
CODE ENDS
END START
                            ;OUTPUT: ????