.MODEL small
.STACK
.DATA
TEXT DB "Hello world!"
LUNG EQU $-TEXT

.CODE
.STARTUP
XOR SI,SI
MOV AH,2
MOV DX,33

ciclo:INT 21H
CMP DL,TEXT[SI]
JZ trovato
JNZ non_trovato

trovato:MOV DX,14
INC SI
CMP SI,LUNG
JZ fine
JNZ ciclo

non_trovato:PUSH DX
MOV DX,8
INT 21H
POP DX
INC DX
JMP ciclo

fine:
.EXIT
END