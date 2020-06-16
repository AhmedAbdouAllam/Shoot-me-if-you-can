
DisplayString MACRO MSG
;;this macro displays a given string (used)
	MOV DX,OFFSET MSG
	MOV AH,9
	INT 21H
ENDM DisplayString

ReadStringUser MACRO  username
Local Start,loop1,cont,cont3,enterorbsonly,backspace,error,firstletter,ENDING,CAPITAL
;;this macro is called by special macro to get username correctly (used)
start:
    mov bx,0
    mov cx,16
loop1:       
    mov ah,0
    int 16h
    cmp bx,15
    je enterorbsonly   
    cmp ah,1ch
    je ending
    cmp al,008d
    je backspace 
    cmp bx,0
    je firstletter    
    cmp al, 97d
    jl CAPITAL
    cmp al,122d
    jg error         
cont:  
    mov username[bx],al 
    push dx
    mov ah,2
    mov dl,username[bx]
    int 21h  
    pop dx
    inc bx
cont3: 

    dec cx   
    jnz loop1
    jmp ending
enterorbsonly:
    cmp ah,1ch
    je ending
    cmp al,008d
    je backspace
    jmp loop1    
backspace:
 
    mov ah,3h
    mov bh,0h
    int 10h 
    mov storecursor,dx
    dec bx
    mov al,00d
    mov username[bx],al
    mov ah,2
    dec dh
    int 10h
    push dx  
    mov ah,2
    mov dx,storecursor
    dec dx
    int 10h
    pop dx 

    mov ah,2
    mov dl,00d
    int 21h 
    mov ah,2
    mov dx,storecursor
    dec dx
    int 10h 

    inc cx
    jmp cont3

firstletter:
    cmp al,65d
    jl error
    cmp al,90d
    jg error
    jmp cont 
    
    
CAPITAL:

 cmp al,65d
    jl error
    cmp al,90d
    jg error

JMP CONT
  
error:
   MOVCURSOR 0F00H
    	DISPLAYSTRING ERRORMSG
MOVCURSOR 0E3AH
    	DISPLAYSTRING CLEAR
MOVCURSOR 0E3AH
    jmp start     
    
ending:   
ENDM ReadStringUser

ReadString MACRO MSG
;;this macro gets a string from user (used)
	MOV AH,0AH
	MOV DX,OFFSET MSG
	INT 21H
ENDM ReadString

DisplayColoredLetter Macro LET
	MOV AH,9
	MOV BH,0
	MOV AL,LET
	MOV CX,1H
	MOV BL,00CH
	INT 10H
ENDM DisplayColoredLetter

GETCRUSOR MACRO
	MOV AH,3H
	MOV BH,0
	INT 10H	
ENDM GETCRUSOR

INCCRUSOR MACRO
	INC DL
	MOV AH,2
	INT 10H
ENDM INCCRUSOR

MOVCURSOR MACRO CORD
;;This macro moves the cursor to any given postion (used)
	MOV AH,2
        mov bh,0
    	MOV DX,CORD
    	INT 10H
ENDM MOVCURSOR
CLRSCR MACRO
;;this macro clears the screen (USED) 
 	 mov ah,0
        mov al,3
        int 10h  
ENDM CLRSCR
KEYPRESSNOTWAIT MACRO
	mov ah,1
	int 16h
ENDM KEYPRESS
KEYPRESSWAIT MACRO
    	MOV AH,0
    	INT 16H
ENDM KEYPRESSWAIT
COPY MACRO PLU,PLYNAME,OUT,ALLOMA
	MOV DI,OFFSET PLYNAME
	MOV SI,OFFSET PLU
	ADD DI,2
	ALLOMA:
	CMP [DI],0DH
	JZ OUT
	MOV BX,[DI]
	MOV [SI],BX
	INC DI
	INC SI
	JMP ALLOMA
    	OUT:
mov [SI],'$'
ENDM COPY
CONSUME MACRO
Local  CHECKBUFFER,OUTOFCONSUME   
;;;this macro frees all the buffer (used)
	CHECKBUFFER: mov ah,1
	int 16h
	jz OUTOFCONSUME
	MOV AH,0H
	INT 16H
	JMP CHECKBUFFER
	OUTOFCONSUME:
ENDM CONSUME
;;;;;specialmacros SPC
SPCMACROCHECKER MACRO AMP,HALT,ENTERYSCREEN
	ENTERYSCREEN:          ;;;this macro prints the entery screen ;;request user names;;and check if they follow the condtions in the project(used)
    	MOVCURSOR 0200H 
    	DISPLAYSTRING NOTEMSG
    	MOVCURSOR 0300H
    	DISPLAYSTRING LINE
    	MOVCURSOR 1700H
    	DISPLAYSTRING LINE
    	MOVCURSOR 0819H
    	DISPLAYSTRING WELCOMEMSG
    	MOVCURSOR 091DH
    	DISPLAYSTRING  GAMENAME
    	MOVCURSOR 0E10H
    	DISPLAYSTRING NAMEMSG
    	ReadStringUser amp
ENDM SPCMACROCHECKER
ConvertToDecimal MACRO SCORE,COUNTERSTRING
;;this macro converts any given digit string to decimal (used)
MOV DI,OFFSET SCORE
MOV AX,[DI]
MOV BL,100D
DIV BL
ADD AL,48D
MOV SI,OFFSET COUNTERSTRING
MOV [SI],AL
INC SI
MOV AL,AH
MOV AH,0
MOV BL,10D
DIV BL
ADD AL,48D
MOV [SI],AL
INC SI
ADD AH,48D
MOV [SI],AH

ENDM ConvertToDecimal
