# Fanuc-Robot-MateLR-200iD-4S

## School Capstone

### TP  PROGRAM: 
 #### TP_MAIN  
		TP_PLC_ FIND  
			TP_SCAN_ALL  
			TP_PLC_MOVE  
			TP_DROPBOX  
	TP_BUILD_MAIN  
			TP_BUILD_SCAN  
			TP_SCAN_AREA  

Name: TP_MAIN  
Program Information
This program controls what is executed from the Teach Pendant

Name: TP_BUILD_MAIN  
Program Information
The program to pick build a house made of blocks start here, first it calls for TP_BUILD_SCAN and waits for all the pieces to be found then organize them on top of each other, making look like a house and finish. 
If all pieces are not found it will finish

Name: TP_BUILD_SCAN  
Program Information
This is just in case we need to do something special before the real scan happens on our project, then calls for TP_SCAN_AREA to get all the pieces.

Name: TP_SCAN_AREA
Program Information
Will look for 5 pieces on the scan area and record all their positions for the TP_BUILD_MAIN to use it.

Name: TP_PLC_FIND
Program Information
The program cycle for picking a piece from the conveyor start here, the PLC waits for signal from robot to move a piece from the “place area” to the “scan area”, then the PLC signals the robot to call for TP_PLC_SCAN, once the piece is found, it will be move to the “drop area”, turns OFF the DO[109] for 0.30 seconds to reset the conveyor restarting the process again

Name: TP_SCAN_ALL
Program Information
Tries to find piece on the conveyor by scanning the area, if one piece is found 

Name: TP_PLC_ MOVE
Program Information
Once piece is found the robots arm will go to the picking position, grabs it and moves to a program position then calls to TP_PLC_ DROPBOX

Name: TP_PLC_ DROPBOX
Program Information
Moves to a programmed position and scans for a box bar code to drop the found piece, if the box is not found then the arm will just let the piece drop on this position.

Register Integer → R[]
|  			Group Variable 		 |  			Caption 		       |  			Register Number 		 |  			Value 		 |  			Description 		                                                                                                                                                                           |
|------------------|-----------------|-------------------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  			   			 		            |  			CAP_LOOP 		      |  			1 		               |  			0-4 		   |  			Loop counter 		                                                                                                                                                                          |
|  			   			 		            |  			CAP_DROP_POSS 		 |  			2 		               |  			0-4 		   |  			Robot uses this to know what 			object was found and then will know where to go to drop the piece 		                                                                                        |
|  			   			 		            |  			CAP_DROP_JMP2 		 |  			3 		               |  			5-8 		   |  			String Registers 		                                                                                                                                                                      |
|  			   			 		            |  			CAP_DROP_PR 		   |  			4 		               |  			math 		  |  			Robot uses this to 			calculates where to drop the piece 		                                                                                                                                 |
|  			PLC Scanning 		   |  			CAP_OBJ_FOUND 		 |  			5 		               |  			0-2 		   |  			0=not found, 1 = Found & 			2 = Searching 		                                                                                                                                                |
|  			TP_SCAN_AREA 		   |  			   			 		           |  			6 		               |  			10-14 		 |  			Object Counter 		                                                                                                                                                                        |
|  			PLC Scanning 		   |  			Direction 		     |  			14 		              |  			0-1 		   |  			 0 = Left  & 1 = Right 		                                                                                                                                                                |
|  			   			 		            |  			ScanX 		         |  			15 		              |  			0-10 		  |  			This set the limit for the 			area to scan the PLC 		                                                                                                                                       |
|  			   			 		            |  			ScanY 		         |  			16 		              |  			0-10 		  |  			This set the limit for the 			area to scan the PLC 		                                                                                                                                       |
|  			TP_PLC_SCAN 		    |  			MaxScanPLCX 		   |  			17 		              |  			0-10 		  |  			This set the limit for the 			area to scan the PLC 		                                                                                                                                       |
|  			   			 		            |  			MaxScanPLCY 		   |  			18 		              |  			0-10 		  |  			This set the limit for the 			area to scan the PLC 		                                                                                                                                       |
|  			TP_SCAN_AREA 		   |  			MaxScanAreaX 		  |  			19 		              |  			0-10 		  |  			This set the limit for the 			area to scan to build 		                                                                                                                                      |
|  			   			 		            |  			MaxScanAreaY 		  |  			20 		              |  			0-10 		  |  			This set the limit for the 			area to scan to build 		                                                                                                                                      |
|  			   			 		            |  			MaxObjs2Scan 		  |  			21 		              |  			0-5 		   |  			The number of objects to 			look for to build 		                                                                                                                                            |
|  			TP_MAIN 		        |  			PROG_SELECTED 		 |  			0-4 		             |  			22 		    |  			After selecting a program  			  			0 = Run main on a loop  			  			1 = Run TP PLC one time  			  			2 = Run TP PLC on a loop  			  			3 = TP BUILD  			  			4 = End the Main Program  			 5 			= Sub programs are running 		 |
|  			TP_SCAN_AREA 		   |  			a 		             |  			25 		              |  			0-1 		   |  			Use by TP_SCAN_AREA 		                                                                                                                                                                   |
|  			   			 		            |  			b 		             |  			26 		              |  			0-1 		   |  			Use by TP_SCAN_AREA 		                                                                                                                                                                   |
|  			   			 		            |  			c 		             |  			27 		              |  			0-1 		   |  			Use by TP_SCAN_AREA 		                                                                                                                                                                   |
|  			   			 		            |  			d 		             |  			28 		              |  			0-1 		   |  			Use by TP_SCAN_AREA 		                                                                                                                                                                   |
|  			   			 		            |  			found_build 		   |  			30 		              |  			0-5 		   |  			Use by TP_SCAN_AREA 		                                                                                                                                                                   |
|  			   			 		            |  			   			 		           |  			32 		              |  			0-5 		   |  			Use by TP_SCAN_AREA to count 			total pieces 		                                                                                                                                             |

Program Strings → ST[]
|  			Group Use 		     |  			Caption 		         |  			Value 		           |  			ID 		 |  			Description 		                                                                       |
|-----------------|-------------------|-------------------|------|-------------------------------------------------------------------------------------|
|  			TP_FIND_PLC 		   |  			OBJ_PLC_1 		       |  			OBJ_PLC_1 		       |  			1 		  |  			Object name for PLC scanner 		                                                       |
|  			   			 		           |  			OBJ_PLC_2 		       |  			OBJ_PLC_2 		       |  			2 		  |  			Object name for PLC scanner 		                                                       |
|  			   			 		           |  			OBJ_PLC_3 		       |  			OBJ_PLC_3 		       |  			3 		  |  			Object name for PLC scanner 		                                                       |
|  			   			 		           |  			OBJ_PLC_4 		       |  			OBJ_PLC_4 		       |  			4 		  |  			Object name for PLC scanner 		                                                       |
|  			   			 		           |  			OBJ_PLC_DROPBOX 		 |  			OBJ_PLC_DROPBOX 		 |  			5 		  |  			Object name for the symbol 			box 		                                                    |
|  			TP_MAIN 		       |  			message 		         |  			message 		         |  			6 		  |  			Shows a message 		                                                                   |
|  			TP_SCAN_AREA 		  |  			BUILD_1 		         |  			OBJ_BUILD_1 		     |  			10 		 |  			Object name for TP_BUILD 			scanner 		                                                  |
|  			   			 		           |  			   			 		             |  			OBJ_BUILD_2 		     |  			11 		 |  			Object name for TP_BUILD 			scanner 		                                                  |
|  			   			 		           |  			   			 		             |  			OBJ_BUILD_3 		     |  			12 		 |  			Object name for TP_BUILD 			scanner 		                                                  |
|  			   			 		           |  			   			 		             |  			OBJ_BUILD_4 		     |  			13 		 |  			Object name for TP_BUILD 			scanner 		                                                  |
|  			   			 		           |  			   			 		             |  			OBJ_BUILD_5 		     |  			13 		 |  			Object name for TP_BUILD 			scanner 		                                                  |
|  			Simple Finder 		 |  			comm_find_obj 		   |  			   			 		             |  			20 		 |  			Communicating piece that was 			found, this variable can be use to display a message 		 |
|  			   			 		           |  			comm_find_col 		   |  			   			 		             |  			21 		 |  			Communicating color found, 			this variable can be use to show a message 		             |
|  			   			 		           |  			obj_1 		           |  			obj_1 		           |  			22 		 |  			This is the object to be 			selected 		                                                 |
|  			   			 		           |  			OBJ_1_2D_SCAN 		   |  			Program Modify 		  |  			24 		 |  			   			 		                                                                               |
|  			   			 		           |  			OBJ_1_2D 		        |  			Program Modify 		  |  			25 		 |  			Selecting Object 1 of 2D 			camera (green square) 		                                    |


Posoition Registers → PR[]
|  			Group Use 		       |  			Caption 		          |  			ID 		 |  			Values 		         |  			Description 		                                                       |
|-------------------|--------------------|------|------------------|---------------------------------------------------------------------|
|  			   			 		             |  			HOME 		             |  			1 		  |  			Recorded 		       |  			User Frame and Camera was 			setup in this position 		                  |
|  			   			 		             |  			cap_home_mid 		     |  			12 		 |  			Recorded 		       |  			   			 		                                                               |
|  			TP_SCAN_PLC 		     |  			cap_PLC_cam2scan 		 |  			14 		 |  			Recorded 		       |  			Position the camera to scan 			conveyor for pieces 		                   |
|  			   			 		             |  			cap_PLC_cam2drop 		 |  			15 		 |  			Recorded 		       |  			Position the camera to scan 			for box symbol 		                        |
|  			   			 		             |  			cap_pick_PLC 		     |  			19 		 |  			Recorded 		       |  			Position to go and pick up 			part, we reuse this PR for all objects 		 |
|  			   			 		             |  			cap_plc_cls2drop 		 |  			21 		 |  			Recorded 		       |  			Position the tool close to 			the box to drop 		                        |
|  			   			 		             |  			cap_plc_drop_xy 		  |  			22 		 |  			Manually Enter 		 |  			Position to drop piece after 			scanning where the box is 		            |
|  			   			 		             |  			cap_plc_drop_xyz 		 |  			23 		 |  			Program Math 		   |  			Calculates new position 			using PR[22] and the PR[43-46] 		            |
|  			TP_SCAN_AREA 		    |  			cap_build_2 		      |  			25 		 |  			Recorded 		       |  			Position to pick up 2 of the 			TP_BUILD pieces 		                      |
|  			   			 		             |  			cap_build_3 		      |  			26 		 |  			Recorded 		       |  			Position to pick up 1 piece 			of the TP_BUILD 		                       |
|  			   			 		             |  			cap_build_4 		      |  			27 		 |  			Recorded 		       |  			Position to pick up 1 piece 			of the TP_BUILD 		                       |
|  			   			 		             |  			cap_build_home 		   |  			28 		 |  			Recorded 		       |  			Position to build the house 		                                       |
|  			   			 		             |  			cap_curr_poss 		    |  			30 		 |  			Program Modify 		 |  			The program uses this PR to 			know the current position 		             |
|  			Offset Position 		 |  			cap_add_z 		        |  			40 		 |  			Z = 25 Manual 		  |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_add_x 		        |  			41 		 |  			X = 10 Manual 		  |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_add_y 		        |  			42 		 |  			Y = 10 Manual 		  |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_add_x50 		      |  			43 		 |  			X = 50 Manual 		  |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_add_y50 		      |  			44 		 |  			Y = 50 Manual 		  |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_subtract_x50 		 |  			45 		 |  			X = -50 Manual 		 |  			Manual enter values 		                                               |
|  			   			 		             |  			cap_subtract_y50 		 |  			46 		 |  			Y = -50 Manual 		 |  			Manual enter values 		                                               |



Global Digital I/O’s
|  			Group 		  |  			Caption 		             |  			ID 		  |  			Values 		   |  			Description 		                                                                     |
|----------|-----------------------|-------|------------|-----------------------------------------------------------------------------------|
|  			INPUT 		  |  			PLC_IN 		              |  			101 		 |  			ON – OFF 		 |  			Comes from PLC – ON = 			Object is ready to be picked up OFF = object is not ready 		 |
|  			OUTPUT 		 |  			PLC_OUT 		             |  			109 		 |  			ON – OFF 		 |  			Signal going to PLC 		                                                             |
|  			   			 		    |  			SUB_RUNNING 		         |  			115 		 |  			ON – OFF 		 |  			IF ON we are be able to 			change Toggle Button 		                                    |
|  			   			 		    |  			simdio108 		           |  			116 		 |  			ON – OFF 		 |  			In case the PLC is not 			working this will bypass DI[101] 		                         |
|  			   			 		    |  			   			 		                 |  			   			 		 |  			   			 		      |  			   			 		                                                                             |
|  			   			 		    |  			CAP_ALLOW_EXECUTION 		 |  			118 		 |  			ON – OFF 		 |  			If ON then run TP_PLC_FIND 		                                                      |
|  			   			 		    |  			CAP_ALLOW_EXECUTION 		 |  			120 		 |  			ON – OFF 		 |  			If ON alarm will sound when 			a piece is found 		                                    |


