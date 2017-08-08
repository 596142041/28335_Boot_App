***********************************************************************

WD_DISABLE	.set	1		;set to 1 to disable WD, else set to 0

    .ref _c_int00
    .global code_start

***********************************************************************
* Function: codestart section
*
* Description: Branch to code starting point
***********************************************************************

    .sect "codestart"

code_start:
   ; .if WD_DISABLE == 1
   ;    LB wd_disable       ;Branch to watchdog disable code
  ;  .else
  ;      LB _c_int00         ;Branch to start of boot.asm in RTS library
  ;  .endif
  ;0x338000
  ;.int 0x007f
  ;.int 0x54DF
  .int 0x0033
  .int 0x8f79
;end codestart section


***********************************************************************
* Function: wd_diable
*
* Description: Disables the watchdog timer
***********************************************************************
    .if WD_DISABLE == 1

    .text
wd_disable:
    SETC OBJMODE        ;Set OBJMODE for 28x object code
    EALLOW              ;Enable EALLOW protected register access
    MOVZ DP, #7029h>>6  ;Set data page for WDCR register
    MOV @7029h, #0068h  ;Set WDDIS bit in WDCR to disable WD
    EDIS                ;Disable EALLOW protected register access
    LB _c_int00         ;Branch to start of boot.asm in RTS library

    .endif

;end wd_disable



	.end
	
;//===========================================================================
;// End of file.
;//===========================================================================
