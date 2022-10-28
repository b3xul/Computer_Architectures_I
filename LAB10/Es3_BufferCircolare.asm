PORTA EQU 80h
PORTB EQU PORTA+1
PORTC EQU PORTA+2
CONTROL EQU PORTA+3
DIM EQU 3   

#START=8255.EXE#

.MODEL small
.STACK
.DATA       
vet_pari dw DIM DUP (?)
vet_disp dw DIM DUP (?)
ind_pari db 0
ind_disp db 0
temp DB ?
flag DB 0
.CODE
.STARTUP
MOV DX,CONTROL
MOV AL,10010000b
OUT DX,AL

ciclo: CALL sorting
JMP ciclo

.EXIT

PROC sorting
    
    IN AL,PORTA
    
    AND flag,1
    JZ msb  ;flag a 0: primo byte
    
    lsb: AND flag,0
    MOV AH,temp
    TEST AL,1
    JNZ dispari ;ultimo bit a 1: dispari
    
    pari:CMP ind_pari,DIM
    JNE nextP
    MOV ind_pari,0  
    nextP:MOV BL,ind_pari
    SHL BL,1 
    MOV vet_pari[BX],AX
    INC ind_pari
    JMP fine
     
            
    dispari: CMP ind_disp,DIM
    JNE nextD
    MOV ind_disp,0  
    nextD:MOV BL,ind_disp
    SHL BL,1 
    MOV vet_disp[BX],AX
    INC ind_disp
    JMP fine
    
    msb:OR flag,1
    MOV temp,AL
    
    
    fine:
    RET
ENDP sorting 
END