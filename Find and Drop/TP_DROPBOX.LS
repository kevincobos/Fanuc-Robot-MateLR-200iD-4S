/PROG  TP_DROPBOX
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 600;
CREATE		= DATE 23-02-28  TIME 14:55:52;
MODIFIED	= DATE 23-03-06  TIME 11:32:08;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 33;
MEMORY_SIZE	= 1108;
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
       //Finding the drop sign to be able to drop off found piece
       //First 4 lines of code telling the robot basic information
       //We are going to use User Frame number 3 
   1:  UFRAME_NUM=3 ;
       //UTOOL is the User Tool that we are plaing on using 
   2:  UTOOL_NUM=1 ;
       //PAYLOAD how heavy is the tool that we are using
   3:  PAYLOAD[1:EOAT w/o part] ;
       //We can change the speed of our program here
   4:  OVERRIDE=100% ;
   5:   ;
       //Execunting the VISION RUN_FIND SR[5] 
       //Searcing for an object with the string name saved on the String Register number 5
   6:  VISION RUN_FIND SR[5]    ;
       //If the object is found we can get it's position and we will save it on Vision Register VR[3] 
       //Else if no object is found we will jump to label number 97 
   7:  VISION GET_OFFSET SR[5] VR[3] JMP LBL[97] ;
       //
   8:  JMP LBL[R[2]] ;
   9:   ;
  10:  LBL[1] ;
  11:  PR[22:cap_plc_drop_xy]=PR[43:cap_add_x50]+PR[44:cap_add_y50]    ;
  12:  JMP LBL[96] ;
  13:  LBL[2] ;
  14:  PR[22:cap_plc_drop_xy]=PR[43:cap_add_x50]+PR[46:cap_subtract_y50]    ;
  15:  JMP LBL[96] ;
  16:  LBL[3] ;
  17:  PR[22:cap_plc_drop_xy]=PR[45:cap_subtract_x50]+PR[44:cap_add_y50]    ;
  18:  JMP LBL[96] ;
  19:  LBL[4] ;
  20:  PR[22:cap_plc_drop_xy]=PR[45:cap_subtract_x50]+PR[46:cap_subtract_y50]    ;
  21:  JMP LBL[96] ;
  22:   ;
  23:   ;
  24:  LBL[96] ;
  25:   ;
  26:  PR[23:cap_plc_drop_xyz]=PR[21:cap_plc_cls2drop]+PR[22:cap_plc_drop_xy]    ;
  27:J PR[23:cap_plc_drop_xyz] 12% CNT100 VOFFSET,VR[3]    ;
  28:   ;
  29:  JMP LBL[99] ;
  30:   ;
  31:  LBL[97] ;
  32:  LBL[99] ;
  33:  CALL GRIPPER_OPEN    ;
/POS
/END
