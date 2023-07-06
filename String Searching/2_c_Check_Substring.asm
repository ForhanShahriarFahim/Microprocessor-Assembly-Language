.MODEL SMALL  

.STACK 100H

.DATA   

NEWLINE DB 0AH,0DH,'$' 
TEXT DB 50 DUP('$')
PATTERN DB 50 DUP('$') 
inmsg0 db "1st string: $"
inmsg1 db "2nd string: $" 
FOUND DB 'SUBSTRING FOUND$'
NOT_FOUND DB 'SUBSTRING NOT FOUND$'

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX 
    
    LEA DX, inmsg0
    MOV AH, 9   
    int 21H
    
    MOV SI, 0
    MOV AH, 1 
       
                      
    START_TEXT_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_TEXT_INPUT
        MOV TEXT[SI], AL
        INC SI
        JMP START_TEXT_INPUT
    
    END_TEXT_INPUT:
    LEA DX, NEWLINE  
    MOV AH, 9
    INT 21H 
     
    
     
     
    LEA DX, inmsg1
    MOV AH, 9   
    INT 21H
    
    MOV AH, 1    
    MOV SI, 0
            
        
    START_PATTERN_INPUT:
        INT 21H
        CMP AL, 0DH
        JE END_PATTERN_INPUT
        MOV PATTERN[SI], AL
        INC SI
        JMP START_PATTERN_INPUT
    
    END_PATTERN_INPUT:   
    
    LEA DX, NEWLINE  
    MOV AH, 9    
    INT 21H     
    
    
    
    MOV SI, 0         
                      
    CHECK:
        MOV DI, 0  
        PUSH SI
        
        ITERATE:  
            MOV AH, TEXT[SI]
            INC DI
            INC SI
            CMP PATTERN[DI], '$'
            JE FOUND_MSG  
            CMP AH, PATTERN[DI]  
            JE ITERATE
            JNE UPDATE_INDEX    
        
        UPDATE_INDEX:
            POP SI
            INC SI
            CMP TEXT[SI], '$'
            JE NOT_FOUND_MSG
            JMP CHECK    
            
    FOUND_MSG:
        LEA DX, FOUND
        MOV AH, 9
        INT 21H
        JMP EXIT
        
    NOT_FOUND_MSG:
        LEA DX, NOT_FOUND
        MOV AH, 9
        INT 21H
        JMP EXIT
        
    EXIT: 
        
END MAIN
        