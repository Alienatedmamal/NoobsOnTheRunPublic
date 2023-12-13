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

					     _  _  ___     ___  
					    ( \/ )(__ \   / _ \ 
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
```

### 1) Server Management  
> - Server Details
> - Server Console
> - Server Backup
> - ServerStop

### 2) Logging
>- Check Logs
>- Tail Logs
>- Clear Logs

### 3) Server Backup/Configuration
> - Server Backup
> - Edit Plugin Configs
> - List of Plugins
> - Oxide Config Path
> - Oxide Plugin Path

### 4) Wipe Configure
> - Start Configurator
> - Clear Configurator File
> - Check Configurator File 

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

### 9) Quit 




