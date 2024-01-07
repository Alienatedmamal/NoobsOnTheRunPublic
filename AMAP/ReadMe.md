# AlienatedMammal's Admin Panel 
## More information coming SOON!
```
               AAA               MMMMMMMM               MMMMMMMM               AAA               PPPPPPPPPPPPPPPPP
              A:::A              M:::::::M             M:::::::M              A:::A              P::::::::::::::::P
             A:::::A             M::::::::M           M::::::::M             A:::::A             P::::::PPPPPP:::::P
            A:::::::A            M:::::::::M         M:::::::::M            A:::::::A            PP:::::P     P:::::P
           A:::::::::A           M::::::::::M       M::::::::::M           A:::::::::A             P::::P     P:::::P
          A:::::A:::::A          M:::::::::::M     M:::::::::::M          A:::::A:::::A            P::::P     P:::::P
         A:::::A A:::::A         M:::::::M::::M   M::::M:::::::M         A:::::A A:::::A           P::::PPPPPP:::::P
        A:::::A   A:::::A        M::::::M M::::M M::::M M::::::M        A:::::A   A:::::A          P:::::::::::::PP
       A:::::A     A:::::A       M::::::M  M::::M::::M  M::::::M       A:::::A     A:::::A         P::::PPPPPPPPP
      A:::::AAAAAAAAA:::::A      M::::::M   M:::::::M   M::::::M      A:::::AAAAAAAAA:::::A        P::::P
     A:::::::::::::::::::::A     M::::::M    M:::::M    M::::::M     A:::::::::::::::::::::A       P::::P
    A:::::AAAAAAAAAAAAA:::::A    M::::::M     MMMMM     M::::::M    A:::::AAAAAAAAAAAAA:::::A      P::::P
   A:::::A             A:::::A   M::::::M               M::::::M   A:::::A             A:::::A   PP::::::PP
  A:::::A               A:::::A  M::::::M               M::::::M  A:::::A               A:::::A  P::::::::P
 A:::::A                 A:::::A M::::::M               M::::::M A:::::A                 A:::::A P::::::::P
AAAAAAA                   AAAAAAAMMMMMMMM               MMMMMMMMAAAAAAA                   AAAAAAAPPPPPPPPPP


					           ___     ___
                                                  (__ \   / _ \
                                             \  /  / _/  ( (_) )
                                              \/  (____)()\___/

                                        ALIENATEDMAMMAL'S ADMIN PANEL                                                 
                                                MANAGEMENT TOOL
```

# Cron Configs 
Replace **USERNAME** <br>
Copy and paste this in your corn.<br> 
```sudo crontab -e```<br>
```
#Stops, Updates, Updates Mods and restart the server.
0 3 * * * /home/USERNAME/AMAP/Files/Scripts/./Nightly.sh && sudo shutdown -r now

#Starts Rust Server Upon Reboot
@reboot /home/USERNAME/AMAP/Files/Scripts/./ServerStart.sh

#Backup Server Files.
55 2 * * * /home/USERNAME/AMAP/Files/Scripts/./ServerBackups.sh

#Checks if its a wipe day.
0 14 * * 4 /home/USERNAME/AMAP/Files/Scripts/./Schedule.sh

#Log Cleaner.
0 3 1 * * /home/USERNAME/AMAP/Files/Scripts/./LogCleaner.sh

# New Server Check Will not check from, 1355-1430(Wipe days and time) and 0258-0315 (Server Update/Reboot)
*/5 * * * * [ "$(date +\%H\%M)" -lt "1355" -o "$(date +\%H\%M)" -ge "1430" ] && [ "$(date +\%H\%M)" -lt "0258" -o "$(date +\%H\%M)" -ge "0315" ] && /home/USERNAME/AMAP/Files/Scripts/./ServerChecker.sh
```

### 1) Server Management  
 1) Server Details<br>
	Gives details about the rust server. 
 
2) Server Console<br>
	Opens a console window to the rust server **NO COMMAND INPUTS** 
 
3) Server Backup<br>
	Backsup the Rust server to the backup folder.

4) ServerStop<br>
	Stops the rust server



### 2) Logging
 1) Check Logs<br>
	View Log File

 2) Tail Logs<br>
	Live view of log file

 3) Clear Logs<br>
	Clears the log file. 



### 3) Server Backup/Configuration
 1) Server Backup<br>
	Backs up the server to the backup folder in AMAP.

 2) Edit Plugin Configs<br>
	Edit the configs of installed plugins. 

 3) List of Plugins<br>
	List of Plugins

 4) Oxide Config Path<br>
	Shows the path to the plugin config folder.

 5) Oxide Plugin Path<br>
	Shows the path to the installed plugins.



### 4) Wipe Configure
1) Start Configurator<br>
	Starts the wipe configurator. This will create the string needed for the scheduler to run. You will need to know the last wipe seed and date for the scheduler to know what seed and date to look for. Follow the prompts. Once completed 	it will output it to the WipeOutput.txt file that is read by the scheduler. 

2) Clear Configurator File<br>
	This will clear all prior wipe configs in the WipeOutput.txt 

3) Check Configurator File<br>
	Shows the current WipeOutput.txt file. 



### 5) AMAP Controls
 1) Fullewipe<br>
	Performs a full-wipe. This includes all Map and Player data

 2) Mapwipe<br>
	Performs a map-wipe. This only includes map data

 3) Nightly<br>
	Stops the server. Updates and updates plugins.

 4) ServerBackup<br>
	Backups the server to AMAP/Files/RustBackups

 5) ServerChecker<br>
	It will check to see if the server is running. If it is not running it will attempt to start the server. If failed to start server will notify Discord (Discord URL needed in config) 

 6) ServerStart<br>
	Starts the Rust server

 7) Schedule<r>
 	This will check the AMAP/Files/Logs/WipeOutput.txt file to see if there is a wipe. Use Wipe Creator to make a wipe date. 

 8) LogCleaner<br>
	Clears the AMAP/Files/Logs/Logs.txt


### 6) Rust Updater/Installer
 1) Update Rust Server<br>
	Updates the Rust server automatically

 2) Update Rust Plugins<br>
 

 3) Install Rust Server<br>


 4) Install Oxide<br>


 5) Install Plugins<br>


 6) Create Server Config File<br>


 7) Copy Configs<br> 



### 7) Help
1) Help<br>
	Displays this file.



### 8) Clear Screen
 1) Clear Screen<br>
	Resets the Dashboard. 


### 9) Update AMAP
This will update AMAP if there is an update available. 


### 10) Quit
Quits/Closes AMAP 
