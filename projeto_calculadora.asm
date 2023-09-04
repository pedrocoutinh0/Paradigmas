SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data 

    msg_comando db "Digite 1:Adição 2:Subtração, 3:Multiplicação, 4:Divisão:", 0xA, 0xD
    len_comando equ $- msg_comando

    msg_num1 db "Digite o primeiro número:", 0xA, 0xD
    len_msgnum1 equ $- msg_num1

    msg_num2 db "Digite o segundo número:", 0xA, 0xD
    len_msgnum2 equ $- msg_num2

    msg_resultado db "O resultado é:", 0xA, 0xD
    len_resultado equ $- msg_resultado

    msg_resto db "O resto é:", 0xA, 0xD
    len_resto equ $- msg_resto

    newLineMsg db  0xa
    newLineLen equ $-newLineMsg

segment .bss

   operacao resb 2
   num1 resb 1
   num2 resb 1
   res resb 1
   resto resb 1

section	.text
   global _start    	
_start:            

   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg_comando         
   mov edx, len_comando
   int 0x80                

   mov eax, SYS_READ 
   mov ebx, STDIN  
   mov ecx, operacao 
   mov edx, 2
   int 0x80            

   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg_num1          
   mov edx, len_msgnum1         
   int 0x80

   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num1
   mov edx, 3
   int 0x80

   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg_num2          
   mov edx, len_msgnum2         
   int 0x80

   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num2
   mov edx, 3
   int 0x80   

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_resultado        
   mov edx, len_resultado        
   int 0x80       

   cmp byte [operacao], '1'
   je soma
   cmp byte [operacao], '2'
   je subtrair
   cmp byte [operacao], '3'
   je multiplicar
   cmp byte [operacao], '4'
   je dividir

   jmp done


soma:
   
   mov eax, [num1]
   sub eax, '0'

   mov ebx, [num2]
   sub ebx, '0'

   add eax, ebx
   add eax, '0'

   mov [res], eax

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1       
   int 0x80

   jmp done

subtrair:
   mov eax, [num1]
   sub eax, '0'

   mov ebx, [num2]
   sub ebx, '0'

   sub eax, ebx
   add eax, '0'

   mov [res], eax

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1
   int 0x80

   jmp done

multiplicar:

   mov	al,[num1]
   sub  al,'0' 

   mov 	bl, [num2] 
   sub  bl, '0' 
   mul 	bl      
   add	al, '0' 

   mov [res], al

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1       
   int 0x80

   jmp done

dividir:

   mov ah, 0

   mov al, [num1]
   sub al, '0'

   mov bl, [num2]
   sub bl, '0' 
   
   div bl
    
   mov [resto], ah

   add al, '0' 

   mov [res], al
   
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1       
   int 0x80

   mov edx,newLineLen
   mov ecx,newLineMsg
   mov ebx,STDOUT
   mov eax,SYS_WRITE
   int 0x80 

   add word [resto], '0'

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_resto
   mov edx, len_resto
   int 0x80 

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, resto         
   mov edx, 1       
   int 0x80

done:    

    mov edx,newLineLen
    mov ecx,newLineMsg
    mov ebx,STDOUT
    mov eax,SYS_WRITE
    int 0x80 
    xor ebx, ebx 
    mov eax, SYS_EXIT   
    int 0x80
