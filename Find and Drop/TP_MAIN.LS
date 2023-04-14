/PROG  TP_MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 696;
CREATE		= DATE 23-04-03  TIME 14:31:08;
MODIFIED	= DATE 23-04-12  TIME 14:30:14;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 35;
MEMORY_SIZE	= 1204;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/MN
    : ! TP_MAIN creates a loop to run and control the subprograms;
   1:   ;
    : ! loop start here    ;
   2:  LBL[1] ;
    : ! if register R[22] = 3 then run TP_BUILD_MAIN;
   3:  IF (R[22]=3) THEN ;
    : ! set R[22] to 6 to signal that TP_BUILD_MAIN is running;
   4:  R[22]=6    ;
   5:  CALL TP_BUILD_MAIN    ;
    : ! set R[22] to 0 to signal that TP_BUILD_MAIN is finished;
   6:  R[22]=0    ;
   7:  ENDIF ;
   8:   ;
    : ! if register R[22] = 5 or 6 then set R[22] to 0;
    : ! this is to prevent the subprograms from running twice;
   9:  IF (R[22]=5 OR R[22]=6 OR R[22]=7) THEN ;
  10:  R[22]=(0) ;
  11:  ENDIF ;
  12:   ;
  : ! if register R[22] = 1 then run TP_PLC_FIND ONLY ONCE;
  13:  IF (R[22]=1) THEN ;
  : ! set R[22] to 5 to signal that TP_PLC_FIND is running;
  14:  R[22]=(5) ;
  15:  CALL TP_PLC_FIND    ;
    : ! if register R[22] = 5 then set R[22] to 0 to signal that TP_PLC_FIND is finished;
  16:  IF (R[22]=5) THEN ;
  17:  R[22]=(0) ;
  18:  ENDIF ;
  19:  ENDIF ;
  20:   ;
    : ! if register R[22] = 2 then run TP_PLC_FIND ON A LOOP;
  21:  IF (R[22]=2) THEN ;
    : ! set R[22] to 7 to signal that TP_PLC_FIND is running;
  22:  R[22]=(7) ;
  23:  CALL TP_PLC_FIND    ;
    : ! if register R[22] = 7 then set R[22] to 2 to signal that TP_PLC_FIND is running on a loop;
  24:  IF (R[22]=7) THEN ;
  25:  R[22]=(2) ;
  26:  ENDIF ;
  27:  ENDIF ;
  28:   ;
    :  ! if register R[22] = 4 then set R[22] to 0 and finish the TP_MAIN program;
  29:  IF (R[22]=4) THEN ;
  30:  R[22]=(0) ;
  31:  END ;
  32:  ENDIF ;
  33:   ;
    : ! jump back to the start of the loop;
  34:  JMP LBL[1] ;
  35:   ;
/POS
/END
