/PROG  TP_BUILD_SCAN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 194;
CREATE		= DATE 23-03-06  TIME 14:29:52;
MODIFIED	= DATE 23-04-11  TIME 14:49:56;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 4;
MEMORY_SIZE	= 558;
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
    :  ! In case we need to make our program more complex, we have this subprogram;
    :  ! This part can be modified before we actually call the TP_SCAN_AREA program ;
    :  ! The values are in mm ;
   1:   ;
   2:  PR[30]=PR[12]-PR[42]    ;
   3:  CALL TP_SCAN_AREA    ;
   4:   ;
/POS
/END
