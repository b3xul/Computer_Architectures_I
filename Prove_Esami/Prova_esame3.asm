DIM EQU 20
.model small   
.stack
.data
str_orig DB "% nella"
str_sost DB "per"
str_new  DB DIM DUP (?)
lung_new DW 0

.code
.startup

   push 7 ;len str_orig
   push 3 ;len str_sost
   push AX ;len nuova str
   call sostituisci
   pop AX
   MOV lung_new,AX
   ADD SP,4
    

.exit
sostituisci PROC
    PUSH BP
    MOV BP,SP
    PUSH AX
    PUSH BX
    PUSH SI
    PUSH DI
    MOV CX,[BP+8]
    XOR SI,SI
    XOR DI,DI
    XOR AX,AX
    ciclo: MOV AL,str_orig[SI]
    CMP AL,'%'
    JNE next
    
    PUSH CX
    MOV CX,[BP+6]
    XOR BX,BX
    sost: MOV AL,str_sost[BX]
    MOV str_new[DI],AL
    INC DI
    INC BX
    CMP BX,CX
    JNZ sost
    POP CX
    JMP next2
    
    next:MOV str_new[DI],AL
    INC DI 
    next2:INC SI
    CMP SI,CX
    JNZ ciclo
    
    MOV [BP+4],DI
    
    POP DI
    POP SI
    POP BX
    POP AX
    POP BP
    RET
sostituisci ENDP
END