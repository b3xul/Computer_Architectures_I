DIM EQU 8
.MODEL small
.STACK
.DATA
matrice DB 0, 4, 0,0, 0, 0, 0,60
        DB 0, 5, 0,0,11, 0, 0, 0
        DB 0, 5, 7,0, 0,10, 0, 0
        DB 0, 0, 0,9, 0, 0,49, 0
        DB 0, 0,10,0, 0, 0, 0, 0
        DB 0,10, 3,9, 0, 0,12, 0
        DB 0, 0,58,0, 0,17, 0, 0
        DB 0, 1, 0,0, 3, 0, 0, 0
massimo DW 0
riga    DB ?
colonna DB ?
.CODE
.STARTUP
MOV DX,(DIM-1)*DIM  ;Serve per il sud
XOR BX,BX
MOV CX,DIM

cicloEsterno: XOR SI,SI   
PUSH CX     
MOV CX,DIM

cicloInterno:
;MODO1
XOR AX,AX   ;Accumulatore

PUSH SI
;Confronta INDICE COLONNA CON 0->SE!=0 FAI OVEST
CMP SI,0
JNZ ovest

;Bastava semplicemente usare l'offset: matrice[BX][SI][1/DIM/-1/-DIM]

after_ovest:POP SI     ;POP-PUSH/POP-INC/POP-DEC a seconda?
PUSH SI

;Confronta INDICE COLONNA CON DIM->SE!=0 FAI EST
CMP SI,DIM-1
JNZ est
                                    
after_est: POP SI
PUSH BX

;Confronta INDICE RIGA CON 0->SE!=0 FAI NORD (SOMMA VALORI IN UN UNICA VARIABILE) 
CMP BX,0
JNZ nord

after_nord: POP BX
SUB SP,2    ;Punta a dove gia' si trovava BX->Piu' efficiente della PUSH

;Confronta INDICE RIGA CON DIM*(DIM-1)->SE!=0 FAI SUD
CMP BX,DX
JNZ sud
after_sud: POP BX

CMP AX,massimo
JNS nuovo_massimo    ;s=0 se positivo(ax>max)
JS continua

nuovo_massimo: MOV massimo,AX
MOV AX,BX
PUSH DX
MOV DL,DIM
DIV DL
POP DX
MOV riga,AL
MOV AX,SI
MOV colonna,AL

continua: INC SI
LOOP cicloInterno

ADD BX,DIM
POP CX
LOOP cicloEsterno

CALL stampa
JMP fine

ovest: CALL ovestP
JMP after_ovest
ovestP PROC
PUSH BP
MOV BP,SP
MOV SI,BP+4
DEC SI
ADD AL,matrice[BX][SI]
ADC AH,0
POP BP
RET
ENDP    

est: CALL estP
JMP after_est 
estP PROC
PUSH BP
MOV BP,SP
MOV SI,BP+4
INC SI
ADD AL,matrice[BX][SI]
ADC AH,0
POP BP
RET
ENDP

nord: CALL nordP
JMP after_nord
nordP PROC
PUSH BP
MOV BP,SP
MOV BX,BP+4
SUB BX,DIM
ADD AL,matrice[BX][SI]
ADC AH,0
POP BP
RET
ENDP

sud: CALL sudP
JMP after_sud

sudP PROC
PUSH BP
MOV BP,SP
MOV BX,BP+4
ADD BX,DIM
ADD AL,matrice[BX][SI]
ADC AH,0
POP BP
RET
ENDP

stampa: MOV AH,2
MOV DL,'x'
INT 21H
MOV DL,'='
INT 21H
MOV DL,colonna
INC DL
ADD DL,'0'
INT 21H

MOV DL,','
INT 21H

MOV DL,' '
INT 21H

MOV DL,'y'
INT 21H
MOV DL,'='
INT 21H
MOV DL,riga
INC DL
ADD DL,'0'
INT 21H




fine:
.EXIT
END