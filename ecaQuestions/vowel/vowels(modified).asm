DATA SEGMENT
Msg1 DB 0AH, 0DH,"ENTER THE SIGNAL $" 
V1 DB 1FH, 00h, 20H DUP("$")
A DB 0H
E DB 0H
I DB 0H
O DB 0H
U DB 0H 
Msg2 DB 0AH, 0DH,"COUNT OF A'S IS : $" 
Msg3 DB 0AH, 0DH,"COUNT OF E'S IS : $" 
Msg4 DB 0AH, 0DH,"COUNT OF I'S IS : $" 
Msg5 DB 0AH, 0DH,"COUNT OF O'S IS : $" 
Msg6 DB 0AH, 0DH,"COUNT OF U'S IS : $" 
DATA ENDS
  

CODE SEGMENT

ASSUME CS: CODE,DS: DATA
START: MOV AX, DATA
MOV DS, AX

   LEA DX,MSG1
   MOV AH,09H
   INT 21H
LEA DX,V1
MOV AH,0AH
INT 21H
LEA SI,V1
INC SI
MOV CL,[SI]
MOV CH,00H 
inc si
apple: MOV AL,[SI]
       CMP AL,'A'
       JNE N1
       INC A
       
    N1: CMP AL,'a'
       JNE N2
        INC A
        
    N2: CMP AL,'E'
       JNE N3
        INC E
        
        
    N3:CMP AL,'e'
       JNE N4
        INC E
        
    N4:CMP AL,'I'
       JNE N5
        INC I
     
    N5:CMP AL,'i'
       JNE N6
        INC I
        
        
   N6:CMP AL,'O'
       JNE N7
        INC O
        
   N7:CMP AL,'o'
       JNE N8
        INC O
        
   N8:CMP AL,'U'
       JNE N9
        INC U          
        
   N9:CMP AL,'u'
       JNE N10
        INC U
     
   N10:INC SI
   LOOP apple    
   
  
   LEA DX,MSG2
   MOV AH,09H
   INT 21H
   mov dl,A
   add dl,30h
   MOV AH,02H
   INT 21H 
   
   
   LEA DX,MSG3
   MOV AH,09H
   INT 21H 
   mov dl,E
   add dl,30h
   MOV AH,02H
   INT 21H
   
     
   LEA DX,MSG4
   MOV AH,09H
   INT 21H
   mov dl,I
   add dl,30h
   MOV AH,02H
   INT 21H
   
     
   LEA DX,MSG5
   MOV AH,09H
   INT 21H
   mov dl,O
   add dl,30h
   MOV AH,02H
   INT 21H 
   
    
   LEA DX,MSG6
   MOV AH,09H
   INT 21H
   mov dl,U
   add dl,30h
   MOV AH,02H
   INT 21H
   
   MOV AH,4CH
   INT 21H
   
   CODE ENDS
  END START
   
   
                             