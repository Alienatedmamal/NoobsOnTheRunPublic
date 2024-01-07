#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

# Options
cat $DIR/$AMAPLOGO
cat $DIR/Files/Images/Status
echo ""
cat $DIR/$OPTIONS


# User Input
read -p "Enter your choice:" choice
# Inputs process
case $choice in
    1)
        while true; do
            clear  # Clear the screen for a cleaner sub-menu
            cat $DIR/$SERVERMAN
            echo "Server Management Options:"
            echo "1. Server Details"
            echo "2. Server Console"
            echo "3. Server Backup"
            echo "4. Server Stop"
            echo "5. Server Start"
            echo "6. Back To Menu"
            read -p "Enter your choice: " subchoice
            case $subchoice in
                1) clear && $SERVER details && $AMAPNC && exit;;
                2) echo "To exit the console: Press CTRL + b, then, press d"
                   sleep 1
                   $SERVER console && $AMAP && exit ;;
                3) read -p "Are you sure you want to BACK UP SERVER? (Y/n): " confirm_ServerBackup
                    if [ "$confirm_ServerBackup" == "Y" ]; then
                        $SERVERBACKUP && $AMAPNC && exit
                    else
                        echo "ServerBackup Aborted." >> $LOGS && $AMAPNC
                    fi
                    ;;
                4) read -p "Are you sure you want to stop the Rust server? (Y/n): " confirm_stop
                    if [ "$confirm_stop" == "Y" ]; then
                        $SERVER stop >> $LOGS && $AMAP && exit
                    else
                        echo "Stopping Rust server aborted." >> $LOGS && $AMAP && exit
                    fi
                    ;;
                5) read -p "Are you sure you want to start the Rust server? (Y/n): " confirm_start
                    if [ "$confirm_start" == "Y" ]; then
                        $SERVER start >> $LOGS && $AMAP && exit
                    else
                        echo "Starting Rust server aborted." >> $LOGS && $AMAP && exit
                    fi
                    ;;
                6) echo "Going Back " && clear && $AMAP && break ;;
                *) echo "Invalid choice. Please enter a valid sub-option." ;;
            esac
            read -p "Press Enter to continue..."
        done
        ;;
    2)
        while true; do
            clear  # Clear the screen for a cleaner sub-menu
            cat $DIR/$LOGGING
            echo "Log Options:"
            echo "1. Check Logs"
            echo "2. Tail Logs"
            echo "3. Clear Logs"
            echo "4. Back to Menu"
            read -p "Enter your choice: " subchoice
            case $subchoice in
                1) cat $LOGS && $AMAPNC && exit ;;
                2) trap "$AMAP" EXIT
                        tail -f $LOGS;;
                3) read -p "Are you sure you want to CLEAR SERVER LOGS? (Y/n): " confirm_LogCleaner
                    if [ "$confirm_LogCleaner" == "Y" ]; then
                        $LOGCLEANER && $AMAP && exit
                    else
                        echo "LogCleaner Aborted." >> $LOGS && $AMAP && exit
                    fi
                    ;;
                4) echo "Going Back " && sleep 2 && clear && $AMAP && exit ;;
                *) echo "Invalid choice. Please enter a valid sub-option." ;;
            esac
            read -p "Press Enter to continue..."
        done
        ;;
    3)
        while true; do
            clear  # Clear the screen for a cleaner sub-menu
            cat $DIR/$BACKUPCON
            echo "Backup and configuration Options:"
            echo "1. Server Backup"
            echo "2. Edit Plugin Configs"
            echo "3. Edit AMAP Configs"
            echo "4. List of Plugins"
            echo "5. Oxide Config Path"
            echo "6. Oxide Plugin Path"
            echo "7. Edit Rust Server Configs"
            echo "8. Back to Menu"
            read -p "Enter your choice: " subchoice

            case $subchoice in
                1) read -p "Are you sure you want to BACK UP SERVER? (Y/n): " confirm_ServerBackup
                    if [ "$confirm_ServerBackup" == "Y" ]; then
                        $SERVERBACKUP && $AMAPNC && exit
                    else
                        echo "ServerBackup Aborted." && $AMAPNC && exit
                    fi
                    ;;
                2)
                    while true; do
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
                                sleep 1
                               nano $AUTOMATEDEVENTS && $AMAP && exit ;;
                            2) echo "Editing Backpacks.json"
                                sleep 1
                               nano $BACKPACKS && $AMAP && exit ;;
                            3) echo "Editing BetterChat.json"
                                sleep 1
                               nano $BETTERCHAT && $AMAP && exit ;;
                            4) echo "Editing BGrade.json"
                                sleep 1
                               nano $BGRADE && $AMAP && exit ;;
                            5) echo "Editing CustomIcon.json"
                                sleep 1
                               nano $CUSTOMICON && $AMAP && exit ;;
                            6) echo "Editing DiscordReport.json"
                                sleep 1
                               nano $DISCORDREPORT && $AMAP && exit ;;
                            7) echo "Editing Kits.json"
                                sleep 1
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
                                            sleep 1
                                           nano $MAGICIMAGESPANEL && $AMAP && exit ;;
                                        2) echo "Editing MagicMessagePanel.json"
                                            sleep 1
                                           nano $MAGICMESSAGEPANEL && $AMAP && exit ;;
                                        3) echo "Editing MagicPanel.json"
                                            sleep 1
                                           nano $MAGICPANEL && $AMAP && exit ;;
                                        4) echo "Going Back " && sleep 2 && clear && $AMAP && exit ;;
                                        *) echo "Invalid choice. Please enter a valid sub-option." ;;
                                    esac
                                    read -p "Press Enter to continue..."
                                done
                                ;;
                            9) echo "Editing Rustcord.json"
                                sleep 1
                               nano /home/$USERNAME/serverfiles/oxide/config/Rustcord.json && $AMAP && exit ;;
                            10) echo "Editing ServerInfo.json"
                                sleep 1
                                nano /home/$USERNAME/serverfiles/oxide/config/ServerInfo.json && $AMAP && exit ;;
                            11) echo "Editing SmartChatBot.json"
                                sleep 1
                                nano /home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json && $AMAP && exit ;;
                            12) echo "Editing TimedExecute.json"
                                sleep 1
                                nano /home/$USERNAME/serverfiles/oxide/config/TimedExecute.json && $AMAP && exit ;;
                            13) echo "Editing VIPTrial.json"
                                sleep 1
                                nano /home/$USERNAME/serverfiles/oxide/config/VIPTrial.json && $AMAP && exit ;;
                            14) echo "Going Back " && sleep 2 && clear && $AMAP && exit ;;
                                
                            *) echo "Invalid choice. Please enter a valid sub-option." ;;
                        esac
                        read -p "Press Enter to continue..."
                    done
                    ;;
                3)
                    while true; do
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
                        echo "10. PluginsMove"
                        echo "11. ServerConfigurator"
                        echo "12. WipeConfigurator"
                        echo "13. Exit"
                        read -p "Enter your choice: " subchoice
                        case $subchoice in
                            1) echo "Editing Fullwipe.sh"
                                sleep 1
                               nano $FULLWIPESH && $AMAP && exit ;;
                            2) echo "Editing Mapwipe.sh"
                                sleep 1
                               nano $MAPWIPESH && $AMAP && exit ;;
                            3) echo "Editing Nightly.sh"
                                sleep 1
                               nano $NIGHTLYSH && $AMAP && exit ;;
                            4) echo "Editing ServerBackup.sh"
                                sleep 1
                               nano $SERVERBACKUPSH && $AMAP && exit ;;
                            5) echo "Editing ServerChecker.sh"
                                sleep 1
                               nano $SERVERCHECKERSH && $AMAP && exit ;;
                            6) echo "Editing ServerStart.sh"
                                sleep 1
                               nano $SERVERSTARTSH && $AMAP && exit ;;
                            7) echo "Editing Schedule.sh"
                                sleep 1
                               nano $SCHEDULESH && $AMAP && exit ;;
                            8) echo "Editing LogCleaner.sh"
                                sleep 1
                               nano $LOGCLEANERSH && $AMAP && exit ;;
                            9) echo "Editing AMAP.sh"
                                sleep 1
                               nano $EAMAPSH && $AMAP && exit ;;
                            10) echo "Editing PulginsMove"
                                sleep 1
                                nano $DIR/Files/Scripts/PluginsMove.sh && $AMAP && exit ;;
                            11) echo "Editing ServerConfigurator" 
                                sleep 1
                                nano $DIR/Files/Scripts/ServerConfigurator.sh && $AMAP && exit ;;
                            12) echo "Editing WipeConfigurator"
                                sleep 1 
                                nano $DIR/Files/Scripts/wipeconfigure.sh && $AMAP && exit ;;
                            13) echo "Going Back " && clear && $AMAP && exit ;;
                            *) echo "Invalid choice. Please enter a valid sub-option." ;;
                        esac
                        read -p "Press Enter to continue..."
                    done
                    ;;
                4)
                    ls $OXIDEPLUGINS > $DIR/Files/Logs/pluginlist
                    while true; do
                        clear  # Clear the screen for a cleaner sub-menu
                        cat $DIR/Files/Logs/pluginlist
                        read -p "Press 1 to go back: " subchoice
                        case $subchoice in
                            1) echo "Going Back" && clear && $AMAP && exit ;;
                            *) echo "Invalid choice. Please enter a valid sub-option." ;;
                        esac
                        read -p "Press Enter to continue..."
                    done
                    ;;
                5)
                    while true; do
                        clear  # Clear the screen for a cleaner sub-menu
                        echo $OXIDECONFIG
                        read -p "1 to go back:" subchoices
                        case $subchoices in
                            1) echo "Going Back" && clear && $AMAP && exit ;;
                            *) echo "Invalid choice. Please enter a valid sub-option." ;;
                        esac
                        read -p "Press Enter to continue..."
                    done
                    ;;
                6)
                    while true; do
                        clear  # Clear the screen for a cleaner sub-menu
                        echo $PLUGINS
                        read -p "1 to go back:" subchoices
                        case $subchoices in
                            1) echo "Going Back" && clear && $AMAP && exit ;;
                            *) echo "Invalid choice. Please enter a valid sub-option." ;;
                        esac
                        read -p "Press Enter to continue..."
                    done
                    ;;
                7) echo "Editing Rust Configs"
                    sleep 1
                nano /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg && cp -f /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg && $AMAP && exit ;; 
                8) echo "Going Back " && clear && $AMAP && exit ;;
                *) echo "Invalid choice. Please enter a valid sub-option." ;;
            esac
            read -p "Press Enter to continue..."
        done
        ;;
    4)
        echo "Getting Configurator Ready....." && sleep 1
        clear
        while true; do
            clear  # Clear the screen for a cleaner sub-menu
            cat $DIR/$WIPECON
            echo "1. To Start Configurator"
            echo "2. Clear file before starting"
            echo "3. Check File"
            echo "4. Return to Menu"
            read -p "Enter Number and press enter:" subchoice
            case $subchoice in
                1) $DIR/Files/Scripts/./wipeconfigure.sh ;;
                2) read -p "Are you sure you want to CLEAR WIPE CONFIGURATIONS? (Y/n): " confirm_WipeClear
                    if [ "$confirm_WipeClear" == "Y" ]; then
                        echo > $DIR/Files/Logs/WipeOutput.txt
                    else
                        echo "Clear Wipeconfiguration Aborted." && $AMAP && exit
                    fi
                    ;; 
                3) cat $DIR/Files/Logs/WipeOutput.txt ;;
                4) echo "Going Back " && clear && $AMAP && exit ;;
                *) echo "Invalid choice. Please enter a valid sub-option." ;;
            esac
            read -p "Press Enter to continue..."
        done
        ;;
    5) while true; do
    clear  # Clear the screen for a cleaner sub-menu
    cat $AWAP
    echo "Options:"
    echo "1. FullWipe"
    echo "2. MapWipe"
    echo "3. Nightly"
    echo "4. ServerBackup"
    echo "5. ServerChecker"
    echo "6. ServerStart"
    echo "7. Schedule"
    echo "8. LogCleaner"
    echo "9. Exit"
    read -p "Enter your choice: " subchoice
    case $subchoice in
        1) echo "Starting Fullwipe.sh"
            sleep 1
            $FULLWIPE && $AMAP && exit ;;
        2) echo "Starting Mapwipe.sh"
            sleep 1
            $MAPWIPE && $AMAP && exit ;;
        3) echo "Starting Nightly.sh"
            sleep 1
            $NIGHTLY && $AMAP && exit ;;
        4) echo "Starting ServerBackup.sh"
            sleep 1
            $SERVERBACKUP && $AMAP && exit ;;
        5) echo "Starting ServerChecker.sh"
            sleep 1
            $SERVERCHECKER && $AMAP && exit ;;
        6) echo "Starting ServerStart.sh"
            sleep 1
            $SERVERSTART && $AMAP && exit ;;
        7) echo "Starting Schedule.sh"
            sleep 1
            $SCHEDULE && $AMAP && exit ;;
        8) echo "Starting LogCleaner.sh"
            sleep 1
            $LOGCLEANER && $AMAP && exit ;;
        9) echo "Going Back " && clear && $AMAP && exit ;;
        *) echo "Invalid choice. Please enter a valid sub-option." ;;
    esac
    read -p "Press Enter to continue..."
done
;;
6) while true; do
    clear  # Clear the screen for a cleaner sub-menu
    cat $DIR/$RUSTINSTALL
    echo " Choose an option"
    echo "1. Update Rust Server"
    echo "2. Update Rust Plugins"
    echo "3. Install Rust Server"
    echo "4. Install Oxide"
    echo "5. Install Plugins"
    echo "6. Remove/Uninstall Plugins"
    echo "7. Create Server Config File"
    echo "8. Copy Configs to Rust Server"
    echo "9. Return to Menu"

    read -p "Enter your choice: " subchoice
    case $subchoice in
        1) cat $DIR/$WARNING
            read -p "Are you sure you want to Update Rust Server? (Y/n): " confirm_stop
            if [ "$confirm_stop" == "Y" ]; then
                echo "Updating Rust server" >> $LOGS && /home/$USERNAME/./rustserver update
            else
                echo "Server MODS Install aborted." >> $LOGS && $AMAP && exit
            fi
            ;;
        2) cat $DIR/$WARNING
            read -p "Are you sure you want to Update Rust Server MODS? (Y/n): " confirm_stop
            if [ "$confirm_stop" == "Y" ]; then
                echo "Updating Rust Server MODS" >> $LOGS
                /home/$USERNAME/./rustserver mods-update
            else
                echo "Server MODS Install aborted." >> $LOGS && $AMAP
            fi
            ;;

        3) cat $DIR/$WARNING
            read -p "Are you sure you want to Install Rust server? (Y/n): " confirm_stop
            if [ "$confirm_stop" == "Y" ]; then
                echo "Installing Rust Server..." >> $LOGS
                $DIR/Files/Scripts/./RustServerInstall.sh
            else
                echo "Server Install aborted." && $AMAP
            fi
            ;;
        4) cat $DIR/$WARNING
            read -p "Are you sure you want to Install Rust MODS? (Y/n): " confirm_stop
            if [ "$confirm_stop" == "Y" ]; then
                echo "Installing Rust MODS..."
                /home/$USERNAME/./rustserver mods-install
            else
                echo "Server MODS Install aborted." && $AMAP
            fi
            ;;
        5) read -p "Are you sure you want to install Plugins? (Y/n): " confirm_PluginMove
            if [ "$confirm_PluginMove" == "Y" ]; then
                $PLUGINMOVE && $AMAPNC && exit
            else
                echo "Plugin Install Aborted." && $AMAPNC
            fi
            ;;
        6) read -p "Are you sure you want to Remove/Uninstall Plugins? (Y/n): " confirm_RMPlugin
            if [ "$confirm_RMPlugin" == "Y" ]; then
                $RMPLUGIN && $AMAPNC && exit
            else
                echo "Removal/Uninstall Aborted." && $AMAPNC
            fi
            ;;
        7) read -p "Are you sure you want to create a Server config file? (Y/n): " confirm_Serverconfig
            if [ "$confirm_Serverconfig" == "Y" ]; then
                $SERVERCONFIG && cat /$DIR/Files/common.cfg && $AMAPNC && exit
            else
                echo "Server Configurator Aborted." && $AMAPNC
            fi
            ;;
        8) cp "/home/$USERNAME/AMAP/Files/common.cfg" "/home/$USERNAME/$RUSTCONFIGS/common.cfg"
            cat "/home/$USERNAME/AMAP/Files/common.cfg" > "/home/$USERNAME/$RUSTCONFIGS/rustserver.cfg"
            echo "Files Copied Successful" || echo "Files Failed to Copied"
            sleep 1 && $AMAPNC && exit ;;
        9) echo "Going Back " && clear && $AMAP && exit ;;
        *) echo "Invalid choice. Please enter a valid sub-option." ;;
    esac
    read -p "Press Enter to continue..."
done
;;

        7) cat $DIR/ReadMe.md && $AMAPNC && exit ;;
        8) clear && $AMAP ;;
        9) $UPDATER && $AMAP && exit ;;
        10) echo "Exiting AMAP." && sleep 1 && clear && exit ;;
        *) echo "Invalid choice. Please enter a number between 1 and 9." && sleep 1 && clear && $AMAP ;;
    esac
