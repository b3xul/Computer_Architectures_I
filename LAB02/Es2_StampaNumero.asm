.MODEL small
.STACK
.DATA
dividendo DW ?
;divisore DW 10
.CODE
.STARTUP
MOV dividendo,3721      ;UNSIGNED
MOV CX,10
MOV AX,dividendo
;CMP AX,0              ;Non si puo' controllare se l'input sia signed o unsigned!
;JB negativo           ;SF=MSB->SF=1 se negativo ma non va bene perche' potrebbe avere 1 come MSB unsigned e non dovrebbe saltare! 
;CWD                    ;Per evitare interrupt divisione per zero usando DOUBLEWORD e WORD (servirebbe al posto di xor dx,dx se avessi signed, qua no!)
MOV BP,SP

ciclo:XOR DX,DX        ;Azzero per usare solo AX (Divisore) per dividere 
DIV CX                 ;AX=AX/CX
                       ;DX=AX%CX
PUSH DX                
CMP AX,0
JNZ ciclo

MOV AH,2               ;Perche' meglio 02h di 2? Risparmio lavoro all'assemblatore?
stampa: POP DX
ADD DX,'0'             ;Resto sara' su una word al massimo
INT 21H
CMP BP,SP
JNZ stampa

.EXIT
END