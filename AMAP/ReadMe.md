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
- Server Details<br>
Gives details about the rust server. 
- Server Console<br>
Opens a console window to the rust server **NO COMMAND INPUTS** 
- Server Backup<br>
Backsup the Rust server to the backup folder.
- ServerStop<br>
Stops the rust server

### 2) Logging
- Check Logs<br>
- Tail Logs<br>
Live view of log file
- Clear Logs<br>
Clears the log file. 

### 3) Server Backup/Configuration
- Server Backup<br>
Backs up the server to the backup folder in AMAP.
- Edit Plugin Configs<br>
Edit the configs of installed plugins. 
- List of Plugins<br>
List of Plugins
- Oxide Config Path<br>
Shows the path to the plugin config folder.
- Oxide Plugin Path<br>
Shows the path to the installed plugins.


### 4) Wipe Configure
- Start Configurator<br>
Starts the wipe configurator. This will create the string needed for the scheduler to run. You will need to know the last wipe seed and date for the scheduler to know what seed and date to look for. Follow the prompts. Once completed it will output it to the WipeOutput.txt file that is read by the scheduler. 
- Clear Configurator File<br>
This will clear all prior wipe configs in the WipeOutput.txt 
- Check Configurator File<br>
Shows the current WipeOutput.txt file. 

### 5) AMAP Controls
> - Fullewipe
> - Mapwipe
> - Nightly
> - ServerBackup
> - ServerChecker
> - ServerStart
> - Schedule
> - LogCleaner

### 6) Rust Updater/Installer
>- Update Rust Server
>- Update Rust Plugins
>- Install Rust Server
>- Install Oxide
>- Install Plugins
>- Create Server Config File
>- Copy Configs 

### 7) Help
>- more to come 

### 8) Clear Screen
>- Clear Screen

### 9) Update AMAP

### 10) Quit




