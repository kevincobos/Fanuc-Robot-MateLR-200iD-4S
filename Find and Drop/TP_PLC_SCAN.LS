/PROG  TP_PLC_SCAN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1094;
CREATE		= DATE 23-03-06  TIME 15:49:12;
MODIFIED	= DATE 23-03-07  TIME 11:01:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 66;
MEMORY_SIZE	= 1606;
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
    :  !Here we are moving the camera and try to find a object;
    :  ! the scan area can be modify by getting into the Position Registers  ;
    :  ! and changing the values of PR[15,16,17 and 18] ;
    :  ! Note:  There is better ways to do this process, but for the this project I kept it this way ; 
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
    :  !Registers use by the program to keep track of this loop;
   6:  R[14:Direction]=0    ;
   7:  R[15:ScanX]=0    ;
   8:  R[16:ScanY]=0    ;
   9:   ;
  10:   ;
    :  !Starting scanning process;
  11:  LBL[1] ;
    :  !Move to a position register to scan the PLC ;
  12:J PR[30:cap_curr_pos] 50% FINE    ;
  13:   ;
    :  ! Use the VISION RUN_FIND to find the object with name store on the String Register SR[24];
  14:  VISION RUN_FIND SR[24]    ;
    :  ! If found object then use the function GET_OFFSET to store the offset position on a      ;
    :  ! Vision Register VR[2];
    :  ! Else Jump to LBL[97];
  15:  VISION GET_OFFSET SR[24] VR[2] JMP LBL[97] ;
  16:   ;
    :  !If found object turn on the Horn to alert the user about it;
  17:  DO[105:Horn]=ON ;
  18:  R[5:CAP_OBJ_FOUND]=1    ;
  19:  CALL GRIPPER_OPEN 
    :  !Turn off horn;   ;
  20:  DO[105:Horn]=OFF ;
    :  !Move tool to PR[19] applying VOFFSET[2];
  21:J PR[19:cap_pick_PLC] 12% FINE VOFFSET,VR[2]    ;
    :  !Close gripper;
  22:  CALL GRIPPER_CLOSE    ;
    :  !Move to PR[14] getting to make sure the robot do not collide with objects on the table;
  23:J PR[14:cap_PLC_cam2scan] 40% FINE    ;
    :  !Object found let's get to the next part of the program;
  24:  JMP LBL[99] ;
  25:   ;
    :  !If Object was not found we come here;
  26:  LBL[97] ;
    :  !---------------------------------------------------------------------------------------;
    :  !------------------------------------Scanning-------------------------------------------;
    :  !-------------------------- X ----------------------------------------------------------;
    :  !------ Start scanning here |  |-> -> -> -> -> -> -> -> ->|    ends here ---------------;
    :  !---------------- ends here |  |<- <- <- <- <- <- <- <- <-|    continue scanning here---;
    :  !-- continues scanning here |  |-> -> -> -> -> -> -> -> ->|    ends here ---------------;
    :  !---------------- ends here |  |<- <- <- <- <- <- <- <- <-|    continue scanning here---;
    :  !---------------------------|_____________________________ Y ---------------------------;
    :  !---------------------------------------------------------------------------------------;
    :  !-- This code bellow scans for objects, on top we have an example of I'm trying to do --;
    :  !---------------------------------------------------------------------------------------;
    :  !--Start Here---------------------------------------------------------------------------;
  27:  IF (R[15:ScanX]<=0) THEN ;
  28:  R[15:ScanX]=1    ;
  29:  R[14:Direction]=1    ;
  30:  JMP LBL[2] ;
  31:  ENDIF ;
  32:   ;
  33:  IF (R[15:ScanX]>R[17:MaxScanPLCX]) THEN ;
  34:  R[15:ScanX]=R[17:MaxScanPLCX]    ;
  35:  R[14:Direction]=1    ;
  36:  JMP LBL[2] ;
  37:  ELSE ;
  38:  JMP LBL[3] ;
  39:  ENDIF ;
  40:   ;
  41:  LBL[2] ;
  42:  IF (R[16:ScanY]>R[18:MaxScanPLCY]) THEN ;
  43:  R[5:CAP_OBJ_FOUND]=0    ;
  44:  JMP LBL[99] ;
  45:  ELSE ;
  46:  R[16:ScanY]=R[16:ScanY]+1    ;
  47:  PR[30:cap_curr_pos]=PR[30:cap_curr_pos]+PR[42:cap_add_y]    ;
  48:  JMP LBL[1] ;
  49:  ENDIF ;
  50:   ;
  51:  LBL[3] ;
  52:  IF (R[14:Direction]=0) THEN ;
  53:  R[15:ScanX]=(R[15:ScanX]-1) ;
  54:   ;
  55:  PR[30:cap_curr_pos]=PR[30:cap_curr_pos]-PR[41:cap_add_x]    ;
  56:   ;
  57:  JMP LBL[1] ;
  58:  ELSE ;
  59:  R[15:ScanX]=(R[15:ScanX]+1) ;
  60:   ;
  61:  PR[30:cap_curr_pos]=PR[30:cap_curr_pos]+PR[41:cap_add_x]    ;
  62:   ;
  63:  JMP LBL[1] ;
  64:  ENDIF ;
  :  !---Ends here --------------------------------------------------------------------------;
  :  !---------------------------------------------------------------------------------------;
  65:   ;
  66:  LBL[99] ;
/POS
/END
