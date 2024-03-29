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
    :  !Finding the drop sign to be able to drop off found pieceoo     ;
    :  !First 4 lines of code telling the robot basic information      ;
    :  !We are going to use User Frame number 3      ;
   1:  UFRAME_NUM=3 ;
    :  !UTOOL is the User Tool that we are planing on using      ;
   2:  UTOOL_NUM=1 ;
    :  !PAYLOAD how heavy is the tool that we are using      ;
   3:  PAYLOAD[1:EOAT w/o part] ;
    :  !We can change the speed of our program here      ;
   4:  OVERRIDE=100% ;
   5:   ;
    :  !Executing the VISION RUN_FIND SR[5]      ;
    :  !Searching for an object with the string name saved on the String Register number 5     ;
   6:  VISION RUN_FIND SR[5]    ;
    :  !If the object is found we can get it's position and we will save it on Vision Register VR[3]      ;
    :  !Else if no object is found we will jump to label number 97      ;
   7:  VISION GET_OFFSET SR[5] VR[3] JMP LBL[97] ;
    :  !This part of code will use one point as reference      ;
    :  !using some additions and subtractions calculate up left or right and down left or right     ;
    :  !-----Rotate right-----------Original Position----------Rotate left-----------     ;
    :  !---|== X ==|=======|--------|== X ==|=======|--------|== X ==|=======|--------     ;
    :  !---|= Ob4 =|= Ob1 =|--------|= Ob1 =|= Ob2 =|--------|= Ob2 =|= Ob3 =|--------     ;
    :  !---|====-------====|--------|====-------====|--------|====-------====|--------     ;
    :  !---|____-Origin-___|--------|____-Origin-___|--------|____-Origin-___|--------     ;
    :  !---|====-------====|--------|====-------====|--------|====-------====|--------     ;
    :  !---|= Ob3 =|= Ob2 =|--------|= Ob4 =|= Ob3 =|--------|= Ob1 =|= Ob4 =|--------     ;
    :  !---|=======|== Y ==|--------|=======|== Y ==|--------|=======|== Y ==|--------     ;
   8:  JMP LBL[R[2]] ;
   9:   ;
    :  !Position Register PR[22] will be the one that will hold the value of the new calculate position     ;
    :  !Position Registers PR[44,45,46 and 47] are holding the user set values, if we want to change      ;
    :  !how far from the origin we drop our found object we could do it by modifying this variables     ;
    :  !Something to keep in mind is that we are working matrices, bellow is a simple example of how to simple      ;
    :  !matrix is being modified by adding each matrix to the main matrix      ;
    :  ! M3 = M1 + M2     ;
    :  !PR[22] = [+x , +y , z]     ;
    :  !Object number ? found      ;
  10:  LBL[1] ;
  11:  PR[22:cap_plc_drop_xy]=PR[43:cap_add_x50]+PR[44:cap_add_y50]    ;
    :  !PR[22] has a new value jump to label LBL[96]     ;
  12:  JMP LBL[96] ;
    :  !Object number ? found      ;
  13:  LBL[2] ;
    :  !PR[22] = [+x , -y , z]      ;
  14:  PR[22:cap_plc_drop_xy]=PR[43:cap_add_x50]+PR[46:cap_subtract_y50]    ;
    :  !PR[22] has a new value jump to label LBL[96]       ;
  15:  JMP LBL[96] ;
    :  !Object number ? found      ;
  16:  LBL[3] ;
    :  !PR[22] = [-x , +y , z]      ;
  17:  PR[22:cap_plc_drop_xy]=PR[45:cap_subtract_x50]+PR[44:cap_add_y50]    ;
    :  !PR[22] has a new value jump to label LBL[96]      ;
  18:  JMP LBL[96] ;
    :  !Object number ? found      ;
  19:  LBL[4] ;
    :  !PR[22] = [-x , -y , z]      ;
  20:  PR[22:cap_plc_drop_xy]=PR[45:cap_subtract_x50]+PR[46:cap_subtract_y50]    ;
    :  !PR[22] has a new value jump to label LBL[96]     ;
  21:  JMP LBL[96] ;
  22:   ;
  23:   ;
  24:  LBL[96] ;
  25:   ;
    :  !PR[23] takes the value of PR[21] plus PR[22]     ;
  26:  PR[23:cap_plc_drop_xyz]=PR[21:cap_plc_cls2drop]+PR[22:cap_plc_drop_xy]    ;
    :  ! VR[3] holds the position of the found object;
    :  !Move tool to PR[23] with a vision offset of VR[3]     ;
  27:J PR[23:cap_plc_drop_xyz] 12% CNT100 VOFFSET,VR[3]    ;
  28:   ;
    :  !Everything was running correctly and we foud a object, jump to LBL[99];
  29:  JMP LBL[99] ;
  30:   ;
    :  !If there was no object found then we come here Label LBL[97] ;
  31:  LBL[97] ;
    :  !object found and tool is in place to drop object;
  32:  LBL[99] ;
    :  !Opening the gripper;
  33:  CALL GRIPPER_OPEN    ;
/POS
/END
