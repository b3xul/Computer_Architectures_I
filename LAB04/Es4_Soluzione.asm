DIM EQU 8
.model small
.stack
.data
matrice db 0, 4, 0, 0, 0, 0, 0,60
        db 0, 5, 0, 0,11, 0, 0, 0
        db 0, 5, 7, 0, 0,10, 0, 0
        db 0, 0, 0, 9, 0, 0,49, 0
        db 0, 0,10, 0, 0, 0, 0, 0
        db 0,10, 3, 9, 0, 0,12, 0
        db 0, 0,58, 0, 0,17, 0, 0
        db 0, 1, 0, 0, 3, 0, 0, 0
coordx dw ?
coordy dw ?
.code
.startup
MOV CX, DIM
XOR DX, DX ; azzeramento valore massimo
XOR BX, BX   
cicloR: PUSH CX
MOV CX, DIM
XOR SI, SI
cicloC: XOR AX, AX ; azzeramento accumulatore
CMP SI, 0 ; verifica elemento O
JE next1
ADD AL, matrice[BX][SI][-1]
ADC AH, 0
next1: CMP BX, 0 ; verifica elemento N
JE next2
ADD AL, matrice[BX][SI][-DIM]
ADC AH, 0 
next2: CMP SI, DIM-1 ; verifica elemento E
JE next3
ADD AL, matrice[BX][SI][1]
ADC AH, 0
next3: CMP BX, DIM*(DIM-1) ; verifica elemento S
JE next4
ADD AL, matrice[BX][SI][DIM]
ADC AH, 0
next4: CMP AX, DX
JB next5 ; salvo ultimo massimo trovato
MOV DX, AX
MOV coordy, BX
MOV coordx, SI        
next5: INC SI
LOOP cicloC
POP CX
ADD BX, DIM
LOOP cicloR
MOV AX, coordy
MOV BL, DIM
DIV BL
INC AX
MOV coordy, AX
INC coordx
.exit
end