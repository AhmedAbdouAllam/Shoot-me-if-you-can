INCLUDE Macros.INC
.model small
.STACK 64
.DATA



;================================================================;
;====================== Main String and some parameters =========;
;================================================================;       


;;LEVELING PARAMETERS
CHOOSELEVEL DB "Please choose a level by entering its number:",'$' 
LEVELSNOTE DB 'Note:Levels are arranged in asscending order based on its difficulty','$'
LEVEL1 DB '*Level1 (1)', '$'
LEVEL2 DB '*Level2 (2)', '$' 







;;;ENTERY MODULE PARAMETERS AND STRINGS 
NOTEMSG DB 'Note that your limit is 15 characters and the first charcter has to be a letter','$'
NAMEMSG DB 'Please enter your name then press "Enter":','$'
WELCOMEMSG DB 'Welcome to the best game ever','$'
Errormsg DB 'The name has to start with a captial letter no digits no special charcters','$'
CLEAR DB 17 DUP(032),'$' 
STORECURSOR DW ? 


;;;INLINECHAT MODULE PARAMETERS AND STRINGS
SENDCURSORINLINE DW ?
RECIVECURSORINLINE DW ?
VALUEINLINE DB ?
GETSEND DW ?
GETREC DW ?
SPACEINLINE DB 80 DUP(" "),"$"




;;MAINMENU MODULE PARAMETERS AND STRINGS;;To be edited in phase 3 so it holds invitations
IFYOUWANT DB '*Start the game press "F2".','$'
ELSEIFYOUWANT DB '*To go to The chat mode press"F3"','$'
ELSE DB '*To exit the game press"ESC"','$'
MEIN DB ?
SEIN DB ?
MEINKEY DB ? 
SEINKEY DW ?  
key db 0
SEINREQLEVEL DB " has requested to play with you :)",'$'
SEINREQCHAT DB " has requested to chat with you :)",'$'
levelingdum db "leveling","$"
gamedum db "Gaming","$" 
chatdum db "Chating","$"
space1 db 1 dup(' '),"$" 
space4 db 4 dup(' '),"$"
TOO DB ":$" 
value db ? 
sendcursor dw 0100h
recivecursor dw 0F00h   
ENDCHAT DB ' To go back to the mainmenu press "ESC"',"$"





;;;GAME MODULE PARAMETERS AND STRINGS         
GameName DB 'SHOOT ME IF YOU CAN :)','$'
SCORESTRN DB "'s score:",'$'
ScorePLY1 DW 4 DUP ('$')
ScorePLY2 DW 4 DUP('$')
SCORE1 DW 0
SCORE2 DW 0
SCORE2PAR DW 0
SCORE1PAR  DW 0
PLY1NAME DB 16 DUP('$'),'$' 
PLY2NAME DB 16 DUP('$'),'$'  
ACTIONKEY DB 0





;TAKE IT OUT IN PHASE 3
MSGTEMP DB "Chatting is not avilable in this version of the game.SORRY :'(",'$'
line DB 80 DUP('-'),'$'
SPACELINE 80 DUP(32D),'$'
LevelMsg DB 'Level:','$'  
Lvl DB ? ,'$'
ENDMSG DB 'To end the game with','$'
ENDMSG2 DB 'press F2 ,To Pause Press F5.','$'
SPACE DB 032D ,'$'        
pause db 'To go back to the game press "ESC".','$'                 
sorrylvl2 db "Sorry Level2 isn't avilable in this version.","$"
yocan db "*You can go to level 1 to confirm press 'Y'.",'$'
orgotoo db "*To go to main menu press 'N'.",'$'


;================================================================;
;====================== STATIC SCREENS ==========================;
;================================================================;

 STATIC1 DB "Please wait till the other player enters his name :) . ",'$'

 STATIC2 DB "Please wait till the other player chooses the level :)." ,'$'

 star db 04,'$'
 MASTER DB 0








;=====================================================;
;================= GetMaxScore =======================;
;=====================================================;
storecursornum dw ?
MAXSCORE DW ?
MAXSCORESTRING DB 3 DUP('$'),'$'
whatis db 'Enter the maximum score you want not more than 999: ','$' 
THEWINNER DB 'THE WINNER IS :) :','$'
NUMBERSONLY DB 'Error,your entery has to be in numbers only','$'
MAINMENUWON db '*To go back to the MAIN MENU Press any key.','$'
;=====================================================;
;====================== Game Main Parameters =========;
;=====================================================;




;;;;;Level 1 gaming parameters
;------------ player 1 --------------------     
  DataX1 DB 25H 
  DATAY1 DB 12H 
  SIZE1  DB 4

;------------ player 2 --------------------     
  DataX2 DB 25H 
  DATAY2 DB 4H 
  SIZE2  DB 4    
 
;---------------- bariar---------   
  dataxb db 25h
  datayb db 0Bh   
  sizeb db 4     
  DletedXb db 0
  x dw 1   
 buletB1y db 0
 buletB1x db 0

 buletB2y db 0
 buletB2x db 0
 
 pbuletB1y db 0
 pbuletB1x db 0

 pbuletB2y db 0
 pbuletB2x db 0      
;--------------- bulet1---------------
 bulet11y db 0
 bulet11x db 0
 
 pbulet11x db 0
 pbulet11y db 0
 
 bulet12y db 0
 bulet12x db 0
 
 pbulet12x db 0
 pbulet12y db 0
  ;right bullet
 bulet13y db 0
 bulet13x db 0
 Hit13 dw 0
 ;left bullet
 bulet14y db 0
 bulet14x db 0
 Hit14 dw 0 
 
 pbulet13y db 0
 pbulet13x db 0
 
 pbulet14y db 0
 pbulet14x db 0
 
 SbuletCount1 db 0                                   
 buletCount1 db 0                                   
;--------------- bulet2---------------
 bulet21y db 0
 bulet21x db 0
 
 pbulet21x db 0
 pbulet21y db 0 
                
 bulet22y db 0
 bulet22x db 0
 
 pbulet22x db 0
 pbulet22y db 0
 
  ;right bullet
 bulet23y db 0
 bulet23x db 0 
 Hit23 dw 0
                
 ;left bullet
 bulet24y db 0
 bulet24x db 0
 Hit24 dw 0   
 
 pbulet23y db 0
 pbulet23x db 0 
 
 pbulet24y db 0
 pbulet24x db 0
 
 buletCount2 db 0 
 SbuletCount2 db 0 
 DeletePar dw 0     
 
 count3 dW 0

;______________________________________________________________________________

 ;;;Objects of the game
 BARIAR DB 17D,178D,178D,178D,16D,'$'
 PLAYER1 DB 17D ,'O',193D,'O',16D ,'$'
 PLAYER2 DB 17D ,'O',194D,'O',16D ,'$'
;-------------------------------------------------------------------------------------------------


.CODE
MAIN PROC FAR
       MOV AX,@DATA 
       MOV DS,AX    
       
;__________________________________________________________________________________
       
       ;;;;CLEARING THE SCREEN FOR DOSBOX
       
       CLRSCR
;----------------------------------------------------------------------------------

;===============================================================;
;======================Intialiizing The Port ===================;
;===============================================================;

    CALL PortIntialization 



;----------------------------------------------------------------------------------      
;==================================================;
;====================== Entery Menu ===============;
;==================================================;
    
    
    
    JMP EN1 ;;This is labeled in spacemacrochecker it displays the enterymenu and get the name of user 1       
    
    SPCMACROCHECKER PLY1NAME,PLAY2,EN1
    
    play2: 
        CALL STATICSCREEN1

;===============================================================;
;======================Exchanging Names ========================;
;===============================================================;  
  
;------------------------------TheSync--------------------------; 
;;here in this part i need to check that both devices are ready so a simple code used
;;the protocol is to send '5' and wait for the response if it is five continue
      
    SEND '5' 
    
    BEGINOFREC:
    CALL RECIVE 
    CMP AL,'5'
    JNZ BEGINOFREC
 ;------------------------------TheSender------------------------;  
 		mov di,offset PLY1NAME
		mov si,offset PLY2NAME
   SENDING:
   SEND [DI]
   MOV DX,'$'
   CMP [DI],DX
   JZ RECCONT
   INC DI
   CALL RECIVE
   MOV [SI],AL
   CMP AL,'$'
   JZ SENDCONT
   INC SI
   JMP SENDING
;-----------------------------if the Sending finshed---------------;     
  RECCONT:
   CALL RECIVE
   MOV [SI],AL
   CMP AL,'$'
   JZ MAINMENUMODULE
   INC SI
   JMP RECCONT
 
;---------------------------if we finished reciving------------------;    
   SENDCONT:
    SEND [DI]
    MOV DX,'$'
    CMP [DI],DX
    JZ MAINMENUMODULE
    INC DI
    JMP SENDCONT
;;---------------------------------------------------------------------------------
    
;;;This Block is for printing main screen and getting user actions so he get to the menu he wants
;;MAIN Menu  to call it we jump to mainmenumodule



;==================================================;
;====================== Main Menu =================;
;==================================================;
    
    MAINMENUMODULE:
    
    CLRSCR 
    MOV MASTER,0
    MOV MEIN,0
    MOV SEIN,1 
    
    ;;here we clear the screen and empty the keyboard buffer then print the module       
    
    CONSUME
    
    MOVCURSOR 1300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 0300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 021DH
    DISPLAYSTRING GAMENAME
    
    MOVCURSOR 0A05H 
    DISPLAYSTRING IFYOUWANT
    
    MOVCURSOR 0C05H
    DISPLAYSTRING ELSEIFYOUWANT
    
    MOVCURSOR 0E05H
    DISPLAYSTRING ELSE  
    
    mainmenuloop:
    ;;here we get user action to go to any given menu
   
    ;---------------------------MEIN--------------------------------------;   
        KEYPRESSNOTWAIT
        MOV MEINKEY,0
        jnz consumeMeinBUffer
        BConsumeMeinBuffer:
        CMP MEINKEY,60D
        JZ Meinleveling  ;;starting the game defined in line 137
        CMP MEINKEY,61D
        JZ MeinCHATMODULE   ;;chatting mode
 
        CMP MEINKEY,01D       
        JZ MEINENDGAME      ;; to close the game
;-----------------------------RECIVE FROm SEIN------------------------------------;   
;;RECIVE part SEIN PART
       ;;RECIVE part SEIN PART
    
;;Check that Data Ready
		mov dx , 3FDH		; Line Status Register	
	    in al,dx 
  		AND al , 1
  		JZ MAINMENULOOP

 ;If Ready read the VALUE in Receive data register
  		mov dx , 3F8H
  		in al , dx 
     
        CMP AL,60D
        JZ SEINLEVELING
   
     
        CMP AL,61D
        JZ SeinCHATMODULE
        
        CMP AL,01D
        JZ SEINENDGAME 
        
        JMP MAINMENULOOP 
;----------------------------END OF SEIN-------------------------------;    
        consumeMeinBUffer:       
        mov MEINKEY,AH
        consume
        jmp BConsumeMeinBuffer
;---------------------------END OF MEIN CONSUME------------------------;
 
;--------------MEIN & SEIN LEVELING ----------------------------------;    


 MEINLEVELING:  
    
        mov dx , 3FDH		; Line Status Register
        AGAINLEVELING:  	
        In al , dx 			;Read Line Status
  		AND al , 00100000b
  		JZ AGAINLEVELING
        
;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
  		mov  al,60D
  		out dx , al 
        mov mein,60D
        mov ah,sein
        cmp al,ah
        jz perform1        
jmp MAINMENULOOP 
    SEINLEVELING:    
        MOV SEIN,60D
        MOVCURSOR 1400H
        DISPLAYSTRING SPACE
        MOVCURSOR 1400H  
        DISPLAYSTRING PLY2NAME
        DISPLAYSTRING SEINREQLEVEL  
        MOV AL,MEIN
        MOV AH,SEIN
        CMP AL,AH
        JZ PERFORM2
        JMP MAINMENULOOP

;---------------------------MEIN & SEIN CHAT----------------------------;
MeinCHATMODULE:
        mov dx , 3FDH		; Line Status Register
        AGAINCHATTING:  	
        In al , dx 			;Read Line Status
  		AND al , 00100000b
  		JZ AGAINCHATTING
        
;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
  		mov  al,61D
  		out dx , al 
        mov mein,61D
        mov ah,sein
        cmp al,ah
        jz perform1        
        jmp MAINMENULOOP    
        
SEINCHATMODULE:    
        MOV SEIN,61D
        MOVCURSOR 1400H
        DISPLAYSTRING SPACE
        MOVCURSOR 1400H    
        DISPLAYSTRING PLY2NAME
        DISPLAYSTRING SEINREQCHAT  
        MOV AL,MEIN
        MOV AH,SEIN
        CMP AL,AH
        JZ PERFORM2
        JMP MAINMENULOOP 
;--------------------------------PERFORM1--------------------------------;
 PERFORM1:
 MOV MASTER,1
        CMP MEIN,61D
        JZ CHATMODULE
        CMP MEIN,60D
        JZ LEVELING
JMP MAINMENULOOP

;--------------------------------PERFORM2-------------------------------;
 PERFORM2: 
 MOV MASTER,2
        CMP SEIN,61D
        JZ CHATMODULE
        CMP SEIN,60D
        JZ STATIC3 
 JMP MAINMENULOOP  
;_____________________STATIC SCREEN WHILE LEVELING______________________;

  STATIC3:
        CLRSCR
    
        MOVCURSOR 011DH 
        DISPLAYSTRING GAMENAME ;;display the game name in the top of the game   
       
       
       
        MOVCURSOR 0300H
        DISPLAYSTRING LINE
    	
    	MOVCURSOR 1700H
    	DISPLAYSTRING LINE
    	
    	MOVCURSOR 0819H
        DISPLAYSTRING WELCOMEMSG
        
        MOVCURSOR 091DH
    	DISPLAYSTRING  GAMENAME  
       
        MOVCURSOR 0C0CH
        DISPLAYSTRING STATIC2    
        CALL RECIVE
        CMP AL,'5'
        JZ RECIVELVL1
        JNZ STATIC3
        
;________________________________________________________________________________________________________________________   
    
;==================================================;
;======================Leveling ===================;
;==================================================;
    
    
    
    
    ;;Level choosing module
    ;;the leveling menu is the menu for starting the game
    ;;the user chooses a level from 2 (to be changed in phase 2)
    Leveling: 
    ;;;we clear the screen and consume the buffer
    CLRSCR
    CONSUME
    ;;;here we draw the leveling menu
    
    MOVCURSOR 1300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 0300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 021DH
    DISPLAYSTRING GAMENAME
    
    MOVCURSOR 0A05H
    DISPLAYSTRING CHOOSELEVEL
    
    MOVCURSOR 0C05H
    DISPLAYSTRING LEVELSNOTE
    
    MOVCURSOR 0E05H
    DISPLAYSTRING LEVEL1
    
    MOVCURSOR 1005H 
    
    DISPLAYSTRING LEVEL2 
    
    MOV DI,OFFSET LVL ;;this line to get what the user pressed in lvl variable
    ;;;;;;;;;;;here we finished drawing the menu
    LEVELINGBREAK:  ;;defined in 165
    KEYPRESSWAIT    ;;here we get user actions if he enter 1 we go to level1 if he enterd 2 we go to level 2 else no operation
    CMP AL,49D
    JZ SETLEVEL1
    CMP AL,50D
    JZ SETLEVEL2
    JMP LEVELINGBREAK
   ;;end of leveling module
    ;____________________________________________________________________________________________________________________________    
    
;==================================================;
;====================== Chatting ==================;
;==================================================;
    
    
    
    
    
    
    
    ;;chat module only draws the menu for now and tell the user that it is not avilable
    ;;the user can go back to main menu
    ;;;CHATMODULE
    CHATMODULE:
    ;;here we clear the screen then consume the buffer
    CLRSCR
    CONSUME
   ;;TO SPLIT THE SCREEN IN HALF  
    MOVCURSOR 0D00H     
    MOV DX,OFFSET line
	MOV AH,9
	INT 21H  
	MOVCURSOR 0000H
	MOV DX,OFFSET PLY1NAME
	MOV AH,9
	INT 21H  
	MOV DX,OFFSET TOO
	MOV AH,9
	INT 21H 
	MOVCURSOR 0E00H
	MOV DX,OFFSET PLY2NAME
	MOV AH,9
	INT 21H  
	MOV DX,OFFSET TOO
	MOV AH,9
	INT 21H        
	MOVCURSOR 1800H
	DISPLAYSTRING ENDCHAT
       ;;CONFIURATION
       keyboard:
    keypressnotwait
    jz reciveE
    jnz send  
send:     
CMP SENDCURSOR,0B4FH
JGE SCROLL1


     mov value,al
     MOV AX,SENDCURSOR 
     CMP VALUE,13D
     JZ SET
    CMP VALUE,8
    JZ BACKSPACE
    mov di,sendcursor
    mov ax,di
    inc al
    cmp al,80
    jz set
    BACK: 
    mov di,ax
    mov sendcursor,di
    movcursor sendcursor
   
        
        mov ah,2
        mov dl,value
        int 21h 
        BACKENTERS:
        consume 
        
      SEND VALUE
        CMP VALUE,27D
  	    JZ MAINMENUMODULE 
        JMP reciveE
    
reciveE:    
       mov dx , 3FDH		; Line Status Register
	CHK:	
	    in al,dx 
  		AND al , 1
  		JZ keyboard

 ;If Ready read the VALUE in Receive data register
  		mov dx , 3F8H
  		in al , dx 
  		mov VALUE , al
  		MOV AX,RECIVECURSOR
  		CMP RECIVECURSOR,174fH
        JGE SCROLL2
  		CMP VALUE,13D
  		JZ SET1
  		CMP VALUE,8D
  		JZ BSOUT
  		CMP VALUE,27D
  		JZ MAINMENUMODULE
        ;;PRINT AND GET CHAR 
        mov di,recivecursor
       mov ax,di
        inc al
        cmp al,80
        jz set1 
        back1:
        mov di,ax
        mov recivecursor,di
        movcursor recivecursor
        mov ah,2
        mov dl,VALUE
        int 21h 
        
        JMP keyboard 
    set1:
    mov al,0
    inc ah
    jmp back1        
    set:
    mov al,0
    inc ah
    jmp back

backspace:
cmp sendcursor,0100h
jle endbs

    mov ah,3h
    mov bh,0h
    int 10h
    cmp dl,00d
    je handlelinebs
      
    mov SENDCURSOR,dx
    mov ah,2
    dec dl
    int 10h
    mov ah,2
    mov dl,00d
    int 21h 
    mov ah,2 

    mov dx,SENDCURSOR 
    dec dl
    int 10h    
    mov SENDCURSOR,dx 
    jmp endbs
    
handlelinebs:  


    mov ah,2 
    dec dh
    mov dl,79d
    int 10h 
    
    mov ah,2
    mov dl,00D
    int 21h 
    
    mov ah,2 

    mov dx,SENDCURSOR 
    dec dh
    mov dl,78d
    int 10h      
    mov SENDCURSOR,dx
endbs:   
    mov al,8 
    mov value,al
    jmp BACKENTERS

bsout:  
cmp recivecursor,0f00h
jle endbsout

    mov ah,3h
    mov bh,0h
    int 10h
    cmp dl,00d
    je handlelinebsout
      
    mov RECIVECURSOR,dx
    mov ah,2
    dec dl
    int 10h
    mov ah,2
    mov dl,00d
    int 21h 
    mov ah,2 

    mov dx,RECIVECURSOR 
    dec dl
    int 10h    
    mov RECIVECURSOR,dx 
    jmp endbsout
    
handlelinebsout:  


    mov ah,2 
    dec dh
    mov dl,79d
    int 10h 
    
    mov ah,2
    mov dl,00d
    int 21h 
    
    mov ah,2 

    mov dx,RECIVECURSOR
    dec dh
    mov dl,78d
    int 10h    
    mov RECIVECURSOR,dx  
endbsout:
    jmp KEYBOARD
   
    SCROLL1:  

     MOV ax,SENDCURSOR
    MOV AL,0  
    MOV AH,0BH
    MOV SENDCURSOR,AX
     mov ax,0601h
    mov bh,07
    mov cx,0100h
    mov dx,0C4FH
    int 10h  
   JMP KEYBOARD   

SCROLL2:      
     MOV ax,RECIVECURSOR
    MOV AL,0
    MOV AH,17H 
    MOV RECIVECURSOR,AX
     mov ax,0601h
    mov bh,07H
    mov cx,0F00h
    mov dx,174FH
    int 10h  
   JMP KEYBOARD 


;;______________________________________________________________________________________________________________________________________________________      

;==================================================;
;====================== Level setting==============;
;==================================================;



   ;;here we move the value of level in lvl vaiable
   SETLEVEL1:
    MOV [DI],'1'
    JMP GAMEMODULE
    SETLEVEL2:
    MOV [DI],'2'      
    JMP GAMEMODULE
    
    
;;______________________________________________________________________________________________________________________________________________________      










    
;;___________________________________________________________________________________________________________________________________    
;;;;this is the game interface main code
;==================================================;
;====================== Game interface ============;
;==================================================;
                 
   GAMEMODULE:
    
    
    CLRSCR   ;;;here we clear the screen
   call display 
   
    CMP VALUE,01D
    JZ MAINMENUMODULE 
    send '5'
    SEND LVL
    MOVCURSOR 0000H
    cmp lvl,'1'
    jz FirstLevel
    cmp lvl,'2'
    jz secondlevel


    
;==================================================;
;====================== Level1 ====================;
;==================================================;    
    
    
    FirstLevel:
       call drawBariar             
       call drawplayer1 
       call drawplayer2



;---------------------------------------;        
;------------MOVE BARIAR----------------;
;---------------------------------------;      
       
       CHECK: 
       mov actionkey,0
       INC COUNT3
              
       MOV AX,COUNT3 
      
       CMP AX,0fffh
       JZ BEGIN
   
       CMP AX,7ffh
       JNZ GAME
       
       
       BEGIN: 
       SEND '5' 
       MOV BX,SCORE1
       SEND BL
       MOV BX,SCORE2
       SEND BL     
       SEND DATAX1
       SEND DATAX2
       SEND DATAXB
       SEND BULET11Y
       SEND BULET11X 
       SEND BULET12Y
       SEND BULET12X
       SEND BULET21Y
       SEND BULET21X
       SEND BULET22Y
       SEND BULET22X    
       
;=======================RECIVE I/P FROM THE USER===========================================
        mov dx , 3FDH		; Line Status Register
	    CHKpkey:	
	    in al,dx 
  		AND al , 1
  		JZ fish

 ;If Ready read the VALUE in Receive data register
  		mov dx , 3F8H
  		in al , dx
        mov actionkey,al
   
 
    fish: 
       
       
       CALL MoveBariar
       ;;here we update score each loop
       ConvertToDecimal SCORE1,SCOREPLY1
       
       ConvertToDecimal SCORE2,SCOREPLY2 
        
        mov ax,score1
        cmp ax,50D
        JZ WIN
        MOV AX,SCORE2
        CMP AX,50D
        JZ WIN
       
       MOVCURSOR 0204H 
       DISPLAYSTRING ply1name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY1
      
       MOVCURSOR 0230H
       DISPLAYSTRING PLy2name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY2 
       
       MOV AX,COUNT3
       CMP AX,0fffh
       JNZ GAME    
       CALL CheckScore 
       CALL MOVEBULETS
       MOV AX ,0
       MOV COUNT3,AX



;--------------------------------------------------;
;----------------- READ FROM USER -----------------;       
;--------------------------------------------------;                           
       GAME:
       MOV AH,1
       INT 16H
       CMP AH,1 ;CHECK IF THE USER DIDNT PUT ANYTHING
       JZ  Move1Right 
       ;THIS STATEMENT TO EMPTY THE KEYBOARD BUFFER
       MOV AH,0 
       INT 16H
       JMP Move1Right ; CHECK IF ITS RIGHT BOTTON
                                                  




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 1 RIGHT-----------------;
;-------------------------------------------------;
 
     Move1RIGHT: 
       CMP AH,20h  ; check if the key RIGHT
       JNZ Move1Left ; if no jump to thE NEXT IF
       mov CX,0
       MOV CH,DATAY1
       MOV CL,DATAX1
       MOV SI,CX 
       MOV BL,SIZE1
       MOV AL,'_'
       ; check the border 
       cmp CL,75D
       jz check          
       CALL MoveRight
       INC DATAX1 
       CALL DRAWPLAYER1   
       
       jmp Check
                      




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 1 LEFT------------------;
;-------------------------------------------------;
                    
       Move1Left:   
       CMP AH,1EH  ; check if the key LEFT
       JNZ Move2RIGHT   ; if no jump to the next if
       ;TO MAKE SURE WE DIDNT GET OUT THE BORDER
       MOV CH,DATAY1
       MOV CL,DATAX1
       MOV SI,CX
       MOV BL,SIZE1
       MOV AL,'_'
       ; check the border 
       cmp CL,0h
       jz check
       CALL MoveLeft
       DEC DATAX1 
       CALL DRAWPLAYER1   
       
       jmp check
                               





;-------------------------------------------------;      
;--------- TO MOVE PLAYER 2 RIGHT-----------------;
;-------------------------------------------------;
       Move2RIGHT: 
       CMP Actionkey,20H  ; check if the key RIGHT
       JNZ Move2Left ; if no jump to the next if
       ;TO GET THE ONE WE SHOULD DELETE
       MOV CH,DATAY2
       
       MOV CL,DATAX2
       MOV SI,CX
       MOV BL,SIZE2
       MOV AL,'_'
       ; check the border 
       cmp CL,74D
       jz check
       CALL MoveRight 
       INC DATAX2    
        CALL DRAWPLAYER2
        
       jmp Check
                              




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 2 LEFT------------------;
;-------------------------------------------------;
                    
       Move2Left:   
       CMP actionkey,1EH  ; check if the key LEFT
       JNZ SHOOT1   ; if no jump to the next if
       ;TO MAKE SURE WE DIDNT GET OUT THE BORDER
       MOV CH,DATAY2
       MOV CL,DATAX2
       MOV SI,CX
       MOV BL,SIZE2
       MOV AL,'_'
       ; check the border 
       cmp CL,0H
       jz check
       CALL MoveLeft  
       DEC DATAX2 
        CALL DRAWPLAYER2
        
       jmp check
      





;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER1-----------------;
;-------------------------------------------------;
                    
       
       SHOOT1:   
       CMP AH,11H  ; check if the key LEFT
       JNZ SHOOT2 ; if no jump to the next if
       CALL CreatPlayer1Bulet
       jmp check
       




;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER2-----------------;
;-------------------------------------------------;
                    
       SHOOT2:   
       CMP actionkey,11H  ; check if the key LEFT
       JNZ PAUSEXX ; if no jump to the next if
       CALL CreatPlayer2Bulet                      
       jmp check    





;-------------------------------------------------;      
;--------- TO PAUSE THE GAME ---------------------;
;-------------------------------------------------;
       PAUSEXX:
       cmp actionkey,63d
       jz XXXXX
       CMP AH,63D
       JNZ CloseProgram
       XXXXX:  
       SEND '8'
       CALL pauseX
       jmp check
       
       
;-------------------------------------------------;      
;--------- Second Level---------------------------;
;-------------------------------------------------;        
secondlevel:

        call display

       call drawBariar             
       call drawplayer1 
       call drawplayer2
       
       
;---------------------------------------;        
;------------MOVE BARIAR----------------;
;---------------------------------------;      
       
       CHECKs:
       MOV ACTIONKEY,0     
       
       INC COUNT3        
       
       MOV BX,2fffH
       MOV DX,0
       MOV AX,COUNT3
       DIV BX
       CMP DX,0 
       JZ ATTACKs
       
       MOV BX,0fffH
       MOV DX,0
       MOV AX,COUNT3
       DIV BX
       CMP DX,0       
       JZ BEGINs
        
       MOV BX,07ffh
       MOV DX,0
       MOV AX,COUNT3
       DIV BX
       CMP DX,0  
       JZ MovingBariars
       jmp games
       
       attacks:
       CALL MOVEBARIARBULETS            
       MOV AX ,0
       MOV COUNT3,AX   
       
       BEGINs: 
       send '5'
       mov bx,score1
       send bl
       mov bx,score2
       send bl  
       SEND DATAX1
       SEND DATAX2
       SEND DATAXB
       SEND BULET11Y
       SEND BULET11X 
       
       SEND BULET12Y
       SEND BULET12X
       
       SEND BULET13Y
       SEND BULET13X
       
       SEND BULET14Y
       SEND BULET14X
       
       SEND BULET21Y
       SEND BULET21X
       
       SEND BULET22Y
       SEND BULET22X 
       
       SEND BULET23Y
       SEND BULET23X
       
       SEND BULET24Y
       SEND BULET24X
       
       SEND BULETb1Y
       SEND BULETb1X
       
       SEND BULETb2Y
       SEND BULETb2X 
       
       ;=======================RECIVE I/P FROM THE USER===========================================
        mov dx , 3FDH		; Line Status Register	
	    in al,dx 
  		AND al , 1
  		JZ fish2

 ;If Ready read the VALUE in Receive data register
  		mov dx , 3F8H
  		in al , dx
        mov actionkey,al
   
    fish2: 
       
       CALL CheckScore 
       CALL MAKEITLARGER
       CALL MOVEBULETS  
       CALL MoveSpecialBullet 
      
       MovingBariars:
      ; CALL RANDGEN
       CALL MoveBariar
       CALL CreatBariarBulet
       ConvertToDecimal SCORE1,SCOREPLY1
       
       ConvertToDecimal SCORE2,SCOREPLY2 
       MOVCURSOR 0204H 
       DISPLAYSTRING ply1name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY1
      
       MOVCURSOR 0230H
       DISPLAYSTRING PLy2name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY2
        mov ax,score1
        cmp ax,50D
        JZ WIN
        MOV AX,SCORE2
        CMP AX,50D
        JZ WIN 
      
      
       
;--------------------------------------------------;
;----------------- READ FROM USER -----------------;       
;--------------------------------------------------;                           
       GAMEs:
       MOV AH,1
       INT 16H
       CMP AH,1 ;CHECK IF THE USER DIDNT PUT ANYTHING
       JZ  Move1Rights 
       ;THIS STATEMENT TO EMPTY THE KEYBOARD BUFFER
       MOV AH,0 
       INT 16H
       JMP Move1Rights ; CHECK IF ITS RIGHT BOTTON
                                                  




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 1 RIGHT-----------------;
;-------------------------------------------------;
 
     Move1RIGHTs: 
       CMP AH,20H  ; check if the key RIGHT
       JNZ Move1Lefts ; if no jump to thE NEXT IF
       mov CX,0
       MOV CH,DATAY1
       MOV CL,DATAX1
       MOV SI,CX 
       MOV BL,SIZE1
       MOV AL,'_'
       ; check the border 
       cmp CL,75D
       jz checks          
       CALL MoveRight
       INC DATAX1 
       CALL DRAWPLAYER1   
       
       jmp Checks
                      




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 1 LEFT------------------;
;-------------------------------------------------;
                    
       Move1Lefts:   
       CMP AH,1EH  ; check if the key LEFT
       JNZ Move2RIGHTs   ; if no jump to the next if
       ;TO MAKE SURE WE DIDNT GET OUT THE BORDER
       MOV CH,DATAY1
       MOV CL,DATAX1
       MOV SI,CX
       MOV BL,SIZE1
       MOV AL,'_'
       ; check the border 
       cmp CL,0h
       jz checks
       CALL MoveLeft
       DEC DATAX1 
       CALL DRAWPLAYER1   
       
       jmp checks
                               





;-------------------------------------------------;      
;--------- TO MOVE PLAYER 2 RIGHT-----------------;
;-------------------------------------------------;
       Move2RIGHTs: 
       CMP ACTIONKEY,20H  ; check if the key RIGHT
       JNZ Move2Lefts ; if no jump to the next if
       ;TO GET THE ONE WE SHOULD DELETE
       MOV CH,DATAY2
       
       MOV CL,DATAX2
       MOV SI,CX
       MOV BL,SIZE2
       MOV AL,'_'
       ; check the border 
       cmp CL,74D
       jz checks
       CALL MoveRight 
       INC DATAX2    
        CALL DRAWPLAYER2
        
       jmp Checks
                              




;-------------------------------------------------;      
;--------- TO MOVE PLAYER 2 LEFT------------------;
;-------------------------------------------------;
                    
       Move2Lefts:   
       CMP ACTIONKEY,1EH  ; check if the key LEFT
       JNZ SHOOT1s   ; if no jump to the next if
       ;TO MAKE SURE WE DIDNT GET OUT THE BORDER
       MOV CH,DATAY2
       MOV CL,DATAX2
       MOV SI,CX
       MOV BL,SIZE2
       MOV AL,'_'
       ; check the border 
       cmp CL,0H
       jz checks
       CALL MoveLeft  
       DEC DATAX2 
        CALL DRAWPLAYER2
        
       jmp checks
      





;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER1-----------------;
;-------------------------------------------------;
                    
       
       SHOOT1s:   
         CMP AH,11H  ; check if the key LEFT
       JNZ SHOOT2s ; if no jump to the next if
       CALL CreatPlayer1Bulet
       jmp checks
       




;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER2-----------------;
;-------------------------------------------------;
                    
       SHOOT2s:   
       CMP ACTIONKEY,11H  ; check if the key LEFT
       JNZ SHOoTSR1 ; if no jump to the next if
       CALL CreatPlayer2Bulet                      
       jmp checks    


;--------------------------------------------------------;      
;-------- TO CREAT BULET LEFT SPECIAL PLAYER-------------;
;--------------------------------------------------------;
                    
      ;iNPUTS
      ; DL=DATAX 
      ; DH= DATAY
      ; CH = bulet13y
      ; CL = bulet13X
      ; BL = SIZE
      ; OUTPUTS 
      ; CH = bulet13y
      ; CL = bulet13X
       
       SHOOTSR1:   
       CMP AH,12H  ; check if the key LEFT
       JNZ SHOOTSL1 ; if no jump to the next if
       MOV DL,DATAX1
       MOV DH, DATAY1
       MOV CL,bulet13X
       MOV CH,bulet13y
       MOV BL,SIZE1 
       CALL CreatPlayer1SPECIALBulet
       MOV bulet13X,CL
       MOV bulet13y,CH
       jmp checks
       




;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER2-----------------;
;-------------------------------------------------;
                    
       SHOOTSL1:   
       CMP AH,10H  ; check if the key LEFT
       JNZ SHOOTSR2 ; if no jump to the next if
       MOV DL,DATAX1
       MOV DH, DATAY1
       MOV CL,bulet14X
       MOV CH,bulet14y
       MOV BL,SIZE1
       CALL CreatPlayer1SPECIALBulet
       MOV bulet14X,CL
       MOV bulet14y,CH
       jmp checks    
;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER1-----------------;
;-------------------------------------------------;
                    
       
       SHOOTSR2:   
       CMP ACTIONKEY,12H  ; check if the key LEFT
       JNZ SHOOTSL2 ; if no jump to the next if
       MOV DL,DATAX2
       MOV DH, DATAY2
       MOV CL,bulet23X
       MOV CH,bulet23y
       MOV BL,SIZE2
       CALL CreatPlayer2SPECIALBulet
       MOV bulet23X,CL
       MOV bulet23y,CH
          jmp checks
       




;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER2-----------------;
;-------------------------------------------------;
                    
       SHOOTSL2:   
       CMP ACTIONKEY,10H  ; check if the key LEFT
       JNZ pausexx2 ; if no jump to the next if
       MOV DL,DATAX2
       MOV DH, DATAY2
       MOV CL,bulet24X
       MOV CH,bulet24y
       MOV BL,SIZE2
       CALL CreatPlayer2SPECIALBulet
       MOV bulet24X,CL
       MOV bulet24y,CH
       jmp checks    
     
;-------------------------------------------------;      
;--------- TO PAUSE THE GAME ---------------------;
;-------------------------------------------------;
       PAUSEXX2:
       cmp actionkey,63d
       jz XXXXX2
       CMP AH,63D
       JNZ CloseProgramS
       XXXXX2:  
       SEND '8'
       CALL pauseX
       jmp checkS
       
      CloseProgramS:
       cmp actionkey,60d
       jz xxxxxx2
       CMP AH,60D
       JNZ CHECKS
       xxxxxx2:
       SEND '7'
       BreakpointS:
       CALL DEFUALT  
       jmp MAINMENUMODULE
;-------------------------------------------------;      
;--------- TO CLOSE THE GAME ---------------------;
;-------------------------------------------------;
          
       CloseProgram:
       cmp actionkey,60d
       jz xxxxxx
       CMP AH,60D
       JNZ CHECK
       xxxxxx:
       SEND '7'
       Breakpoint:
       CALL DEFUALT  
       jmp MAINMENUMODULE
;========================================================;
;==============WINNER CHECK =============================;
;========================================================;            
                                   
    WIN:  
    CLRSCR
    MOVCURSOR 1300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 0300H
    DISPLAYSTRING LINE
    
    MOVCURSOR 021DH
    DISPLAYSTRING GAMENAME
    
    MOVCURSOR 0d00H
    DISPLAYSTRING MAINMENUWON
    
    MOVCURSOR 0B00H
    DISPLAYSTRING THEWINNER
    
    MOV AX,SCORE1
    MOV BX,SCORE2
    CMP AX,BX
    JG  ONEWON
    JL  TWOWON
    ONEWON:
    DISPLAYSTRING PLY1NAME
    JMP ENDWIN 
    TWOWON:
    DISPLAYSTRING PLY2NAME 
    JMP ENDWIN 
    
    ENDWIN:
    KEYPRESSWAIT
    clrscr
    JMP Breakpoint
    
    
    
    
    
     

;========================================================;
;==============Exiting the dosbox========================;
;========================================================;       
   MEINENDGAME:

        mov dx , 3FDH		; Line Status Register
        AGAINEND:  	
        In al , dx 			;Read Line Status
  		AND al , 00100000b
  		JZ AGAINEND
        
;If empty put the VALUE in Transmit data register
  		mov dx , 3F8H		; Transmit data register
  		mov  al,01D
  		out dx , al 
   
   SEINENDGAME:
        clrscr
        movcursor 0000h
        MOV AH,4CH
        MOV AL,0
        MOV BH,0
        INT 21H     
       
       
     RECIVELVL1:
     RECY:
     CALL RECIVE
     CMP AL,'5'
     JNZ RECY
     
      CALL RECIVE
      MOV LVL,AL  
      cmp al,'2'
      jz RECIVELVL2
      call display
     
      SeinGameModule:
    
      CALL RECIVE
      CMP AL,'5'
      JZ OUTLOAD 
      CMP AL,'7'
      JZ BREAKPOINT
      cmp AL,'8'
      JZ pauseRECx
      JNZ seingamemodule
      OUTLOAD:
      
      CALL RECIVE 
      MOV AH,0
      MOV SCORE2,AX
    
      CALL RECIVE 
      MOV AH,0
      MOV SCORE1,AX
      
      CALL RECIVE 
      MOV DATAX1,AL
      call drawplayer1
      mov dl,datax1
      mov dh,datay1
      sub dl,4
      movcursor dx
      displaystring space4
      mov dl,datax1
      mov dh,datay1
      add dl,5
      movcursor dx
      displaystring space4 
      
      CALL RECIVE 
      MOV DATAX2,AL
       
      call drawplayer2
      mov dl,datax2
      mov dh,datay2
      sub dl,4
      movcursor dx
      displaystring space4
      mov dl,datax2
      mov dh,datay2
      add dl,5
       movcursor dx
      displaystring space4
      
      CALL RECIVE
      MOV DATAXB,AL
      call drawbariar
      mov dl,dataxb
      mov dh,datayb
      dec dl
      movcursor dx
      displaystring space
      mov dl,dataxb
      mov dh,datayb
      add dl,5
       movcursor dx
      displaystring space4  
      
      
      CALL RECIVE
      MOV  BULET11Y,AL
      CALL RECIVE
      MOV  BULET11X,AL
      
      
      CALL RECIVE
      MOV  BULET12Y,AL
      CALL RECIVE
      MOV  BULET12X,AL
      
      
      
      CALL RECIVE
      MOV  BULET21Y,AL
      CALL RECIVE
      MOV  BULET21X,AL
      
      CALL RECIVE
      MOV  BULET22Y,AL
      CALL RECIVE
      MOV  BULET22X,AL 
      
     mov dl,bulet11x
  		   
        mov dh,bulet11y
        cmp dh,pbulet11y
        jz at1
        movcursor dx
       
        displaystring star
        mov dl,pbulet11x
        mov dh,pbulet11y
        movcursor dx
        displaystring space1
        at1:
;  		
  	    mov dl,bulet12x 
        mov dh,bulet12y 
         cmp dh,pbulet12y
         jz at2
        movcursor dx
        
        displaystring star 
        mov dl,pbulet12x
        mov dh,pbulet12y
        movcursor dx
        displaystring space1	
  		
  		at2:
  		mov dl,bulet21x 
        mov dh,bulet21y
         cmp dh,pbulet21y
         jz at3
        movcursor dx 
        displaystring star
        mov dl,pbulet21x
        mov dh,pbulet21y
        movcursor dx
  		displaystring space1
  		at3:
  		
  		mov dl,bulet22x 
        mov dh,bulet22y
        cmp dh,pbulet22y
        jz at4
        movcursor dx 
        displaystring star
        mov dl,pbulet22x
        mov dh,pbulet22y
        movcursor dx
        displaystring space1
  		at4:
  		
  		;;swap
  		mov dl,bulet11x 
        mov pbulet11x,dl
        mov dh,bulet11y
        mov pbulet11y,dh
  		
  	   
  	    mov dl,bulet12x 
        mov pbulet12x,dl
        mov dh,bulet12y
        mov pbulet12y,dh
  		
  	    mov dl,bulet21x 
        mov pbulet21x,dl
        mov dh,bulet21y
        mov pbulet21y,dh
  		
        mov dl,bulet22x 
        mov pbulet22x,dl
        mov dh,bulet22y
        mov pbulet22y,dh
        
        ConvertToDecimal SCORE1,SCOREPLY1
       
        ConvertToDecimal SCORE2,SCOREPLY2 
        
       
       
       MOVCURSOR 0204H 
       DISPLAYSTRING ply1name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY1
      
       MOVCURSOR 0230H
       DISPLAYSTRING PLy2name
       DISPLAYSTRING SCORESTRN
       DISPLAYSTRING SCOREPLY2 
       MOVCURSOR 1300H       
       DISPLAYSTRING LINE
       MOVCURSOR 0000H
       DISPLAYSTRING SPACE1
        mov key,0
        KEYPRESSNOTWAIT
        jz seingamemodule 
        mov key,ah  
        consume 
        SEND KEY
      
        
        JMP SEINGAMEMODULE      
      
      
        pauseRECx:
    
        call pausex
        
        jmp seingamemodule 
       
     RECIVELVL2: 
     CALL DISPLAY
       
     SEINGAMEMODULE2:
     CALL RECIVE
     CMP AL,'5'
     JZ OUTLOADs
     CMP AL,'7'
     JZ BREAKPOINTs  
     CMP AL,'8'
     JZ PAUSERECX2  
     JNZ SEINGAMEMODULE2  
       
     OUTLOADS:
     CALL RECIVE
     MOV AH,0
     MOV SCORE2,AX
       
     CALL RECIVE
     MOV AH,0
     MOV SCORE1,AX  
      
      CALL RECIVE 
      MOV DATAX1,AL
      call drawplayer1
      
      mov dl,datax1
      mov dh,datay1
      sub dl,4
      
      movcursor dx
      displaystring space4
      mov dl,datax1
      mov dh,datay1
      
      add dl,size1
      inc dl
      movcursor dx
      displaystring space4 
      
      CALL RECIVE 
      MOV DATAX2,AL
       
      call drawplayer2
      mov dl,datax2
      mov dh,datay2
      sub dl,4
      movcursor dx
      displaystring space4
      mov dl,datax2
      mov dh,datay2
      add dl,size2
      inc dl
      movcursor dx
      displaystring space4
      
      CALL RECIVE
      MOV DATAXB,AL
      call drawbariar
      mov dl,dataxb
      mov dh,datayb
      sub dl,4
      movcursor dx
      displaystring space4
      mov dl,dataxb
      mov dh,datayb
      add dl,5
       movcursor dx
      displaystring space4 
      
       CALL RECIVE
      MOV  BULET11Y,AL
      CALL RECIVE
      MOV  BULET11X,AL
      
      
      CALL RECIVE
      MOV  BULET12Y,AL
      CALL RECIVE
      MOV  BULET12X,AL
     
       CALL RECIVE
      MOV  BULET13Y,AL
      CALL RECIVE
      MOV  BULET13X,AL
      
      
      CALL RECIVE
      MOV  BULET14Y,AL
      CALL RECIVE
      MOV  BULET14X,AL
      
      
         
         
      CALL RECIVE
      MOV  BULET21Y,AL
      CALL RECIVE
      MOV  BULET21X,AL
      
      CALL RECIVE
      MOV  BULET22Y,AL
      CALL RECIVE
      MOV  BULET22X,AL 
         
      CALL RECIVE
      MOV  BULET23Y,AL
      CALL RECIVE
      MOV  BULET23X,AL
      
      CALL RECIVE
      MOV  BULET24Y,AL
      CALL RECIVE
      MOV  BULET24X,AL  
       
      CALL RECIVE
      MOV  BULETB1Y,AL
      CALL RECIVE
      MOV  BULETB1X,AL
      
      CALL RECIVE
      MOV  BULETB2Y,AL
      CALL RECIVE
      MOV  BULETB2X,AL
      
      
        mov dl,bulet11x
  		 
        mov dh,bulet11y
        cmp dh,pbulet11y
        jz at11
        movcursor dx
       
        displaystring star
        mov dl,pbulet11x
        mov dh,pbulet11y
        movcursor dx
        displaystring space1 
        AT11:
        
        mov dl,bulet12x 
        mov dh,bulet12y 
        cmp dh,pbulet12y
        jz at22
        movcursor dx
        
        displaystring star 
        mov dl,pbulet12x
        mov dh,pbulet12y
        movcursor dx
        displaystring space1	
  		
  		at22:
        
          mov dl,bulet13x 
        mov dh,bulet13y 
        cmp dh,pbulet13y
        jz at33
        movcursor dx
        
        displaystring star 
        mov dl,pbulet13x
        mov dh,pbulet13y
        movcursor dx
        displaystring space1	
        
        AT33:
        
        mov dl,bulet14x 
        mov dh,bulet14y 
        cmp dh,pbulet14y
        jz at44
        movcursor dx
        
        displaystring star 
        mov dl,pbulet14x
        mov dh,pbulet14y
        movcursor dx
        displaystring space1	
        
        AT44:
        
        mov dl,bulet21x 
        mov dh,bulet21y 
        cmp dh,pbulet21y
        jz at55
        movcursor dx
        
        displaystring star 
        mov dl,pbulet21x
        mov dh,pbulet21y
        movcursor dx
        displaystring space1	
  		
  		at55:
        
          mov dl,bulet22x 
        mov dh,bulet22y 
        cmp dh,pbulet22y
        jz at66
        movcursor dx
        
        displaystring star 
        mov dl,pbulet22x
        mov dh,pbulet22y
        movcursor dx
        displaystring space1	
        
        AT66:
        
        mov dl,bulet23x 
        mov dh,bulet23y 
        cmp dh,pbulet23y
        jz at77
        movcursor dx
        
        displaystring star 
        mov dl,pbulet23x
        mov dh,pbulet23y
        movcursor dx
        displaystring space1	
        
        AT77:
        mov dl,bulet24x 
        mov dh,bulet24y 
        cmp dh,pbulet24y
        jz at88
        movcursor dx
        
        displaystring star 
        mov dl,pbulet24x
        mov dh,pbulet24y
        movcursor dx
        displaystring space1
        AT88:
        mov dl,buletB1x 
        mov dh,buletB1y 
       cmp dh,pbuletB1y
         jz at99
        movcursor dx
        
        displaystring star 
        mov dl,pbuletB1x
        mov dh,pbuletB1y
        movcursor dx
        displaystring space1	
  		
  		at99:
        
        
        mov dl,buletB2x 
        mov dh,buletB2y 
        cmp dh,pbuletB2y
        jz at10
        movcursor dx
        
        displaystring star 
        mov dl,pbuletB2x
        mov dh,pbuletB2y
        movcursor dx
        displaystring space1	
  		
  		at10:
        ;SWAP
        mov dl,bulet11x 
        mov pbulet11x,dl
        mov dh,bulet11y
        mov pbulet11y,dh
  		
  	   
  	    mov dl,bulet12x 
        mov pbulet12x,dl
        mov dh,bulet12y
        mov pbulet12y,dh
        
        mov dl,bulet13x 
        mov pbulet13x,dl
        mov dh,bulet13y
        mov pbulet13y,dh
  		
  	   
  	    mov dl,bulet14x 
        mov pbulet14x,dl
        mov dh,bulet14y
        mov pbulet14y,dh  
        
        
        mov dl,bulet21x 
        mov pbulet21x,dl
        mov dh,bulet21y
        mov pbulet21y,dh
  		
  	   
  	    mov dl,bulet22x 
        mov pbulet22x,dl
        mov dh,bulet22y
        mov pbulet22y,dh
        
        mov dl,bulet23x 
        mov pbulet23x,dl
        mov dh,bulet23y
        mov pbulet23y,dh
  		
  	   
  	    mov dl,bulet24x 
        mov pbulet24x,dl
        mov dh,bulet24y
        mov pbulet24y,dh        
        
        mov dl,buletB1x 
        mov pbuletB1x,dl
        mov dh,buletB1y
        mov pbuletB1y,dh
  		
  	   
  	    mov dl,buletB2x 
        mov pbuletB2x,dl
        mov dh,buletB2y
        mov pbuletB2y,dh         
        
        ConvertToDecimal SCORE1,SCOREPLY1
       
        ConvertToDecimal SCORE2,SCOREPLY2 
        
       
       
        MOVCURSOR 0204H 
        DISPLAYSTRING ply1name
        DISPLAYSTRING SCORESTRN
        DISPLAYSTRING SCOREPLY1
      
        MOVCURSOR 0230H
        DISPLAYSTRING PLy2name
        DISPLAYSTRING SCORESTRN
        DISPLAYSTRING SCOREPLY2 
        MOVCURSOR 1300H       
        DISPLAYSTRING LINE
        MOVCURSOR 0000H
        DISPLAYSTRING SPACE1
        mov key,0
        KEYPRESSNOTWAIT
        jz seingamemodule2 
        mov key,ah  
        consume 
        SEND KEY
       
        
        JMP SEINGAMEMODULE2      
      
      
        pauseRECx2:
    
        call pausex
        
        jmp SEINGAMEMODULE2 
        
        
        
        
        
        
        
        
    HLT
ENDP    

;-----------------------------------------------------------------------------------

;==================================================;
;====================== Proceduers ================;
;==================================================;
DEFUALT PROC  
  MOV AH,25H
  MOV DATAX1,AH
  MOV DATAX2,AH
  MOV DATAXB,AH
  
  MOV AH,12H
  MOV DATAY1,AH
  MOV AH,4H     
  MOV DATAY2,AH
  MOV AH,0BH
  MOV DATAYB,AH
  
  MOV AH,4
  MOV SIZE1,AH
  MOV SIZE2,AH
  MOV SIZEB,AH
  
  MOV AX,0
  MOV SCORE1,AX
  MOV SCORE2,AX
  MOV bulet11y,AH
  MOV bulet11X,AH
  MOV bulet12y,AH
  MOV bulet12X,AH
  MOV bulet21Y,AH
  MOV bulet21X,AH
  MOV bulet22Y,AH
  MOV bulet22X,AH
  MOV buletCount1,AH
  MOV buletCount2,AH
  MOV DELETEPAR,AX
   
  MOV AX,1 
  MOV X,AX
  
  
RET
ENDP
;==================================================;
;======================SCORE=======================;
;==================================================;
 CheckScore PROC
;==== for player one =====
; first bulet 
  MOV CH,bulet11y
  MOV CL,bulet11X
  CALL CheckPlayer1Score
 
  MOV CH,bulet12y
  MOV CL,bulet12X
  CALL CheckPlayer1Score
  
  MOV CH,bulet21y
  MOV CL,buleT21X
  CALL CheckPlayer2Score
  
  MOV CH,bulet22y
  MOV CL,bulet22X
  CALL CheckPlayer2Score
  
  
  MOV CH,bulet13y
  MOV CL,buleT13X
  CALL CheckPlayer1Score
  
  MOV CH,bulet14y
  MOV CL,bulet14X
  CALL CheckPlayer1Score
  
  
  MOV CH,bulet23y
  MOV CL,buleT23X
  CALL CheckPlayer2Score
  
  MOV CH,bulet24y
  MOV CL,bulet24X
  CALL CheckPlayer2Score

  
  MOV CH,buletB2y
  MOV CL,buletB2X
  CALL CheckPlayer1Score
  
  
  MOV CH,buletB1y
  MOV CL,buleTB1X
  CALL CheckPlayer2Score
  




ENDP
CheckPlayer1Score PROC
  
;---------BARIAR-------  
  MOV BL,DATAXB   
  DEC BL
  CMP CL,BL                        
  JL HISAPLAYER2  
  
  MOV BL,DATAXB   
  ADD BL,SIZEB
  INC BL
  CMP CL,BL
  JG HISAPLAYER2
  
  CMP CH,DATAYB
  JNZ HISAPLAYER2
  INC SCORE1 
  JMP NOTHING

;---------SECOND PLAYER------- 
  HISAPLAYER2:
  CMP CL,DATAX2
  JL NOTHING  
  MOV BL ,DATAX2   
  ADD BL,SIZE2
  CMP CL,BL
  JG NOTHING
  CMP CH,DATAY2
  JNZ NOTHING
  
  CALL DRAWPLAYER2
  MOV BX,SCORE2
  CMP BX,0
  JZ  NOTHING 
  
  DEC SCORE2  
  JMP NOTHING
 
   
  
  NOTHING:    
  RET
  
ENDP 

CheckPlayer2Score PROC
;---------BARIAR-------  
 
  MOV BL,DATAXB   
  DEC BL
  CMP CL,BL 
  JL HISAPLAYER1   
  
  MOV BL,DATAXB   
  ADD BL,SIZEB 
  INC BL
  CMP CL,BL
  JG HISAPLAYER1
  
  CMP CH, DATAYB
  JNZ HISAPLAYER1
  INC SCORE2 
  JMP NOTHING1

;---------SECOND PLAYER------- 
  HISAPLAYER1:
  CMP CL,DATAX1
  JL NOTHING1
    
  MOV BL ,DATAX1   
  ADD BL,SIZE1
  CMP CL,BL
  JG NOTHING1
   
  CMP CH, DATAY1
  JNZ NOTHING1
  
  CALL DRAWPLAYER1
  MOV BX,ScoRE1
  CMP BX,0
  JZ  NOTHING1
  DEC SCORE1
  JMP NOTHING1
  
  NOTHING1:
  RET
  
ENDP  





;==================================================;
;============ DRAWING =============================;
;==================================================;

;--------------------------------------------------;       
;---------------- Draw tHE BARIAR -----------------;       
;--------------------------------------------------;       
 DRAWBariar proc near
  ;CH = SIZE
  ;BL = DATAX1     
  ;DH = DATAY 
  ;AL = CHAR   
          MOV BH,0
          MOV AH,2H ; DRAW PIXEL
          MOV CL,0  ; THE COUNTER         
          ;put the x,y in dl ,dh
          MOV DL,DATAXb 
          MOV DH,DATAYb
          INT 10H     
          DISPLAYSTRING BARIAR
         
            ret
 DRAWBariar endp    






;--------------------------------------------------;       
;----------------Draw the 1st player---------------;       
;--------------------------------------------------;       
       
drawPlayer1 proc   
  
           MOV BH,0
          MOV AH,2H ; DRAW PIXEL
          MOV CL,0  ; THE COUNTER         
          ;put the x,y in dl ,dh
          MOV DL,DATAX1 
          MOV DH,DATAY1
          INT 10H   
          DISPLAYSTRING PLAYER1
          
          ret
          drawPlayer1 endp  





;--------------------------------------------------;       
;----------------Draw the 2ND player---------------;       
;--------------------------------------------------;         
   
drawPlayer2 proc   
  
          
          MOV BH,0
          MOV AH,2H ; DRAW PIXEL
          MOV CL,0  ; THE COUNTER
          ;put the x,y in dl ,dh
          MOV DL,DATAX2 
          MOV DH,DATAY2
          INT 10H           
          DISPLAYSTRING PLAYER2
         
          ret
          drawPlayer2 endp  
       






;==========================================================; 
;================= Creat The Bulet=========================;
;==========================================================;
;============= 1ST PLAYER BULET============================;
PROC CreatBariarBulet  
       mov DL,DATAXB 
       MOV DH,DATAYB
       MOV CH,buletB1Y
       MOV CL,buletB1X
       MOV BL,SIZEB
        
       MOV AL,BL
       SHR AL,1
       ADD AL,DL
      ;CHECK IF THE BULLET EXIST IF YES WE CANT MAKE ANOTHER 
       cmp CH,0                                     
       JNZ  PLAYER22
       ; IF IT IS IN THE RANGE OF THE PALYER1 
        CMP AL,DATAX1
        JL  PLAYER22 
        MOV BH,DATAX1   
        ADD BH,SIZE1
        CMP AL,BH
        JG  PLAYER22

       
       
       ;TO MAKE THE HALF OF THE SIZE
       ATTACKPLAYER1:
       shr BL,1          
       
       ; DETRMINE X 
       MOV CL,DL;WHERE DL= DATAX         
       add CL,BL ; INTO THE HALF OF THE BARIAR
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DH ;WHERE DH =THE SAME Y OF THE BARIAR
       INC CH        ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
      
       mov ah,2
       mov dl,4 ; the diamond
       int 21h     
  
       MOV buletB1Y,CH
       MOV buletB1X,CL
       
       
        PLAYER22:
      
       mov DL,DATAXB 
       MOV DH,DATAYB
       MOV CH,buletB2Y
       MOV CL,buletB2X
       MOV BL,SIZEB
       
       
       MOV AL,BL
       SHR AL,1
       ADD AL,DL
       
      ;CHECK IF THE BULLET EXIST IF YES WE CANT MAKE ANOTHER 
       cmp CH,0                                     
       JNZ  RETURNNNNNNNN
       ; IF IT IS IN THE RANGE OF THE PALYER2
        CMP AL,DATAX2
        JL  RETURNNNNNNNN 
        MOV BH,DATAX2   
        ADD BH,SIZE2
        CMP AL,BH
        JG  RETURNNNNNNNN

       
       
       ;TO MAKE THE HALF OF THE SIZE
       ATTACKPLAYER2:
       shr BL,1          
       
       ; DETRMINE X 
       MOV CL,DL;WHERE DL= DATAX         
       add CL,BL ; INTO THE HALF OF THE PLAYER
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DH ;WHERE DH =THE SAME Y OF THE PLAYER
       DEC CH        ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
      
       mov ah,2
       mov dl,4 ; the diamond
       int 21h      
       
       MOV buletB2Y,CH
       MOV buletB2X,CL
       
  RETURNNNNNNNN:         


ret
endp


PROC CreatPlayer1Bulet  
 ; AL = BULET COUNT 
    
       ; MAKE SURE ITS NOT MORE THAN MAX
       mov BL,buletCount1
       CMP BL,2  ; 2 IS THE MAX NUM OF BULLETS
       JGE EXIT2  
       
       
       ;half size  
       MOV BL,SIZE1
       shr BL,1          
       
       ; DETRMINE X 
       MOV CL,DATAX1           
       add CL,BL ; INTO THE HALF OF THE PLAYER
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DATAY1 ;THE SAME Y OF THE PLAYER
       DEC CH        ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
                   
      
         
       mov BL,buletCount1
       CMP BL,0 ;  WHETHER ITS THE FIRST BULET
       jz FIRST   
       ;IF COUNT = 1 Check if THE SECOND bulet there 
       MOV BH,bulet12y
       CMP BH,0
       JNZ FIRST
       ; HERE WE R SURE THAT BULET 1 IS THERE SO WE ADD 2   
       inc buletCount1 ; INCREMENT       
       ;WE DETERMINE THE CORDINATES  of the bulet
       MOV bulet12y, CH 
       MOV bulet12x, CL     
       JMP show ; TO CREAT IT IN THE SCREEN
       
       FIRST: 
       inc buletCount1  ; INCREMENT
       ;WE DETERMINE THE CORDINATES  of the bulet
       MOV bulet11y, CH            
       MOV bulet11x, CL
 
       
       show:
       mov ah,2
       mov dl,4 ; the diamond
       int 21h     
        
       EXIT2:
       RET
       
ENDP    CreatPlayer1Bulet

CreatPlayer1SPECIALBulet  PROC
       
      ;iNPUTS
      ; DL=DATAX 
      ; DH= DATAY
      ; CH = bulet13y
      ; CL = bulet13X
      ; BL = SIZE
      ; OUTPUTS 
      ; CH = bulet13y
      ; CL = bulet13X
                            
       
       cmp CH,0
       JNZ RETURNNNNN
       
       ;TO MAKE THE HALF OF THE SIZE
       shr BL,1          
       
       ; DETRMINE X 
       MOV CL,DL;WHERE DL= DATAX         
       add CL,BL ; INTO THE HALF OF THE PLAYER
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DH ;WHERE DH =THE SAME Y OF THE PLAYER
       DEC CH        ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
      
       mov ah,2
       mov dl,4 ; the diamond
       int 21h     
       
 RETURNNNNN: 
  
  RET
  ENDP

CreatPlayer2SPECIALBulet  PROC
       
      ;iNPUTS
      ; DL=DATAX 
      ; DH= DATAY
      ; CH = bulet13y
      ; CL = bulet13X
      ; BL = SIZE
      ; OUTPUTS 
      ; CH = bulet13y
      ; CL = bulet13X
                            
       
       cmp CH,0
       JNZ RETURNNNNN1
       
       ;TO MAKE THE HALF OF THE SIZE
       shr BL,1          
       
       ; DETRMINE X 
       MOV CL,DL;WHERE DL= DATAX         
       add CL,BL ; INTO THE HALF OF THE PLAYER
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DH ;WHERE DH =THE SAME Y OF THE PLAYER
       INC CH        ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
      
       mov ah,2
       mov dl,4 ; the diamond
       int 21h     
       
 RETURNNNNN1: 
  
  RET
  ENDP





;====================================;
;============= 2ND PLAYER BULET======;
;====================================;
PROC CreatPlayer2Bulet  
 ; AL = BULET COUNT 
    
       ; MAKE SURE ITS NOT MORE THAN MAX
       mov BL,buletCount2
       CMP BL,2  ; 2 IS THE MAX NUM OF BULLETS
       JGE HisaEXIT3 
       
       ;half size  
       MOV BL,SIZE2
       shr BL,1          
       
       
       ; DETRMINE X 
       MOV CL,DATAX2           
       add CL,BL ; INTO THE HALF OF THE PLAYER
       MOV DL,CL
       ; DETRMINE Y
       MOV CH,DATAY2 ;THE SAME Y OF THE PLAYER
       INC CH       ; LESS BECAUSE ITS UP 
       mov DH,CH
       ;move curses 
       MOV BH,0 
       mov ah,2 
       int 10h    
                   
      
         
       mov BL,buletCount2
       CMP BL,0 ;  WHETHER ITS THE FIRST BULET
       jz FIRST1   
       ;IF COUNT = 1 Check if THE SECOND bulet there 
       MOV BH,bulet22y
       CMP BH,0
       JNZ FIRST1
       ; HERE WE R SURE THAT BULET 1 IS THERE SO WE ADD 2   
       inc buletCount2 ; INCREMENT       
       ;WE  DETERMINE THE CORDINATES  of the bulet
       MOV bulet22y, CH 
       MOV bulet22x, CL     
       JMP show1 ; TO CREAT IT IN THE SCREEN
                      
       FIRST1: 
       inc buletCount2  ; INCREMENT
       ;WE DETERMINE THE CORDINATES  of the bulet
       MOV bulet21y, CH            
       MOV bulet21x, CL
 
       
       show1:
       mov ah,2
       mov dl,4 ; the diamond
       int 21h     
        
       HisaEXIT3:
       RET
       
ENDP    CreatPlayer1Bulet                            








;==================================================;
;================== MOVING proceduers =============;
;==================================================; 





;--------------------- MOVE THE BARIAR ------------;
;--------------------------------------------------;
MoveBariar proc near
        ;PUSHA                           
      ; WAITT 0001H,86A0H
      ; POPA        
       MoveBAriarRIGHT: 
       MOV CL,DATAXb
       ADD CL,SIZEb
       mov si,x
       cmp si,0 
       JZ moveBAriarleft
       CMP CL,4EH  ; THE WIDTH OF SCREEN       
       JZ moveBAriarleft
       moveBAriarRightx:  
       mov si,1   
       mov x,si
 ; const (datax for up or datay for left) = CL
 ; var (datax for left or datay for UP)   = CH
 ; size = Bl
 ; char = AL   
  
       MOV CH,DATAYb
       MOV CL,DATAXb 
       MOV SI,CX
       MOV Bl,SIZEb
       MOV AL,'.' 
       CALL MoveRight
       INC DATAXb 
       CALL DRAWBARIAR  
       
       
        mov SI,X 
        CMP SI,1
        JZ RETURN
       MoveBAriarLeft:   
       MOV CL,DATAXb
       CMP CL,1H       
       jz moveBAriarRightx
       mov si,0
       mov x,si                  
 ; const (datax for up or datay for left) = CL
 ; var (datax for left or datay for UP)   = CH
 ; size = Bh
 ; char = AL   
       MOV CL,DATAXb
       MOV CH,DATAYb
       MOV SI,CX
       MOV BL,SIZEb
       MOV AL,'.' 
       Call MoveLeft
       DEC DATAXb 
       CALL DRAWBARIAR    
           RETURN:
            ret
endp 




;======================================================;
;==================== MOVE ALL THE BULETS==============;  
;======================================================;
proc MoveSpecialBullet 

; DI = 1,2,3,4,5,6 WHEATHER IT'S  UP OR DOWN OR 
; DOWNRIGHT OR DOWNLEFT OR UPRIGHT OR UPLEFT  
     
     
     MOV CX,0
     mov DELETEPAR,CX
     Mov CH,bulet13y
     Mov CL,bulet13X  
     ;CHECK THE BORDER 
     CMP CL,4EH
     JNZ UPRIGHT11
    
     
     UPLEFTT11:
     MOV BP,1
     MOV HIT13,BP
     MOV DI,6  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UPLEFT)
     CALL MoveBulets1
     JMP CONTINUE11 
     
     UPRIGHT11:
  
     MOV BP, HIT13
     CMP BP,1
     JZ UPLEFTT11
     MOV DI,5  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UP)
     CALL MoveBulets1
     
     CONTINUE11: 
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ FirstPlayerS2nd                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementS11 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet13y,CH 
     MOV bulet13X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     MOV HIT13,CX
     Jmp FirstPlayerS2nd
    
     decrementS11: 
     dec bulet13y
    
     CMP DI,5
     JZ INCx
     DEC bulet13X  
     JMP FirstPlayerS2nd
     INCx:
     INC bulet13X
;---------------THE LEFT BULLET FIRST PLAYER----------------
     FirstPlayerS2nd:
     MOV CX,0
     mov DELETEPAR,CX
    
     Mov CH,bulet14y
     Mov CL,bulet14X  
     ;CHECK THE BORDER 
     CMP CL,1
     JNZ UPLEFTT12
     
     
     UPRIGHT12:
     MOV DI,5  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UP)
     MOV BP,1
     MOV HIT14,BP
     
     CALL MoveBulets1
     
     JMP CONTINUE12 
     
     
     UPLEFTT12:
     MOV BP, HIT14
     CMP BP,1
     JZ UPRIGHT12
  
     MOV DI,6  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UPLEFT)
     CALL MoveBulets1
     
     
     CONTINUE12: 
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ SECONDPlayerS1ST                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementS12 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet14y,CH 
     MOV bulet14X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     MOV HIT14,CX
     Jmp SECONDPlayerS1ST
    
     decrementS12: 
     dec bulet14y
    
     CMP DI,5
     JZ INCx12
     DEC bulet14X  
     JMP SECONDPlayerS1ST
     INCx12:
     INC bulet14X
 
;-------------sECOND PLAYER RIGHTBULET----------
; DI = 1,2,3,4,5,6 WHEATHER IT'S  UP OR DOWN OR 
; DOWNRIGHT OR DOWNLEFT OR UPRIGHT OR UPLEFT  
    SECONDPlayerS1ST:
     MOV CX,0
     mov DELETEPAR,CX
     
     Mov CH,bulet23y
     Mov CL,bulet23X  
     ;CHECK THE BORDER 
     CMP CL,4EH
     JNZ DOWNRIGHT11
    
     MOV BP,1
     MOV HIT23,BP
     
     DOWNLEFTT11:
     MOV DI,4  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE DOWN LEFT)
     CALL MoveBulets1
     JMP CONTINUE21 
     
     DOWNRIGHT11:
  
     MOV BP, HIT23
     CMP BP,1
     JZ DOWNLEFTT11
     MOV DI,3  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE DOWN RIGHT)
     CALL MoveBulets1
     
     CONTINUE21: 
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ SECONDPlayerS2nd                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementS21 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet23y,CH 
     MOV bulet23X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     MOV HIT23,CX
     Jmp SECONDPlayerS2nd
    
     decrementS21: 
     INC bulet23y
    
     CMP DI,3
     JZ INCx21
     DEC bulet23X  
     JMP  SECONDPlayerS2nd
     INCx21:
     INC bulet23X
;---------------THE LEFT BULLET SECOND PLAYER----------------
     SECONDPlayerS2nd:
     MOV CX,0
     mov DELETEPAR,CX
     
     Mov CH,bulet24y
     Mov CL,bulet24X  
     ;CHECK THE BORDER 
     CMP CL,1
     JNZ DOWNLEFTT12
     
     
     DOWNRIGHT12:
     MOV DI,3  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE DOWN RIGHT)
     MOV BP,1
     MOV HIT24,BP
     CALL MoveBulets1     
     JMP CONTINUE22 
     
     
     DOWNLEFTT12:
     MOV BP, HIT24
     CMP BP,1
     JZ DOWNRIGHT12
  
     MOV DI,4  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UPLEFT)
     CALL MoveBulets1
     
     
     CONTINUE22: 
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ EXITTT                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementS22 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet24y,CH 
     MOV bulet24X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     MOV HIT24,CX
     Jmp EXITTT
    
     decrementS22: 
     INc bulet24y
    
     CMP DI,3
     JZ INCx22
     DEC bulet24X  
     JMP  EXITTT
     INCx22:
     INC bulet24X


  
  
  
     EXITTT:
  
  ret 
  endp



PROC MoveBulets
     ;CHECK IF THE THERE IS BULETS FOR THE 1st PLAYER
       ;PUSHA                           
       ;WAITT 0003H,0D090H
      ; POPA   
      MOV CH,0
      Mov CL,0 
      mov DELETEPAR,CX

     MOV CL,BuletCount1
     CMP CL,0    
     JZ SecondPlayer


;------------------ 1ST PLAYER 1ST BULET ----------------               
     Mov CH,bulet11y
     Mov CL,bulet11X 
     MOV DI,1  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UP)
     CALL MoveBulets1
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ FirstPlayer2nd                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrement1X ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet11y,CH 
     MOV bulet11X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     dec buletCount1
     Jmp FirstPlayer2nd
    
     decrement1X: 
     dec bulet11y




;------------------ 1ST PLAYER 2ND BULET ----------------     
     FirstPlayer2nd:
      MOV CH,0
      Mov CL,0 
      mov DELETEPAR,CX

     Mov CH,bulet12y
     Mov cL,bulet12X 
     MOV DI,1  ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UP)
     CALL MoveBulets1
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ SecondPlayer
     
     ;in case of delete the deletepar = 1     
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrement2; if not continue 
  
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0 
     Mov CL,0
     MOV bulet12y,CH
     MOV bulet12X,CH                
     mov DELETEPAR,CX  ; the delete par returuns to 0
     dec buletCount1
     Jmp SecondPlayer
     
     decrement2: 
     dec bulet12y



;------------------ 2ND PLAYER 1ST BULET ----------------     
     SecondPlayer: 
     ;CHECK IF THE THERE IS BULETS FOR THE 2nd PLAYER
      MOV CH,0
      Mov CL,0 
      mov DELETEPAR,CX

     MOV CL, BuletCount2
     CMP CL ,0 
     JZ EXit 
      
     Mov CH,bulet21y
     Mov cL,bulet21X
     MOV DI,2    ; TO DETRMINE THAT ITS PLAYER two (MOVE down)
     CALL MoveBulets1 
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ SecondPlayer2nd
     
     ;in case of delete the deletepar = 1
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ increment1 ;if not continue
     
     ; in case of delete we put x and y for bullet = 0
     MOV CH,0
     Mov CL,0
     MOV bulet21y,CH
     MOV bulet21X,CH                
     mov DELETEPAR,CX  ; the delete par returuns to 0
     dec buletCount2
     Jmp SecondPlayer2nd
     
     increment1: 
     inc bulet21y





;------------------ 2nd PLAYER 2nd BULET ----------------     
     SecondPlayer2nd:
     MOV CH,0
     Mov CL,0 
     mov DELETEPAR,CX

     Mov CH,bulet22y
     Mov cL,bulet22X
     MOV DI,2  ; TO DETRMINE THAT ITS PLAYER two (MOVE down)
     CALL MoveBulets1 
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ  EXIT
     
     ;in case of delete the deletepar = 1
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ increment2 
          
     ; in case of delete we put x and y for bullet = 0
     MOV CH,0
     Mov CL,0
     MOV bulet22y,CH
     MOV bulet22X,CH                
     mov DELETEPAR,CX  ; the delete par returuns to 0
     dec buletCount2
     Jmp EXIT
     
     increment2: 
     inc bulet22y
    Exit:
    MOV CH,0
    Mov CL,0 
    mov DELETEPAR,CX
    ret
    endp MOveBulets 






;----------------------------------------------------------
PROC MoveBulets1
; CH = DATAY
; CL = DATAX
; DI = 1,2,3,4,5,6 WHEATHER IT'S  UP OR DOWN OR 
; DOWNRIGHT OR DOWNLEFT OR UPRIGHT OR UPLEFT 
;-----------------------------------------
;--------- CHECK ITS THERE ---------------
;------------------------------------------
  ;IF BULLET Y=0 THAT MEAN ITS NOT THERE
    cmp CH,0 
    JZ NotThere
;---------------------------------------------     
;----------- CHECK IF IT MUST disapear ------- 
;--------------------------------------------
;-------------- THE BORDER -----------------
    CMP CH,4H
    JZ DELETE
    CMP CH,12H
    JZ DELETE  
;-------------- THE BARIAR ----------------------   
   ; MUST BE IN THE RANGE OF DATAX < X < DATAX + SIZE
   MOV AL,DATAXB
   DEC AL 
   CMP CL,AL 
   JL PLAYER1CHECK 
          
   MOV AL,DATAXB 
   add aL,SizeB  
   INC AL
   CMP CL,AL ; AL = DATAX +SIZE  
   JG PLAYER1CHECK  
   ;MUST Y =  DATAYB 
   CMP CH, DATAYB
   JZ DELETE
;-----------the 1st player----------------
   PLAYER1CHECK:
   CMP CL,DATAX1 
   JL PLAYER2CHECK       
   MOV AL,DATAX1 
   add aL,Size1
   CMP CL,AL ; AL = DATAX +SIZE  
   JG PLAYER2CHECK  
   ;MUST Y =  DATAYB
   CMP CH,DATAY1  
   JZ DELETE ; NORMAL MOVE    


;-----------the 2nd player----------------
   PLAYER2CHECK:
   CMP CL,DATAX2 
   JL MOVE        
   MOV AL,DATAX2 
   add aL,Size1
   CMP CL,AL ; AL = DATAX +SIZE  
   JG MOVE  
   ;MUST Y =  DATAYB
   CMP CH,DATAY2  
   JNZ MOVE ; NORMAL MOVE    

   DELETE: 
   ; MOVE CURSEL TO THE BULET    
  
   MOV AH,2
   MOV BH,0
   MOV DX,CX 
   INT 10H
   ;DRAW SPACE 
   MOV AH,2
   MOV DL,' ' 
   INT 21H  
   ;MAKE DELETEPAR = 1 TO SHOW THAT IT HAS DELETED
   MOV BP,1
   MOV DeletePar,BP
    call drawplayer1
   call drawplayer2
   JMP EXIT1
   
        
   MOVE:
 ; size = BL
 ; char = AL    
 ; SI= YY XX
  
  ;MOVE THE NEEDED PARAMETER TO CALL MOVE    
   MOV BL,1
   MOV AL,4
   MOV SI,CX
  ; IF DI PLAYER1  
   CMP DI,1
   JNZ DOWN
   CALL MoveUP
   JMP EXIT1  
   
   DOWN:
   CMP DI,2
   JNZ DOWNRIGHT
   CALL MoveDOWN
   JMP EXIT1  
   
   DOWNRIGHT:
   CMP DI,3
   JNZ DOWNLEFT
   CALL MoveDOWNRIGHT
   JMP EXIT1  
   
   DOWNLEFT:
   CMP DI,4
   JNZ UPRIGHT
   CALL MoveDOWNLEFT
   JMP EXIT1  
   
    UPRIGHT:
   CMP DI,5
   JNZ UPLEFT 
   CALL MoveUPRIGHT
   JMP EXIT1  
   
   UPLEFT:
   CMP DI,6
   JNZ EXIT1
   CALL MoveUPLEFT
   JMP EXIT1  
   
   NotThere: 
   ;MAKE DELETEPAR = 1 TO SHOW THAT IT HAS DELETED
   MOV BP, 2
   MOV DeletePar,BP
   
 
  EXIT1:
 ret
endp MOveBulets1
;===========================================================
MOVEBARIARBULETS PROC 
  
     MOV SI,0
     MOV DELETEPAR,SI
     
     Mov CH,buletB1y
     Mov CL,buletB1X 
     MOV DI,2 ; TO DETRMINE THAT ITS PLAYER ONE (MOVE DOWN)
     CALL MoveBulets1
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ BARIAR2nd                       
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementTT ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV buletB1y,CH 
     MOV buletB1X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     Jmp  BARIAR2nd
    
     decrementTT: 
     INC buletB1y

;----------------ATTACK SECOND PLAYER---------------
     BARIAR2nd:
     MOV SI,0
     MOV DELETEPAR,SI
     
     Mov CH,buletB2y
     Mov CL,buletB2X 
     MOV DI,1 ; TO DETRMINE THAT ITS PLAYER ONE (MOVE UP)
     CALL MoveBulets1
     
     ; THAT MEAN IT DOESNOT EXIST
     MOV SI,DELETEPAR
     CMP SI,2
     JZ EXITTTTT1                      
     
     ;in case of delete the deletepar = 1    
     MOV SI,DELETEPAR
     CMP SI,1
     JNZ decrementTT1 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV buletB2y,CH 
     MOV buletB2X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     Jmp  EXITTTTT1
    
     decrementTT1: 
     DEC buletB2y

  EXITTTTT1:
  RET 
  ENDP






;----------------------------------------;
;---------------- MOVE LEFT -------------;
;----------------------------------------;

MoveLeft proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX 
      
          MOV BH,0
          mov ah,2   
          MOV DX,SI
          add dl,bL
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV DL,' '
          INT 21H
          
          ret 
endp  



;----------------------------------------;
;---------------- MOVE RIGHT ------------;
;----------------------------------------;

MoveRight proc    
 ; const (datax for down or datay for right) = cL
 ; var (datax for right or datay for down)   = cH
 ; size = bL
 ; char = AL       
 ; SI = YY XX
        
                               
         
      
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV AH,2H ; DRAW PIXEL
          MOV DX,SI
          MOV BH,0
          INT 10H   
          ;the deleting (space drawing)
          mov ah,2  
          MOV DL,' '
          INT 21H
          ret 
endp




;----------------------------------------;
;---------------- MOVE UP ---------------;
;----------------------------------------;


MoveUp proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX
        
          MOV AH,2H ; DRAW PIXEL
          mov bh,0        
          ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD MOVE TO
          MOV DX,SI ; THE DATA THAT WILL BE CHANGED WITH TIME
          dec dh 
          INT 10H
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,AL; DRAW THE SELECTED CHAR IN AL
          INT 21H   
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV DX,SI
          add dh,bL
          dec dh  
          MOV BH,0
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV Dl,' '
          INT 21H 
          ret 
endp  MoveUp                     





;-----------------------------------------------;
;--------------- MOVE DOWN----------------------;
;-----------------------------------------------;
MoveDown proc    
 ; const (datax for down or datay for right) = cL
 ; var (datax for right or datay for down)   = cH
 ; size = bL
 ; char = AL       
 ; SI = YY XX
        
                  
         
         
          ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD
          MOV BH,0
          MOV AH,2H ; DRAW PIXEL
          MOV DX,SI  ; DX CONTAIN THE COORIDNATES
          add dH,bL  ; the one we want to add          
          INT 10H  
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,AL; DRAW THE SELECTED CHAR IN AL
          INT 21H 
          MOV BH,0  
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV AH,2H ; DRAW PIXEL
          MOV DX,SI
          INT 10H   
          ;the deleting (space drawing)
          mov ah,2  
          MOV DL,' ' 
          INT 21H
          ret 
 endp MoveDown  
   

MoveUpRIGHT proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX
 ;DEC BALLY
 ;INC BALLX
                
          MOV AH,2H ; DRAW PIXEL
          mov bh,0        
          ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD MOVE TO
          MOV DX, SI
          dec dh
          INC DL  
          INT 10H
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,4; DRAW THE SELECTED CHAR IN AL
          INT 21H   
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV DX,SI
          MOV BH,0
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV Dl,' '
          INT 21H 
          ret 
endp  MoveUpRIGHT                     

MoveUpLEFT proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX
 ; DEC BALLY
 ; DEC BALLX
                 
          MOV AH,2H ; DRAW PIXEL
          mov bh,0        
          ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD MOVE TO
          MOV DX,SI
          dec dh
          DEC DL 
          INT 10H
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,4; DRAW THE SELECTED CHAR IN AL
          INT 21H   
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV DX,SI
          MOV BH,0
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV Dl,' '
          INT 21H 
          ret 
endp  MoveUpLEFT

MoveDOWNRIGHT proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX
 ; INC BALLY
 ; INC BALLX
               
          MOV AH,2H ; DRAW PIXEL
          mov bh,0        
          ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD MOVE TO
          MOV DX,SI
          INc dh
          INC DL 
          INT 10H
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,4; DRAW THE SELECTED CHAR IN AL
          INT 21H   
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV DX,SI
          MOV BH,0
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV Dl,' '
          INT 21H 
          ret 
endp  MoveDOWNRIGHT

MoveDOWNLEFT proc              
 ; size = BL
 ; char = AL    
 ; SI= YY XX
 ; INC BALLY
 ; DEC BALLX
               
          MOV AH,2H ; DRAW PIXEL
          mov bh,0        
         ;MOVE THE CURSE TO THE PLACE WHER WE SHOULD MOVE TO
          MOV DX,SI
          INc dh
          DEC DL 
          INT 10H
          ; DRAW THE SELECTED CHAR 
          mov ah,2  
          MOV DL,4; DRAW THE SELECTED CHAR IN AL
          INT 21H   
          ;MOVE THE CURSE TO THE PLACE WHEre we should delete
          MOV DX,SI 
          MOV BH,0
          INT 10H 
          ;the deleting (space drawing)
          mov ah,2  
          MOV Dl,' '
          INT 21H 
          ret 
endp  MoveDOWNLEFT

 
 large proc 
; DI = OFFSET PLAYER
; CL = SIZE

        mov bx, DI
        add bL,CL
        MOV SI,BX
        INC SI
        INC SI 
  ; AL TEMP           
        MOV AL, [BX]
        MOV [SI],AL 
  ;MOVE THE OOO 
        MOV AL,'O' 
        MOV [BX],AL
        MOV [BX+1],AL
  
  ; HALF OF THE SIZE
        MOV AX,0
        MOV AL,CL    ; CL=SIZE
        SHR AL,1
  
  ; DI IS OFFSET
        mov bx,DI 
        ADD BL,AL
  ; GO TO THE HALF OF THE 
        MOV SI,BX
        INC SI
  ; AL TEMP           
        MOV AL, [BX]
        MOV [SI],AL
 
  ;MOVE THE OOO  
        MOV AL,'O' 
        MOV [BX],AL
        MOV [BX-1],AL
  
      RET
 
 endp   
MAKEITLARGER PROC

        MOV SI,SCORE1
        CMP SI,5
        JZ PAR5CHECK

        MOV SI,SCORE1
        CMP SI,10
        JZ PAR10CHECK

        MOV SI,SCORE1
        CMP SI,15
JZ PAR15CHECK

        MOV SI,SCORE1
        CMP SI,18
        JZ PAR18CHECK

        MOV SI,SCORE1
        CMP SI,19
        JZ PAR19CHECK
JMP sECONDPLAYEER

PAR5CHECK:
        MOV SI,SCORE1PAR
        CMP SI,0
        JNZ RETURN 
        MOV SI,1
        MOV SCORE1PAR,SI
JMP LARGER

PAR10CHECK:
        MOV SI,SCORE1PAR
        CMP SI,1
JNZ RETURN 
        MOV SI,2
        MOV SCORE1PAR,SI
JMP LARGER

PAR15CHECK:
        MOV SI,SCORE1PAR
        CMP SI,2
JNZ RETURN 
        MOV SI,3
        MOV SCORE1PAR,SI
JMP LARGER

PAR18CHECK:
        MOV SI,SCORE1PAR
        CMP SI,3
JNZ RETURN 
        MOV SI,4
        MOV SCORE1PAR,SI
JMP LARGER

PAR19CHECK:
        MOV SI,SCORE1PAR
        CMP SI,4
JNZ RETURN 
        MOV SI,5
        MOV SCORE1PAR,SI
JMP LARGER

LARGER:
        MOV DI,OFFSET PLAYER1
        MOV CL,SIZE1     
        CALL large 
        INC SIZE1
        INC SIZE1
        DEC DATAX1
;=============================================
;==========SECOND PLAYER LARGE================
sECONDPLAYEER:

        MOV SI,SCORE2
        CMP SI,5
JZ PAR25CHECK

        MOV SI,SCORE2
        CMP SI,10
JZ PAR210CHECK

        MOV SI,SCORE2
        CMP SI,15
JZ PAR215CHECK

        MOV SI,SCORE2
        CMP SI,18
JZ PAR218CHECK

        MOV SI,SCORE2
        CMP SI,19
JZ PAR219CHECK

JMP RETURN2222

PAR25CHECK:
        MOV SI,SCORE2PAR
        CMP SI,0
JNZ RETURN 
        MOV SI,1
        MOV SCORE2PAR,SI
JMP LARGER2

PAR210CHECK:
        MOV SI,SCORE2PAR
        CMP SI,1
JNZ RETURN 
        MOV SI,2
        MOV SCORE2PAR,SI
JMP LARGER2

PAR215CHECK:
        MOV SI,SCORE2PAR
        CMP SI,2
JNZ RETURN 
        MOV SI,3
        MOV SCORE2PAR,SI
JMP LARGER2

PAR218CHECK:
        MOV SI,SCORE2PAR
        CMP SI,3
JNZ RETURN 
        MOV SI,4
        MOV SCORE2PAR,SI
JMP LARGER2

PAR219CHECK:
        MOV SI,SCORE2PAR
        CMP SI,4
JNZ RETURN 
        MOV SI,5
        MOV SCORE2PAR,SI
JMP LARGER2

LARGER2:
        MOV DI,OFFSET PLAYER2
        MOV CL,SIZE2     
CALL large 
INC SIZE2
INC SIZE2
DEC DATAX2
JMP RETURN2222


RETURN2222:  
RET  
ENDP


RANDGEN PROC         ; generate a rand no using the system time

   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      
                ; lets just take the lower bits of DL for a start..
   MOV BH, 74   ; set limit to 57 (ASCII for 9) 
   MOV AH, DL  
   CMP AH, BH   ; compare with value in  DL,      
   JA returnnn1 ; if more, regenerate. if not, continue... 

   MOV BH, 2   ; set limit to 48 (ASCII FOR 0)
   MOV AH, DL   
   CMP AH, BH   ; compare with value in DL
   JB returnnn1 ; if less, regenerate.
   
   call deleteBariar 
   MOV DATAXB,DL
   CALL DRAWBARIAR
   
   returnnn1:
    RET
    ENDP 

deleteBariar  proc


    mov dl,dataxb  
    mov dh,datayb  
    mov bh,0
    mov ah,2
    int 10h
  
    mov si,5
    mov dl,' '
    mov ah,2

loopd:

        int 21h

        dec si
        cmp si,0
jnz loopd


  

ret
endp  
 
;-----------------------------------------------;
;--------------- Pausing the game---------------;
;-----------------------------------------------;  
  pausex proc
    clrscr ;;;here we clear the screen
    ;;;here we draw the screen elements (gamename,player names and scores,boarderS)        
    
    MOVCURSOR 011DH 
    DISPLAYSTRING GAMENAME
    
    MOVCURSOR 0204H 
    DISPLAYSTRING PLY1NAME
    DISPLAYSTRING SCORESTRN
    DISPLAYSTRING SCOREPLY1
    
    MOVCURSOR 0230H
    DISPLAYSTRING PLY2NAME
    DISPLAYSTRING SCORESTRN
    DISPLAYSTRING SCOREPLY2 
    
    MOVCURSOR 0224H
    DISPLAYSTRING LEVELMSG
    DISPLAYSTRING LVL
    
    MOVCURSOR 0300H
    DISPLAYSTRING LINE  
    
    MOVCURSOR 1300H
    DISPLAYSTRING LINE 
    
    movcursor 0c05h
    displaystring pause  
    
    MOVCURSOR 1400H
    DISPLAYSTRING PLY1NAME
    DISPLAYSTRING TOO
    
    GETCRUSOR
    MOV GETSEND,DX
    MOV sendcursorINLINE,DX
    MOVCURSOR 1600H
    DISPLAYSTRING PLY2NAME
    DISPLAYSTRING TOO
    
    GETCRUSOR
    MOV GETREC,DX
    MOV RECIVECURSORINLINE,DX
    
    
    KEYBOARDINLINE:
    keypressnotwait 
    
    
   ;;;;;;;;;;;Edit here 
    
    jz recivein
    jnz sendin  
    
    sendin:
    
     mov valueINLINE,al
     MOV AX,SENDCURSORINLINE 
     CMP VALUEINLINE,13D
     JZ Enterinline
     CMP VALUEINLINE,8
     JZ BACKSPACESEND
     mov di,sendcursorINLINE
     mov ax,di
     inc al
     cmp al,80  
     MOV DI,AX
     jz ENtERINLINE
    
   
    mov sendcursorINLINE,di
    movcursor sendcursorINLINE  
        mov ah,2
        mov dl,valueINLINE
        int 21h 
        BACKENTERSINLINE:
        BACKINLINE: 
        consume
         
   SEND VALUEINLINE 
   cmp valueinline,27D
   jz gotohell
   recivein:
   reciveINLINE:    
       mov dx , 3FDH		; Line Status Register
	CHKINLINE:	
	    in al,dx 
  		AND al , 1
  		JZ keyboardINLINE

 ;If Ready read the VALUE in Receive data register
  		mov dx , 3F8H
  		in al , dx 
  		mov VALUEINLINE , al
  		MOV AX,RECIVECURSORINLINE
  		CMP VALUEINLINE,13D
  		JZ ENTER1INLINE
  		CMP VALUEINLINE,8D
  		JZ BACKSPACEREC 
  		cmp valueinline,27D
        jz gotohell
        ;;PRINT AND GET CHAR 
        mov di,recivecursorINLINE
        mov ax,di
        inc al
        cmp al,80
        MOV DI,AX
        jz ENTER1INLINE 
       
        mov recivecursorINLINE,di
        movcursor recivecursorINLINE
        mov ah,2
        mov dl,VALUEINLINE
        int 21h 
         back1INLINE:
        JMP keyboardINLINE  
        
        ENTER1INLINE:
        MOVCURSOR GETREC
        DISPLAYSTRING SPACEINLINE
        MOVCURSOR GETREC
        MOV DI,GETREC 
        MOV recivecursorINLINE,DI
        JMP BACK1INLINE
     
      
        ENTERINLINE:
        MOVCURSOR GETSEND
        DISPLAYSTRING SPACEINLINE
        MOVCURSOR GETSEND
        MOV DI,GETSEND  
        MOV SENDcursorINLINE,DI
        JMP BACKINLINE
        
        
        
        BACKSPACESEND:
         MOV AX,SENDcursorINLINE
         CMP AX,GETSEND
         JZ OUTINLINE
        
        MOVCURSOR SENDcursorINLINE 
        DISPLAYSTRING SPACE1
        MOV AX,SENDcursorINLINE
        DEC AL
        MOV SENDcursorINLINE,AX 
         OUTINLINE:
        JMP BACKENTERSINLINE
        
        
        BACKSPACEREC: 
        MOV AX,recivecursorINLINE 
        CMP AX,GETREC
        JZ OUTINLINE1
        MOV recivecursorINLINE,AX
        MOVCURSOR recivecursorINLINE 
        DISPLAYSTRING SPACE1 
        MOV AX,recivecursorINLINE
        DEC AL
        MOV recivecursorINLINE,AX 
        
        OUTINLINE1:
        JMP KEYBOARDINLINE
  
  
   gotohell:
  ;;;allam 
  call display 
    ret 
  endp    pausex     
  ;==================================================================;
;======================Phase 2 Added Procedures ===================;
;==================================================================;
 

;===============================================================;
;======================Intialiizing The Port ===================;
;===============================================================;
PROC PortIntialization near 


;Set Divisor Latch Access Bit
    mov dx,3fbh 			; Line Control Register
    mov al,10000000b		;Set Divisor Latch Access Bit
    out dx,al			;Out it

;Set LSB byte of the Baud Rate Divisor Latch register.
    mov dx,3f8h			
    mov al,0ch			
    out dx,al

;Set MSB byte of the Baud Rate Divisor Latch register.
    mov dx,3f9h
    mov al,00h
    out dx,al

;Set port configuration
    mov dx,3fbh
    mov al,00011011b
    out dx,al

      RET
ENDP PortIntialization

StaticScreen1 proc near
    
    
    CLRSCR
    
        MOVCURSOR 011DH 
        DISPLAYSTRING GAMENAME ;;display the game name in the top of the game   
       
       
       
        MOVCURSOR 0300H
        DISPLAYSTRING LINE
    	
    	MOVCURSOR 1700H
    	DISPLAYSTRING LINE
    	
    	MOVCURSOR 0819H
        DISPLAYSTRING WELCOMEMSG
        
        MOVCURSOR 091DH
    	DISPLAYSTRING  GAMENAME  
       
        MOVCURSOR 0C0CH
        DISPLAYSTRING STATIC1       
    
        RET
ENDP  StaticScreen1 

Recive proc
  
     mov dx , 3FDH		; Line Status Register
    
;;Checking if anything was sent	
	LOMA: 
	in al,dx 
    AND al , 1
  	JZ LOMA

 ;If Ready read the VALUE in Receive data register

  	mov dx , 3F8H
  	in al , dx 	 
        ret
  endp recive
endp       
DISPLAY PROC
         
         
     clrscr    
     MOVCURSOR 011DH 
    DISPLAYSTRING GAMENAME ;;display the game name in the top of the game
    
    ConvertToDecimal SCORE1,SCOREPLY1 ;;;; this macro takes the score we have got in decimal to it's ascii equivelent characters
   
    ConvertToDecimal SCORE2,SCOREPLY2 ;;;; this macro takes the score we have got in decimal to it's ascii equivelent characters
  
    MOVCURSOR 0204H       ;;;displaying player1 name and his score
    DISPLAYSTRING ply1name
    DISPLAYSTRING SCORESTRN
    DISPLAYSTRING SCOREPLY1
    
    MOVCURSOR 0230H       ;;;displaying player2 name and his score
    DISPLAYSTRING PLy2name
    DISPLAYSTRING SCORESTRN
    DISPLAYSTRING SCOREPLY2 
    
    
    MOVCURSOR 0224H       ;;;displaying the level you are in
    DISPLAYSTRING LEVELMSG
    DISPLAYSTRING LVL
    
    ;UPPER LIMIT OF THE SCREEN COORDINATES  0300H
    MOVCURSOR 0300H       ;;to make line in top of the screen
    DISPLAYSTRING LINE  
    
    ;LOWER LIMIT OF THE SCREEN COORDINATES  1300H
    MOVCURSOR 1300H       ;;to make line in the bottom of the screen
    DISPLAYSTRING LINE
    
    ;TAKE IT OUT IN PHASE 3 
    MOVCURSOR 1400H       ;;temp msg that there is no chat
    DISPLAYSTRING  MSGTEMP
    
    ;;;
    
    MOVCURSOR 1700H
    DISPLAYSTRING ENDMSG
    DISPLAYSTRING SPACE
    DISPLAYSTRING PLy2name
    DISPLAYSTRING SPACE
    DISPLAYSTRING ENDMSG2     
         
         
         
         
         
         
         
         
         
        RET
ENDP DISPLAY
END MAIN          