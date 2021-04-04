include emu8086.inc  
jmp start

msg1 db  'ENTER NUMBER OF ELEMENTS: $'
msg2 db  0dh,0ah , 'ENTER NUMBER: $'
msg3 db  0dh,0ah , 'NUMBER OF EVEN NUMS: $'
msg4 db  0dh,0ah , 'EVEN NUMS ARE:  $'
msg5 db  0dh,0ah , 'NUMBER OF ODD NUMS:  $'
msg6 db  0dh,0ah , 'ODD  NUMS ARE:  $'


ELE dw ?
num dw ? 
EE dw 00H
EO dw ?
EVN DW 8000H
ODD DW 9000H

EVEN:  ;if num is even store it in 8000h and after 
MOV BX,EVN 
MOV AX,NUM
MOV [BX],AX
INC BX
MOV EVN,BX
INC DH  ; TO KNOW HOW MANY EVEN NUMBERS
PUSH DX
MOV DL,00H
MOV EE,DX
POP DX 
JMP CONT

ODDD:  ;if num is odd  store it in 9000h and after
MOV BX,ODD
MOV AX,NUM
MOV [BX],AX
INC BX
MOV ODD,BX
JMP CONT

start: 

; taking the total number of elements 
mov dx, offset msg1
mov ah, 9
int 21h

call    scan_num
mov     ELE, cx

 
MOV BX,0001H 
MOV DH,00H
MOV CH,00H 

LOOP1:  ;separating odd and even
PUSH DX
MOV DH,00H  
mov dX, offset msg2
mov ah, 9
int 21h
call    scan_num
mov     NUM, CX
POP DX
PUSH BX 


MOV AX,NUM
MOV AH,00H
MOV BL,02H
DIV BL
CMP AH,00H ; IS REMINDER =0 (EVEN)
JE EVEN   ;if num is even store it in 8000h and after
JNE ODDD  ;if num is odd  store it in 9000h and after

CONT: 
POP BX
CMP BX,ELE
JE SORT
INC BX
JMP LOOP1

SORT:
MOV AX,ELE
MOV BX,EE
SUB AL,BH
MOV AH,00H
MOV EO,AX
MOV BL,BH
MOV BH,00H
MOV EE,BX

PE:   ;to print  even

mov dx, offset msg3
mov ah, 9
int 21h
MOV AX,EE
call    print_num

mov dx, offset msg4
mov ah, 9
int 21h
MOV BX,8000H

PRINT1:
MOV AH,00H
MOV AL,[BX]
CMP AL,00H
JE PO
call    print_num
INC BX
JMP PRINT1

PO:    ;to print  odd 

mov dx, offset msg5
mov ah, 9
int 21h
MOV AX,EO
call    print_num

mov dx, offset msg6
mov ah, 9
int 21h
MOV BX,9000H

PRINT2:
MOV AH,00H
MOV AL,[BX]
CMP AL,00H
JE END
call    print_num
INC BX
JMP PRINT2


END:

HLT           ; halt!
 
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS