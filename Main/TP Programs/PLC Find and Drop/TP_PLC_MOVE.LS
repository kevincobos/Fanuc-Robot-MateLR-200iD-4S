/PROG  TP_PLC_MOVE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 406;
CREATE		= DATE 23-02-28  TIME 13:59:14;
MODIFIED	= DATE 23-02-28  TIME 15:50:12;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 24;
MEMORY_SIZE	= 690;
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
    :  !To avoid the robot colliding against it self we first need to move to ;
    :  ! PR[10] from there we move to PR[15]    ;
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
    :  !Move to home position ;
   6:J PR[10:cap_home] 100% CNT100    ;
    :  !Move to a position to scan for a place to drop off found object ;
   7:J PR[15:cap_PLC_cam2drop] 100% CNT100    ;

   8:  CALL TP_DROPBOX    ;
    :  !Move to a position to scan for a place to drop off found object ;
    :  !the reason to do this is to make sure we are not bumping into other object around the robot ;
   9:J PR[15:cap_PLC_cam2drop] 100% CNT100    ;
/POS
/END
