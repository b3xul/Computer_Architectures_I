DIM EQU 4
.MODEL small
.STACK
.DATA
vett1 DB 5,8,9,32
vett2 DB 13,112,37,99
res DB DIM DUP (?)
.CODE
.STARTUP
XOR SI,SI
XOR DX,DX
MOV CX,DIM
ciclo:
MOV AL,vett1[SI]
AND AL,vett2[SI]
JP  pari
JNP dispari

pari:INC DX
dispari:MOV res[SI],AL
INC SI
LOOP ciclo
.EXIT
END