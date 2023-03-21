/PROG  TP_PLC_FIND
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 540;
CREATE		= DATE 23-02-28  TIME 13:56:58;
MODIFIED	= DATE 23-03-07  TIME 08:24:58;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 30;
MEMORY_SIZE	= 940;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN

   1:   ;
    :  ! I'm using :  ! to comment on the program ;
    :  !Program start here ;
   2:  LBL[10] ;
    :  !Waiting for the PLC to go pickup the piece if not it will loop ;
    :  !If DI[101] is the signal coming from the PLC ;
    :  !If there is no signal coming from the PLC we can bypass it by turning on the DO[116] ;
   3:  IF (DI[101] OR DO[116]) THEN ;
    :  !Write on the register to keep track of object to be found ;
   4:   R[2:CAP_DROP_POSS]=0    ;
    :  !Write on the register 0 = not found, 1 = found and 2 = searching ;
   5:   R[5:CAP_OBJ_FOUND]=0    ;
    :  !Create a loop to search for a piece ;
    :  !This is not a efficient way to search for the a object but it works ;
    :  !I use a better technique on the building program ;
   6:   FOR R[1:CAP_LOOP]=1 TO 4 ;
    :  !String Register SR[24] takes the value of SR[R[0-4]] ;
    :  !R[1]=OBJ_PLC_1 ;
    :  !R[2]=OBJ_PLC_2 ;
    :  !R[3]=OBJ_PLC_3 ;
    :  !R[4]=OBJ_PLC_4 ;
   7:     SR[24]=SR[R[1]]    ;
    :  !Position Register PR[30] = (subtract the value of Y position from PR of camera set start scan) ;
    :  !This line helps to position the camera at scanning position  ;
   8:     PR[30:cap_curr_pos]=PR[14:cap_PLC_cam2scan]-PR[42:cap_add_y]    ;
    :  !Call to TP_PLC_SCAN to search for object ;
   9:     CALL TP_PLC_SCAN    ;
    :  !If R[5] = 1 the the object was found ;
    :  !Else continue trying to find the next object ;
  10:     IF (R[5:CAP_OBJ_FOUND]=1) THEN ;
    :  !Register R[2] will hold the reference number of the found object R[2] = R[1]  ;
  11:       R[2:CAP_DROP_POSS]=R[1:CAP_LOOP]    ;
    :  !now we know that there is a object and kind it is we are going to move to safe place to drop it ;
  12:       CALL TP_PLC_MOVE    ;
    :  !R[1] = 4  ;
  13:       R[1:CAP_LOOP]=4    ;
  14:     ENDIF ;
  15:   ENDFOR ;
  16:   ;
    :   !Send Signal to PLC;
  17:   DO[109:simdio101]=ON ;
    :   ! Wait 5 seconds for the PLC to read the signal;
  18:   WAIT   5.00(sec) ;
    :   !Turn OFF signal for the PLC;
  19:   DO[109:simdio101]=OFF ;
  20:  ENDIF ;
  21:  ! ;
    :  !go back to the begging of the program ;
  22:  JMP LBL[10] ;
/POS
/END
