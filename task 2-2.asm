include emu8086.inc
jmp start

msg1 db  'enter first number: $'
msg2 db  0dh,0ah , 'enter second number: $'
msg3 db  0dh,0ah , 'the first number factors are $'
msg4 db  0dh,0ah , 'the second number factors are $'
msg5 db  0dh,0ah , 'LCM:  $'
msg6 db  0dh,0ah , 'GCD: $'

num1 dw ?
num2 dw ?
GCD DW ?
LCM DW ?

start: 

; taking first number from user and store it in num1
mov dx, offset msg1
mov ah, 9
int 21h

call    scan_num
mov     num1, cx

; taking second number from user and store it in num2
mov dx, offset msg2
mov ah, 9
int 21h

call    scan_num
mov     num2, cx 

FACTOR1:
; print factors 1:

mov dx, offset msg3
mov ah, 9
int 21h

MOV AX,num1 
 
MOV CL,AL
MOV BL,02H ; THE FACTOR IS 2

STEP1:
DIV BL  ; THE MAIN DIVIDED NUM IS IN AL & REMINDER IN AH
CMP AH,00H  ; IS AH = 0 ? (THE FACTOR IS CORRECT ?)
JE PRINT1    ; IF YES : GO AND PRINT IT
INC BL
MOV AL,CL
MOV AH,00H
JMP STEP1
     
PRINT1:
MOV CL,AL
MOV AL,BL
CALL   print_num
MOV AL,CL
CMP CL,01H  ; IS THE NUMBER = 1 NOW
JNE STEP1    ; IF NO, GO AND CONTINUE.  IF YES, THIS IS THE END

FACTOR2:
; print factors 2:

mov dx, offset msg4
mov ah, 9
int 21h 

MOV AX,num2
 
MOV CL,AL
MOV BL,02H ; THE FACTOR IS 2

STEP2:
DIV BL  ; THE MAIN DIVIDED NUM IS IN AL & REMINDER IN AH
CMP AH,00H  ; IS AH = 0 ? (THE FACTOR IS CORRECT ?)
JE PRINT2    ; IF YES : GO AND PRINT IT
INC BL
MOV AL,CL
MOV AH,00H
JMP STEP2

PRINT2:
MOV CL,AL
MOV AL,BL
CALL   print_num
MOV AL,CL
CMP CL,01H  ; IS THE NUMBER = 1 NOW
JNE STEP2    ; IF NO, GO AND CONTINUE.  IF YES, THIS IS THE END
                                  
; GENERATING LCM & GCD 
MOV AX,NUM1
MOV BX,NUM2

WHILE:
MOV DX,0
MOV CX,BX
DIV BX
MOV BX,DX
MOV AX,CX
CMP BX,0
JNE WHILE

MOV GCD,AX
MOV CX,AX

MOV AX,NUM1
MOV BX,NUM2
MUL BX
DIV CX
MOV LCM,AX

REST:
; print LCM
mov dx, offset msg5
mov ah, 9
int 21h

mov     ax, LCM
call    print_num

; print GCD:
mov dx, offset msg6
mov ah, 9
int 21h

mov     ax, GCD
call    print_num

HLT           ; halt!
 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS