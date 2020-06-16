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






;;MAINMENU MODULE PARAMETERS AND STRINGS;;To be edited in phase 3 so it holds invitations
IFYOUWANT DB '*Start the game press "F2".','$'
ELSEIFYOUWANT DB '*To go to The chat mode press"F3"','$'
ELSE DB '*To exit the game press"ESC"','$'







;;;CHAT MODULE PARAMETERS AND STRINGS ;;TO BE EDITED IN PHASE 3
CHATSORRY DB "We are very sorry that this version of the game doesn't hold this feature",'$'
Signature DB "The Game designers :)",'$'
Togoback DB 'To go back to the main menu press"F2".','$'





;;;GAME MODULE PARAMETERS AND STRINGS         
GameName DB 'SHOOT ME IF YOU CAN :)','$'
SCORESTRN DB "'s score:",'$'
ScorePLY1 DW 4 DUP ('$')
ScorePLY2 DW 4 DUP('$')
SCORE1 DW 0
SCORE2 DW 0
PLY1NAME DB 16 DUP('$'),'$' 
PLY2NAME DB 16 DUP('$'),'$'  






;TAKE IT OUT IN PHASE 3
MSGTEMP DB "Chatting is not avilable in this version of the game.SORRY :'(",'$'
line DB 80 DUP('-'),'$'
SPACELINE 80 DUP(32D),'$'
LevelMsg DB 'Level:','$'  
Lvl DB ? ,'$'
ENDMSG DB 'To end the game with','$'
ENDMSG2 DB 'press F2 ,To Pause Press F5.','$'
SPACE DB 032D ,'$'        
pause db 'To go back to the game press any key.','$'                 
sorrylvl2 db "Sorry Level2 isn't avilable in this version.","$"
yocan db "*You can go to level 1 to confirm press 'Y'.",'$'
orgotoo db "*To go to main menu press 'N'.",'$'


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
;--------------- bulet1---------------
 bulet11y db 0
 bulet11x db 0

 bulet12y db 0
 bulet12x db 0
 
 buletCount1 db 0                                   
;--------------- bulet2---------------
 bulet21y db 0
 bulet21x db 0 
                
 bulet22y db 0
 bulet22x db 0
 
 buletCount2 db 0 
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
;==================================================;
;====================== Entery Menu ===============;
;==================================================;
    
    
    
    JMP EN1 ;;This is labeled in spacemacrochecker it displays the enterymenu and get the name of user 1       
    
    SPCMACROCHECKER PLY1NAME,PLAY2,EN1
    
    play2: 
    ;;This lines to clear the error string if shown and the name
    
    MOVCURSOR 0E3AH
    DISPLAYSTRING CLEAR
    
    MOVCURSOR 0F00H 
    DISPLAYSTRING SPACELINE
    
    ;;This macro gets player 2 name 
    
    SPCMACROCHECKER PLY2NAME,MAINMENUModule,EN2 
     ;END OF ENTERY MENU
    




;;---------------------------------------------------------------------------------
    
;;;This Block is for printing main screen and getting user actions so he get to the menu he wants
;;MAIN Menu  to call it we jump to mainmenumodule



;==================================================;
;====================== Main Menu =================;
;==================================================;
    
    MAINMENUMODULE:
    
    CLRSCR  
    
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
    KEYPRESSWAIT
    CMP AH,60D
    JZ leveling  ;;starting the game defined in line 137
    CMP AH,61D
    JZ CHATMODULE   ;;chatting mode
    CMP AL,27D
    JZ ENDGAME      ;; to close the game
    JMP mainmenuloop 






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
    
    CHATBREAK1:   ;;here we display the menu
        
    MOVCURSOR 0D00H     
    DISPLAYSTRING LINE
    
    MOVCURSOR 0500H
    DISPLAYSTRING CHATSORRY
    
    MOVCURSOR  0600H
    DISPLAYSTRING SIGNATURE 
    
    MOVCURSOR 1700H
    DISPLAYSTRING TOGOBACK
   
   ;;here we get user action
    
    KEYPRESSWAIT
    CMP AH,60D
    JZ MAINMENUMODULE
    JNZ CHATBREAK1
   ;;ENDOFCHATMODULE






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
       INC COUNT3
              
       MOV AX,COUNT3 
      
       CMP AX,0fffh
       JZ BEGIN
   
       CMP AX,7ffh
       JNZ GAME
       
       
       BEGIN:
      
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
       CMP AH,4DH  ; check if the key RIGHT
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
       CMP AH,4BH  ; check if the key LEFT
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
       CMP AH,20H  ; check if the key RIGHT
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
       CMP AH,1EH  ; check if the key LEFT
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
       CMP AH,48H  ; check if the key LEFT
       JNZ SHOOT2 ; if no jump to the next if
       CALL CreatPlayer1Bulet
       jmp check
       




;-------------------------------------------------;      
;--------- TO CREAT BULET PLAYER2-----------------;
;-------------------------------------------------;
                    
       SHOOT2:   
       CMP AH,11H  ; check if the key LEFT
       JNZ PAUSEXX ; if no jump to the next if
       CALL CreatPlayer2Bulet                      
       jmp check    





;-------------------------------------------------;      
;--------- TO PAUSE THE GAME ---------------------;
;-------------------------------------------------;
       PAUSEXX:
       CMP AH,63D
       JNZ CloseProgram
       CALL pauseX
       jmp check
       
       
;-------------------------------------------------;      
;--------- Second Level---------------------------;
;-------------------------------------------------;        
secondlevel:


movcursor 0A00H
displaystring sorrylvl2

movcursor 0c00H
displaystring yocan

movcursor 0E00H
displaystring orgotoo

secondlevelcheck:

keypresswait
cmp al,'y'
jz  DUMMY
cmp al,'N'
jz MainMenuModule
cmp al,'Y'
jz  DUMMY 
cmp al,'n'
jz MainMenuModule
jnz secondlevelcheck


DUMMY:
MOV DI,OFFSET LVL
JMP SETLEVEL1


;-------------------------------------------------;      
;--------- TO CLOSE THE GAME ---------------------;
;-------------------------------------------------;
          
       CloseProgram:
       CMP AH,60D
       JNZ CHECK
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
   ENDGAME:  
   KILLDOSBOX:
   clrscr
   movcursor 0000h
   MOV AH,4CH
   MOV AL,0
   MOV BH,0
   INT 21H
   
   
   
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
PROC MoveBulets
     ;CHECK IF THE THERE IS BULETS FOR THE 1st PLAYER
       ;PUSHA                           
       ;WAITT 0003H,0D090H
      ; POPA   
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
     JNZ decrement1 ; if not continue
     
     ; in case of delete we put x and y for bullet = 0 
     MOV CH,0
     Mov CL,0
     MOV bulet11y,CH 
     MOV bulet11X,CH 
     mov DELETEPAR,CX ; the delete par returuns to 0
     dec buletCount1
     Jmp FirstPlayer2nd
    
     decrement1: 
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
; DI = 1,2 WHEATHER IT'S  UP OR DOWN  
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
   CALL MoveDOWN
   JMP EXIT1  
   
   NotThere: 
   ;MAKE DELETEPAR = 1 TO SHOW THAT IT HAS DELETED
   MOV BP, 2
   MOV DeletePar,BP
   
 
  EXIT1:
 ret
endp MOveBulets1
;===========================================================







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
    

    keypresswait  ;;;wait for any key from the user
    
    jmp gamemodule
    ret 
  endp    pausex     
  
endp   
END MAIN          