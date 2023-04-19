# Fanuc-Robot-MateLR-200iD-4S

## School Capstone
---
### HMI PROGRAMS:
>#### FANUC_BUILDER.stm
>> SIMPLEFINDER.stm  
>> SETUP.stm  
>> ABOUT.stm  
### Languages and tools used for this part of the project:
<p align="center">
<img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/css/css.png" alt="css" height="40" style="vertical-align:top; margin:4px">
<img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/javascript/javascript.png" alt="Javascript" height="40" style="vertical-align:top; margin:4px">
<img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/html/html.png" alt="html" height="40" style="vertical-align:top; margin:4px">
</p>
---
#### MAIN.stm
![Main example page](MAINSTM.png)
#### SETUP.stm
![Setup example page](SETUPSTM.png)
#### ABOUT.stm
![About example page](ABOUTSTM.png)
---
### TP  PROGRAMS: 
>#### TP_MAIN  
> TP_PLC_ FIND  
>> TP_SCAN_ALL  
>> TP_PLC_MOVE  
>> TP_DROPBOX 
 
> TP_BUILD_MAIN  
>> TP_BUILD_SCAN  
>> TP_SCAN_AREA  
---

Name: TP_MAIN  
Program’s Information  
This program controls what is executed from the Teach Pendant.  
  
Name: TP_BUILD_MAIN  
Program’s Information  
This is the control program to pick up pieces and build a house. First it calls for TP_BUILD_SCAN and waits for all the pieces to be found then organizes them on top of each other, making them look like a house and after that the program goes back to TP_MAIN.  
If all the pieces are not found it will finish.  
  
Name: TP_BUILD_SCAN  
Program’s Information  
This program was created just in case we need to do something special before the real scan happens, for now the only function of this program is to call TP_SCAN_AREA to get all the pieces. 
  
Name: TP_SCAN_AREA 
Program’s Information 
In this program we look for 5 pieces on the scan area and record all their positions on the Vision Registers VR [1 to 5] for the TP_BUILD_MAIN to use. 
  
Name: TP_PLC_FIND  
Program’s Information   
The program cycle for picking  up a piece from the conveyor start here, the PLC waits for a signal from robot to start running the conveyor, if a piece is available the PLC signals the robot to call for TP_PLC_SCAN, once the robot finds the new piece using the camera, the robot arm will use its grippers to grab and move the found piece to the “drop area” finishing the program and going back to the TP_MAIN program, all this is done using the sub programs below.  
  
Name: TP_PLC_SCAN  
Program’s Information  
This program tries to find a piece on the conveyor by scanning the area, if a piece is found, its position will be saved on the Vision Register VR [2] otherwise the scanning ends. 
  
Name: TP_PLC_ MOVE  
Program’s Information  
The main function of this program is to pick up the found piece from the conveyor using the stored position, after this process the TP_PLC_ DROPBOX will be called. 
  
Name: TP_PLC_ DROPBOX  
Program’s Information  
This program is designed to move the found piece to a programmed position using position registers, then the robot will scan for a bar code that is placed on top of the drop off box, if the box is not found then the arm will just let the piece go opening the gripper on that last spot. 

Register Integer → R[]
|     Group Variable  |   Caption        |   Register Number  |   Value  |   Description                                                                                                                                                                 |
|---------------------|------------------|--------------------|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     TP_PLC_DROPBOX  |   CAP_LOOP       |   1                |   0-4    |   Loop counter                                                                                                                                                                |
|     TP_PLC_DROPBOX  |   CAP_DROP_POSS  |   2                |   0-4    |   Robot uses this to know what object was found and then will know where to go to drop the piece                                                                              |
|     TP_PLC_DROPBOX  |   CAP_DROP_JMP2  |   3                |   5-8    |   String Registers                                                                                                                                                            |
|     TP_PLC_DROPBOX  |   CAP_DROP_PR    |   4                |   math   |   Robot uses this to calculates where to drop the piece                                                                                                                       |
|     PLC Scanning    |   CAP_OBJ_FOUND  |   5                |   0-2    |   0=not found, 1 = Found & 2 = Searching                                                                                                                                      |
|     TP_SCAN_AREA    |                  |   6                |   10-14  |   Object Counter                                                                                                                                                              |
|     PLC Scanning    |   Direction      |   14               |   0-1    |    0 = Left & 1 = Right                                                                                                                                                       |
|     PLC Scanning    |   ScanX          |   15               |   0-10   |   This set the X limit for the area to scan the PLC                                                                                                                           |
|     PLC Scanning    |   ScanY          |   16               |   0-10   |   This set the Y limit for the area to scan the PLC                                                                                                                           |
|     TP_PLC_SCAN     |   MaxScanPLCX    |   17               |   0-10   |   This set the X limit for the area to scan the PLC                                                                                                                           |
|     TP_PLC_SCAN     |   MaxScanPLCY    |   18               |   0-10   |   This set the Y limit for the area to scan the PLC                                                                                                                           |
|     TP_SCAN_AREA    |   MaxScanAreaX   |   19               |   0-10   |   This set the X limit for the area to scan the build pieces                                                                                                                  |
|     TP_SCAN_AREA    |   MaxScanAreaY   |   20               |   0-10   |   This set the Y limit for the area to scan the build pieces                                                                                                                  |
|     TP_SCAN_AREA    |   MaxObjs2Scan   |   21               |   0-5    |   The number of objects to look for to build                                                                                                                                  |
|     TP_MAIN         |   PROG_SELECTED  |   0-4              |   22     |   After selecting a program  0 = Run main on a loop  1 = Run TP PLC one time  2 = Run TP PLC on a loop  3 = TP BUILD  4 = End the Main Program  5 = Sub programs are running  |
|     TP_SCAN_AREA    |   a              |   25               |   0-1    |   Use by TP_SCAN_AREA to know if piece was found                                                                                                                              |
|     TP_SCAN_AREA    |   b              |   26               |   0-1    |   Use by TP_SCAN_AREA to know if piece was found                                                                                                                              |
|     TP_SCAN_AREA    |   c              |   27               |   0-1    |   Use by TP_SCAN_AREA to know if piece was found                                                                                                                              |
|     TP_SCAN_AREA    |   d              |   28               |   0-1    |   Use by TP_SCAN_AREA to know if piece was found                                                                                                                              |
|     TP_SCAN_AREA    |   found_build    |   30               |   0-5    |   Use by TP_SCAN_AREA to know if piece was found                                                                                                                              |
|     TP_SCAN_AREA    |                  |   32               |   0-5    |   Use by TP_SCAN_AREA to count total pieces                                                                                                                                   |

Program Strings → ST[]
|     Group Use      |   Caption          |   Value            |   ID  |   Description                                                |
|--------------------|--------------------|--------------------|-------|--------------------------------------------------------------|
|     TP_FIND_PLC    |   OBJ_PLC_1        |   OBJ_PLC_1        |   1   |   Object name for PLC scanner                                |
|     TP_FIND_PLC    |   OBJ_PLC_2        |   OBJ_PLC_2        |   2   |   Object name for PLC scanner                                |
|     TP_FIND_PLC    |   OBJ_PLC_3        |   OBJ_PLC_3        |   3   |   Object name for PLC scanner                                |
|     TP_FIND_PLC    |   OBJ_PLC_4        |   OBJ_PLC_4        |   4   |   Object name for PLC scanner                                |
|     TP_DROPBOX     |   OBJ_PLC_DROPBOX  |   OBJ_PLC_DROPBOX  |   5   |   Object name for the symbol box                             |
|     TP_MAIN        |   message          |   message          |   6   |   Shows a message, if we implement this part on the program  |
|     TP_SCAN_AREA   |   BUILD_1          |   OBJ_BUILD_1      |   10  |   Object name for TP_BUILD scanner                           |
|     TP_SCAN_AREA   |   BUILD_2          |   OBJ_BUILD_2      |   11  |   Object name for TP_BUILD scanner                           |
|     TP_SCAN_AREA   |   BUILD_3          |   OBJ_BUILD_3      |   12  |   Object name for TP_BUILD scanner                           |
|     TP_SCAN_AREA   |   BUILD_4          |   OBJ_BUILD_4      |   13  |   Object name for TP_BUILD scanner                           |
|     TP_SCAN_AREA   |   BUILD_5          |   OBJ_BUILD_5      |   14  |   Object name for TP_BUILD scanner                           |
|     Simple Finder  |   obj_1            |   obj_1            |   22  |   This is the object to be selected                          |
|     Simple Finder  |   OBJ_1_2D_SCAN    |   Program Modify   |   24  |                                                              |
|     Simple Finder  |   OBJ_1_2D         |   Program Modify   |   25  |   Selecting Object 1 of 2D camera (green square)             |


Posoition Registers → PR[]
|     Group Use        |   Caption           |   ID  |   Values          |   Description                                                        |
|----------------------|---------------------|-------|-------------------|----------------------------------------------------------------------|
|     General use      |   HOME              |   1   |   Recorded        |   User Frame and Camera was setup in this position                   |
|     TP_SCAN_PLC      |   cap_PLC_cam2scan  |   14  |   Recorded        |   Position the camera to scan conveyor for pieces                    |
|     TP_SCAN_PLC      |   cap_PLC_cam2dro   |   15  |   Recorded        |   Position the camera to scan for box symbol                         |
|     TP_SCAN_PLC      |   cap_pick_PLC      |   19  |   Recorded        |   Position to go and pick up part, we reuse this PR for all objects  |
|     TP_SCAN_PLC      |   cap_plc_cls2drop  |   21  |   Recorded        |   Position the tool close to the box to drop                         |
|     TP_SCAN_PLC      |   cap_plc_drop_xy   |   22  |   Manually Enter  |   Position to drop piece after scanning where the box is             |
|     TP_SCAN_PLC      |   cap_plc_drop_xyz  |   23  |   Program Math    |   Calculates new position using PR[22] and the PR[43-46]             |
|     TP_SCAN_ARE      |   cap_build_2       |   25  |   Recorded        |   Position to pick up 2 of the TP_BUILD pieces                       |
|     TP_SCAN_ARE      |   cap_build_3       |   26  |   Recorded        |   Position to pick up 1 piece of the TP_BUILD                        |
|     TP_SCAN_ARE      |   cap_build_4       |   27  |   Recorded        |   Position to pick up 1 piece of the TP_BUILD                        |
|     TP_SCAN_ARE      |   cap_build_home    |   28  |   Recorded        |   Position to build the house                                        |
|     General use      |   cap_curr_poss     |   30  |   Program Modify  |   The program uses this PR to know the current position              |
|     Offset Position  |   cap_add_z         |   40  |   Z = 25 Manual   |   Manually enter values                                              |
|     Offset Position  |   cap_add_x         |   41  |   X = 10 Manual   |   Manually enter values                                              |
|     Offset Position  |   cap_add_y         |   42  |   Y = 10 Manual   |   Manually enter values                                              |
|     Offset Position  |   cap_add_x50       |   43  |   X = 50 Manual   |   Manually enter values                                              |
|     Offset Position  |   cap_add_y50       |   44  |   Y = 50 Manual   |   Manually enter values                                              |
|     Offset Position  |   cap_subtract_x50  |   45  |   X = -50 Manual  |   Manually enter values                                              |
|     Offset Position  |   cap_subtract_y50  |   46  |   Y = -50 Manual  |   Manually enter values                                              |


Global Digital I/O’s
|     Group   |   Caption              |   ID   |   Values    |   Description                                                         |
|-------------|------------------------|--------|-------------|-----------------------------------------------------------------------|
|     INPUT   |   PLC_IN               |   101  |   ON – OFF  |   Comes from PLC -> If ON then a new object is ready to be picked up  |
|     OUTPUT  |   PLC_OUT              |   109  |   ON – OFF  |   Signal going to the PLC to run the conveyor                         |
|     OUTPUT  |   SUB_RUNNING          |   115  |   ON – OFF  |   If ON, we can change Toggle Button                                  |
|     OUTPUT  |   simdio108            |   116  |   ON – OFF  |   In case the PLC is not working this will bypass DI[101]             |
|     OUTPUT  |   CAP_ALLOW_EXECUTION  |   118  |   ON – OFF  |   If ON, then run TP_PLC_FIND                                         |
|     OUTPUT  |   CAP_ALLOW_EXECUTION  |   120  |   ON – OFF  |   If ON alarm will sound when a piece is found                        |