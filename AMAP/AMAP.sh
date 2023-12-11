#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

# Options
clear
cat $DIR/$AMAPLOGO
cat $DIR/$OPTIONS
		
			# User Input
		read -p "Enter your choice:" choice

			# Inputs process
        case $choice in
		
1)
	while true; do
                clear  # Clear the screen for a cleaner sub-menu
					echo "Server Management Options:"
					echo "1. Server Details"
		            echo "2. Server Console"
		            echo "3. Server Backup"
                    echo "4. Server Stop"
                    echo "5. Server Start" 
					echo "6. Back To Menu"
			read -p "Enter your choice: " subchoice

                case $subchoice in
			1) clear && $SERVERDETAILS && $AMAPNC && exit;;
			2) $SERVERCONSOLE && $AMAP && exit ;;
		    3) read -p "Are you sure you want to BACK UP SERVER? (y/n): " confirm_ServerBackup
                if [ "$confirm_ServerBackup" == "y" ]; then
                        $SERVERBACKUP && $AMAPNC && exit
                else
                        echo "ServerBackup Aborted." && $AMAPNC
                fi
				;;
			4) read -p "Are you sure you want to stop the Rust server? (y/n): " confirm_stop
				if [ "$confirm_stop" == "y" ]; then
            		$SERVERSTOP && $AMAP 
				else
            		echo "Stopping Rust server aborted." && $AMAP
				fi
				;;
			5) read -p "Are you sure you want to start the Rust server? (y/n): " confirm_start
				if [ "$confirm_start" == "y" ]; then
        		 $SERVERSTOP && $AMAP && exit
				else
            		echo "Starting Rust server aborted." && $AMAP
				fi
				;;	
			6) echo "Going Back " && clear && $AMAP && break ;;
            		*) echo "Invalid choice. Please enter a valid sub-option."
				;;

				esac
					read -p "Press Enter to continue..."
					done
					;;
2) 
while true; do
                 clear  # Clear the screen for a cleaner sub-menu
					echo "Log Options:"
					echo "1. Check Logs"
					echo "2. Tail Logs"
					echo "3. Clear Logs"
					echo "4. Back to Menu"
			read -p "Enter your choice: " subchoice

                case $subchoice in
			1) cat $LOGS && $AMAPNC && exit ;;
			2) tail -f $LOGS && $AMAPNC && exit ;;
			3) read -p "Are you sure you want to CLEAR SERVER LOGS? (y/n): " confirm_LogCleaner
                	if [ "$confirm_LogCleaner" == "y" ]; then
                       		$LOGCLEANER && $AMAPNC && exit
                	else
                        	echo "LogCleaner Aborted." && $AMAPNC && exit
                	fi
                	;;
			4) echo "Going Back " && clear && $AMAP && exit ;;
		        *) echo "Invalid choice. Please enter a valid sub-option."
				;;
				esac
					read -p "Press Enter to continue..."
					done
					;;	
3) while true; do
                clear  # Clear the screen for a cleaner sub-menu
					echo "Backup and configuration Options:"
					echo "1. Server Backup"
					echo "2. Edit Plugin Configs"
                    echo "3. List of Plugins"
                    echo "4. Oxide Config Path"
                    echo "5. Oxide Plugin Path"
					echo "6. Back to Menu"
			read -p "Enter your choice: " subchoice

                case $subchoice in
			1) read -p "Are you sure you want to BACK UP SERVER? (y/n): " confirm_ServerBackup
                if [ "$confirm_ServerBackup" == "y" ]; then
                        $SERVERBACKUP && $AMAPNC && exit
                else
                        echo "ServerBackup Aborted." && $AMAPNC && exit
                fi
				;;
			2) while true; do
                clear  # Clear the screen for a cleaner sub-menu
						echo "Options:"
						echo "1. Automated Events"
						echo "2. Back Packs"
						echo "3. Better Chat"
						echo "4. BGrade"
						echo "5. Custom Icon"
						echo "6. Discort Report"
						echo "7. Kits"
						echo "8. MAGIC PANEL"
						echo "9. RustCord"
						echo "10. Server Info"
						echo "11. Smart Chat Bot"
						echo "12. Timed Execute"
						echo "13. VIP Trial"
						echo "14. Exit"

                read -p "Enter your choice: " subchoice
                case $subchoice in
                    1) echo "Editing AutomatedEvents.json"
                       nano $AUTOMATEDEVENTS && $AMAP && exit ;;
                    2) echo "Editing Backpacks.json"
                       nano $BACKPACKS && $AMAP && exit ;;
                    3) echo "Editing BetterChat.json"
                       nano $BETTERCHAT && $AMAP && exit ;;
                    4) echo "Editing BGrade.json"
                       nano $BGRADE && $AMAP && exit ;;
                    5) echo "Editing CustomIcon.json"
                       nano $CUSTOMICON && $AMAP && exit ;;
                    6) echo "Editing DiscordReport.json"
                       nano $DISCORDREPORT && $AMAP && exit ;;
                    7) echo "Editing Kits.json"
                       nano $EDITKITS && $AMAP && exit ;;
                    8)                       
						while true; do
						clear  # Clear the screen for a cleaner sub-menu
									echo "Options:"
									echo "1. Magic Images Panel"
									echo "2. Magic Message Panel"
									echo "3. Magic Panel"
									echo "4. Exit"
						read -p "Enter your choice: " subchoice

						case $subchoice in
                        1) echo "Editing MagicImagesPanel.json"
                           nano $MAGICIMAGESPANEL && $AMAP && exit ;;
						2) echo "Editing MagicMessagePanel.json"
                           nano $MAGICMESSAGEPANEL && $AMAP && exit ;;
						3) echo "Editing MagicPanel.json"
                           nano $MAGICPANEL && $AMAP && exit ;;
						4) echo "Going Back " && clear && $AMAP && exit ;;
						*) echo "Invalid choice. Please enter a valid sub-option."
						   ;;
						esac
						read -p "Press Enter to continue..."
						done
						;;
                    9) echo "Editing Rustcord.json"
                       nano /home/alienatedmammal/serverfiles/oxide/config/Rustcord.json && $AMAP && exit ;;
                    10)	echo "Editing ServerInfo.json"
                        nano /home/alienatedmammal/serverfiles/oxide/config/ServerInfo.json && $AMAP && exit ;;
					11) echo "Editing SmartChatBot.json"
						nano /home/alienatedmammal/serverfiles/oxide/config/SmartChatBot.json && $AMAP && exit ;;
					12)	echo "Editing TimedExecute.json"
						nano /home/alienatedmammal/serverfiles/oxide/config/TimedExecute.json && $AMAP && exit ;;
					13) echo "Editing VIPTrial.json"
						nano/home/alienatedmammal/serverfiles/oxide/config/VIPTrial.json && $AMAP && exit ;;
                    14)	echo "Going Back " && clear && $AMAP && exit ;;
                     *) echo "Invalid choice. Please enter a valid sub-option."
                        ;;
						esac
						read -p "Press Enter to continue..."
						done
						;;	
			3) ls $OXIDEPLUGINS > $DIR/Files/pluginlist
					while true; do
                clear  # Clear the screen for a cleaner sub-menu
				cat $DIR/Files/pluginlist
                read -p "Press 1 to go back: " subchoice
				case $subchoice in 
				1) echo "Going Back" && clear && $AMAP && exit ;;
                *) echo "Invalid choice. Please enter a valid sub-option."
				;;
				esac
                read -p "Press Enter to continue..."
				done
				;;
			4) while true; do
               clear  # Clear the screen for a cleaner sub-menu
				echo $OXIDECONFIG
				read -p "1 to go back:" subchoices
				case $subchoices in 
					1) echo "Going Back" && clear && $AMAP && exit ;;
					*) echo "Invalid choice. Please enter a valid sub-option."
                    ;;
                    esac
					read -p "Press Enter to continue..."
					done
					;;	
			5) while true; do
               clear  # Clear the screen for a cleaner sub-menu
			   echo $PLUGINS
			   read -p "1 to go back:" subchoices
			   case $subchoices in
				1) echo "Going Back" && clear && $AMAP && exit ;;
                *) echo "Invalid choice. Please enter a valid sub-option."
                ;;
                esac
                read -p "Press Enter to continue..."
				done
				;;
			6) echo "Going Back " && clear && $AMAP && exit ;;
            *) echo "Invalid choice. Please enter a valid sub-option."
				;;
				esac
                read -p "Press Enter to continue..."
				done
				;;		
4) echo "Getting Configurator Ready....." && sleep 2
   echo "Make sure to have all information needed"
	    while true; do
        clear  # Clear the screen for a cleaner sub-menu
		cat /home/alienatedmammal/Documents/RustBackups/wipescripts/AlienatedAdminPanel/amaplogo
		echo Make sure to have the information needed before starting
		echo "1. To Start Configurator"
		echo "2. Clear flie before starting"
		echo "3. Check File"
		echo "3. Return to Menu"
		read -p "Enter Number and press enter:" subchoice
		case $subchoice in 
		1) /home/alienatedmammal/Documents/RustBackups/wipescripts/./WipeConfigure.sh ;;
		2) echo > $DIR/Files/Logs/WipeOutput.txt ;;
		3) cat $DIR/Files/Logs/WipeOutput.txt;;
		4) echo "Going Back " && clear && $AMAP && exit ;;
        *)
        echo "Invalid choice. Please enter a valid sub-option."
        ;;
        esac
        read -p "Press Enter to continue..."
        done
        ;;				
5) while true; do
                clear  # Clear the screen for a cleaner sub-menu

                echo "Options:"
                echo "1. FullWipe"
                echo "2. MapWipe"
                echo "3. Nightly"
                echo "4. ServerBackup"
                echo "5. ServerChecker"
                echo "6. ServerStart"
                echo "7. Schedule"
                echo "8. LogCleaner"
				echo "9. AMAP"
                echo "10. Exit"
                read -p "Enter your choice: " subchoice
                case $subchoice in
                    1) echo "Editing Fullwipe.sh"
                       nano $FULLWIPESH && $AMAP && exit ;;
                    2) echo "Editing Mapwipe.sh"
                       nano $MAPWIPESH && $AMAP && exit ;;
                    3) echo "Editing Nightly.sh"
                       nano $NIGHTLYSH && $AMAP && exit ;;
                    4) echo "Editing ServerBackup.sh"
                       nano $SERVERBACKUPSH && $AMAP && exit ;;
                    5) echo "Editing ServerChecker.sh"
                       nano $SERVERCHECKERSH && $AMAP && exit ;;
                    6) echo "Editing ServerStart.sh"
                       nano $SERVERSTARTSH && $AMAP && exit ;;
                    7) echo "Editing Schedule.sh"
                       nano $SCHEDULESH && $AMAP && exit ;;
                    8) echo "Editing LogCleaner.sh"
                       nano $LOGCLEANERSH && $AMAP && exit ;;
					9) echo "Editing AMAP.sh"
                       nano $EMAPSH && $AMAP && exit ;;
                    10) echo "Going Back " && clear && $AMAP && exit ;;
                    *) echo "Invalid choice. Please enter a valid sub-option."
						;;
						esac
						read -p "Press Enter to continue..."
						done
						;;
6) echo "This feature coming soon" && sleep 1 && $AMAP ;;

7) echo "This feature coming soon" && sleep 1 && $AMAP ;;
8) echo "Exiting AMAP." && sleep 1 && clear && exit ;;
*) echo "Invalid choice. Please enter a number between 1 and 16." && sleep 1 && clear && $AMAP ;;
   esac
