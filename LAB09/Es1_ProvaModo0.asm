PORTA EQU 080h
PORTB EQU PORTA+1
PORTC EQU PORTA+2
CONTROL EQU PORTA+3
#start=8255.exe#    ;Con 8259 includo anche 8255 ecc, ma in questo caso non mi serve perche' lavoro solo in modo 0
                    ;N.B. delay 100 ms!
.model small
.stack
.data
lettura db ?
.code
.startup
MOV DX, CONTROL
MOV AL, 10001001b
;MOV AL, 1 00    0   1    0     0   1   b
;         MODO1 IOA IOCU MODO2 IOB IOCL
OUT DX, AL
MOV DX, PORTA
MOV AL, 'O'
OUT DX, AL
MOV DX, PORTB
MOV AL, 'K'
OUT DX, AL
MOV DX, PORTC
IN AL, DX ; impostare valore della porta C PRIMA dell'esecuzione di questa istruzione
MOV lettura, AL
;IRET (=RET+POP PSW) serve per tutte le INT (=CALL+PUSH PSW) (Usato per tutte le ISR)
.exit
end