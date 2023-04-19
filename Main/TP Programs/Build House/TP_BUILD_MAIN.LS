/PROG  TP_BUILD_MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1897;
CREATE		= DATE 23-03-06  TIME 13:36:48;
MODIFIED	= DATE 23-04-12  TIME 15:11:58;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 68;
MEMORY_SIZE	= 2409;
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
   1:  UFRAME_NUM=3 ;
   2:  UTOOL_NUM=1 ;
   3:  PAYLOAD[1] ;
   4:  OVERRIDE=25% ;
   5:   ;
    :  ! Start the TP program TP_BUIL_SCAN ;
   7:  CALL TP_BUILD_SCAN    ;
   8:   ;
   9:  OVERRIDE=20% ;
  10:   ;
  11:J PR[28] 35% CNT100    ;
    :  ! Check if all the pieces were found by the scanner ;
    :  ! Else exit the sub program ;
  12:  IF R[32]<R[21],JMP LBL[99] ;
  13:   ;
    :  !  The blocks are picked up and placed in the following ;
    :  ! order:  1, 2, 3, 4, 5                                 ;
    :  ! Bellow is a drawing of the house of blocks, to show and idea of ;
    :  ! what the program is going to do.;  
    :  ! ----------------- House of blocks ----------------------;
    :  ! ------------------------------------------------------- ;
    :  ! ------------       5/_\       ------------------------- ;
    :  ! ------------     4 _____      ------------------------- ;
    :  ! ------------      |_____|     ------------------------- ;
    :  ! ----------- 3 _______________  ------------------------ ;
    :  ! ------------ |_______________| ------------------------ ;
    :  ! ------------ | |           | | ------------------------ ;
    :  ! ------------ | |           | | ------------------------ ;
    :  ! ----------- 1|_|          2|_| ------------------------ ;
    :  ! ------------------------------------------------------- ;
    :  ! Then the blocks are placed in the following order:      ;
  14:  CALL GRIPPER_OPEN    ;
    :  ! Move to the first block and position 25mm above the Z position;
  15:J PR[25] 25% CNT100 VOFFSET,VR[1] Offset,PR[40]    ;
    :  ! move down on the Z position and close the gripper      ;
  16:J PR[25] 25% CNT100 VOFFSET,VR[1]    ;
  17:  CALL GRIPPER_CLOSE    ;
    :  ! move up 25mm and move to the home position             ;
  18:J PR[25] 25% CNT100 VOFFSET,VR[1] Offset,PR[40]    ;
  19:J PR[28] 25% CNT100    ; 
    :  ! move to the designated position for this block and open gripper;
  20:J P[1] 25% CNT100    ;
  21:  CALL GRIPPER_OPEN    ;
    :  ! set the flag for this block to 0;
  22:  R[25]=0    ;
  23:   ;

   :  ! move to the home position;
  24:J PR[28] 30% CNT100    ;
   :  ! Now to the next block and repeat the process         ;
  25:J PR[25] 25% FINE VOFFSET,VR[2] Offset,PR[40]    ;
  26:J PR[25] 25% FINE VOFFSET,VR[2]    ;
  27:  CALL GRIPPER_CLOSE    ;
  28:J PR[25] 25% FINE VOFFSET,VR[2] Offset,PR[40]    ;
  29:J PR[28] 25% CNT100    ;
  30:J P[2] 25% CNT100    ;
  31:  CALL GRIPPER_OPEN    ;
  32:J PR[28] 25% CNT100    ;
  33:  CALL GRIPPER_OPEN    ;
  34:  R[26]=0    ;
  35:   ;
  36:J PR[28] 25% CNT100    ;
  37:J PR[26] 25% FINE VOFFSET,VR[3] Offset,PR[40]    ;
  38:J PR[26] 25% FINE VOFFSET,VR[3]    ;
  39:  CALL GRIPPER_CLOSE    ;
  40:J PR[26] 25% FINE VOFFSET,VR[3] Offset,PR[40]    ;
  41:J PR[28] 25% CNT100    ;
  42:J P[3] 25% CNT100    ;
  43:  CALL GRIPPER_OPEN    ;
  44:J PR[28] 25% CNT100    ;
  45:  R[27]=0    ;
  46:   ;
  47:J PR[28] 25% CNT100    ;
  48:J PR[27] 25% FINE VOFFSET,VR[4] Offset,PR[40]    ;
  49:J PR[27] 25% FINE VOFFSET,VR[4]    ;
  50:  CALL GRIPPER_CLOSE    ;
  51:J PR[27] 25% FINE VOFFSET,VR[4] Offset,PR[40]    ;
  52:J PR[28] 25% CNT100    ;
  53:J P[4] 25% CNT100    ;
  54:  CALL GRIPPER_OPEN    ;
  55:  R[28]=0    ;
  56:   ;
  57:J PR[28] 25% CNT100    ;
  58:J PR[29] 25% FINE VOFFSET,VR[5] Offset,PR[40]    ;
  59:J PR[29] 25% FINE VOFFSET,VR[5]    ;
  60:  CALL GRIPPER_CLOSE    ;
  61:J PR[29] 25% FINE VOFFSET,VR[5] Offset,PR[40]    ;
  62:J PR[28] 25% CNT100    ;
  63:J P[5] 25% CNT100    ;
  64:  CALL GRIPPER_OPEN    ;
  65:  R[29]=0    ;
  66:J PR[28] 25% CNT100    ;
  67:   ;
  68:  LBL[99] ;
/POS
P[1]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -88.621  mm,	Y =  -171.371  mm,	Z =    84.785  mm,
	W =   178.972 deg,	P =     -.377 deg,	R =  -121.898 deg
};
P[2]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -46.006  mm,	Y =  -211.893  mm,	Z =    83.975  mm,
	W =   178.972 deg,	P =     -.377 deg,	R =  -121.897 deg
};
P[3]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -68.558  mm,	Y =  -192.057  mm,	Z =   114.265  mm,
	W =   178.971 deg,	P =     -.377 deg,	R =  -121.898 deg
};
P[4]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -67.298  mm,	Y =  -193.939  mm,	Z =   137.512  mm,
	W =   178.971 deg,	P =     -.377 deg,	R =  -121.898 deg
};
P[5]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -67.058  mm,	Y =  -195.108  mm,	Z =   160.918  mm,
	W =   178.971 deg,	P =     -.377 deg,	R =  -121.898 deg
};
/END
