.MODEL small 
.STACK 
.DATA 
risultato DW ?
n DB 6
k DB 3

.CODE
.STARTUP
XOR AH,AH
XOR BH,BH
XOR DX,DX

MOV AL,n

MOV BL,k

SUB SP,2
PUSH AX 
CALL combina
ADD SP,2
POP AX  ;(n-k)!
;Si potrebbe anche evitare un sub add ma piu' pulito
sub sp,2
PUSH BX

CALL combina
ADD SP,2
POP BX

DIV BX
MOV risultato,AX
.EXIT
combina PROC
    PUSH BP
    PUSH AX 
    PUSH BX 

    MOV BP,SP
    MOV CX,[BP+8]
    
    MOV AX,CX 
        
    DEC BX
    CMP BX,0
    JBE fine
    
    cicla: DEC CX   ;k volte AX*(ax-1)
    MUL CX
         
    DEC BX
    CMP BX,0
    JNE cicla
     
    MOV [BP+10],AX
    JMP correct
    fine: MOV [BP+10],CX
    
    correct:
    POP BX
    POP AX
    POP BP
    RET                        
combina ENDP

END