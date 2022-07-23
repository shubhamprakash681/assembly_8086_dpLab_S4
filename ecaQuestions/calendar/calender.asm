.model tiny
.code
org 100h
         
main proc near
             
    mov ah,2ah
    int 21h   
    
    push dx
    mov ax,cx
    mov si,offset year
    call hexToAsc
    pop dx
    
    
     
    push dx      
    mov ah,00
    mov al,dh
    mov si,offset month
    call hexToAsc
    pop dx
    
    push dx      
    mov ah,00
    mov al,dl
    mov BH, AL  ;;bkp
    inc BH
    mov SI, offset newDay
    mov [SI], BH
    mov si,offset day
    call hexToAsc
    pop dx
    
    
    mov ah,09h
    mov dx,offset messagecurrentdate
    int 21h

    ;;;for next day     
    mov ah,00
    mov SI, offset newDay
    mov al, [SI]
    mov si,offset day
    call hexToAsc

    mov ah,09h
    mov dx,offset msgNxt
    int 21h

    mov ah,09h
    mov dx,offset day
    int 21h
    
    mov ah,4ch
    mov al,00
    int 21h
         
 
    messagecurrentdate db 0ah,0dh,"Current Date : "
    day db '  ' 
    separator1 db '/'
    month db '  '
    separator2 db '/'
    year db "    $" 
    msgNxt db 0ah, 0dh, "Next Date is: $"   
    newDay db 00h, "$" 
           
endp 


hexToAsc proc near        ;AX input , si point result storage addres
        mov cx,00h
        mov bx,0ah
        hexloop1:
                mov dx,0
                div bx
                add dl,'0'
                push dx
                inc cx
                cmp ax,0ah
                jge hexloop1
                add al,'0'
                mov [si],al
        hexloop2:
                pop ax
                inc si
                mov [si],al
                loop hexloop2
                ret
endp   

end main