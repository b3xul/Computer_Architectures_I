DIM EQU 5
.MODEL small
.STACK
.DATA
vett DB 10,50,-100,-100,-100 ;In inizializzazione controlla che siano numeri accettabili
                             ;MAX -128...127 
quoziente DB ?
resto DB ?
.CODE
.STARTUP
MOV CX,DIM
XOR SI,SI
XOR AX,AX
XOR BX,BX
;ciclo:ADD AL,vett[SI]    ;Poco efficiente accedere ogni volta all'indirizzo del vettore in memoria incrementato! NON E' VERO
;Si accede comunque in memoria, cambia semplicemente se ci accedo da un valore "immediato" che conosce l'assemblatore
;oppure se si accede dal contenuto di un registro (tempi simili). Cambia un pochino di piu' dovendo la cpu calcolare l'EA ma comunque trascurabile

;ciclo ADD AL,vett[SI]
;JO overflow 
;INC SI
;DEC CX
;JNZ ciclo
;Va bene per OF su 1 BYTE

ciclo: MOV AL,vett[SI]
CBW
ADD BX,AX
JO overflow
INC SI
DEC CX
JNZ ciclo

MOV CL,DIM ;IDIV->AL=AL/OPERANDO
MOV AX,BX
IDIV CL
MOV quoziente,AL
MOV resto,AH 
JMP fine

overflow:

fine:
.EXIT
END