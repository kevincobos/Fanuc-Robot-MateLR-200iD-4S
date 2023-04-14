# Fanuc-Robot-MateLR-200iD-4S

School Capstone

TP  PROGRAM:
	TP_MAIN
		TP_PLC_ FIND
			TP_SCAN_ALL
			TP_PLC_MOVE
			TP_DROPBOX
		TP_BUILD_MAIN
			TP_BUILD_SCAN
			TP_SCAN_AREA

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


