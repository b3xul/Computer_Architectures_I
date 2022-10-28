DIM EQU 20
.MODEL small
.STACK
.DATA
vett DW DIM DUP (?)   ;Vettore a zero UNSIGNED
.CODE
.STARTUP
MOV vett,1          ;Inizializzo i primi 2 valori
MOV vett+2,1
MOV SI,4            ;Inizializzo registri Indice e Contatore
MOV CX,DIM-2

ciclo: ;vett[SI]=vett[SI-2]+vett[SI-4]    
MOV AX,vett[SI-2]   ;Sommo elemento precedente in AX
ADD AX,vett[SI-4]
MOV vett[SI],AX     ;Salvo in memoria
INC SI              ;Scorro
INC SI
LOOP ciclo
.EXIT
END 

;Non ottimizzato!
;Best:
;lea si,vett  
;CICLO:mov ax,[si]
;add si,2
;add ax,[si]
;mov[si+1],ax

;Sempre 2 MOV e 2 ADD MA io calcolo l'EA ogni volta, lui lo salva prima!
;MOV AX,vett[SI] e' un accesso in memoria + calcolo di EA!
;MOV AX,[SI] Solo accesso in memoria quantomeno