# config.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"




###############################################################
################## Replace with your information ##############
#########This Should Auto-Fill if not replace USER NAME########
                     USERNAME="USER NAME"       

               HOSTNAME="NAME OF RUST SERVER"     
               DISCORDURL="DISCORD URL HERE"       

###############################################################








###########################################################################################################################################################################
### !!!!!Do not edit below this line!!!!! ### !!!!!Do not edit below this line!!!!! ### !!!!!Do not edit below this line!!!!! ### !!!!!Do not edit below this line!!!!! ### 
###########################################################################################################################################################################


# Location of Rust Server
SERVER_LOCATION="/home/$USERNAME/"
# Rust Server Control:
SERVERDETAILS="$SERVER details"
SERVERCONSOLE="$SERVER console"
SERVERSTOP="$SERVER stop"
SERVERSTART="$SERVER start"
SERVERUPDATE="$SERVER update && $SERVER mods-update"
# AMAP:
AMAPUPDATE=:"$DIR/Files/Scripts"
SCRIPTS="$SCRIPT_DIR/Files/Scripts"
FILES="$SCRIPT_DIR/Files/"
UPDATER="$DIR/Files/Updater/Updater/./update.sh"
STARTUPDATER="$DIR/Files/Updater/Update/./update.sh"
AMAPNC="$SCRIPT_DIR/./AMAPNC.sh"
AMAP="$SCRIPT_DIR/./AMAP.sh"
CONFIG="Files/config.sh"
AMAPLOGO="Files/Images/logo"
OPTIONS="Files/Images/menu"
SERVERMAN="Files/Images/servman"
WIPECON="Files/Images/wipecon"
LOGGING="Files/Images/logging"
BACKUPCON="Files/Images/backup"
RUSTINSTALL="Files/Images/rustinstall"
WARNING="Files/Images/warning"
AWAP="$SCRIPT_DIR/Files/Images/awap"
PLUGINMOVE="$DIR/Files/Scripts/./PluginsMove.sh"
SERVERCONFIG="Files/Scripts/./ServerConfigurator.sh"
WIPER="$DIR/Files/Logs/WipeOutput.txt"
FINISH="$DIR/Files/Config/finish"
# Running Scripts:
LOGCLEANER="$SCRIPT_DIR/Files/Scripts/./LogCleaner.sh"
SERVERBACKUP="$SCRIPT_DIR/Files/Scripts/./ServerBackups.sh"
WIPECONFIGURE="$SCRIPT_DIR/Files/Scripts/./wipeConfigure.sh"
FULLWIPE="$SCRIPT_DIR/Files/Scripts/./Fullwipe.sh"
MAPWIPE="$SCRIPT_DIR/Files/Scripts/./Mapwipe.sh"
NIGHTLY="$SCRIPT_DIR/Files/Scripts/./Nightly.sh"
RMPLUGIN="$DIR/Files/Scripts/./RMPlugins.sh"
SERVERCHECKER="$SCRIPT_DIR/Files/Scripts/./ServerChecker.sh"
SERVERSTART="$SCRIPT_DIR/Files/Scripts/./ServerStart.sh"
SCHEDULE="$SCRIPT_DIR/Files/Scripts/./Schedule.sh"
UPDATER="$DIR/Files/Scripts/./Updater.sh"
SCRIPTFULL="Fullwipe:"
SCRIPTLOGCLEAN="LogCleaner:"
SCRIPTMAPWIPE="MapWipe:"
SCRIPTNIGHTLY="Nightly:"
SCRIPTBACKUPS="ServerBackup:"
SCRIPTSERVERSTART="ServerStart:"
# Sripts File Locations:
FULLWIPESH="$SCRIPT_DIR/Files/Scripts/Fullwipe.sh"
MAPWIPESH="$SCRIPT_DIR/Files/Scripts/Mapwipe.sh"
NIGHTLYSH="$SCRIPT_DIR/Files/Scripts/Nightly.sh"
SERVERBACKUPSH="$SCRIPT_DIR/Files/Scripts/ServerBackups.sh"
SERVERCHECKERSH="$SCRIPT_DIR/Files/Scripts/ServerChecker.sh"
SERVERSTARTSH="$SCRIPT_DIR/Files/Scripts/ServerStart.sh"
SCHEDULESH="$SCRIPT_DIR/Files/Scripts/Schedule.sh"
LOGCLEANERSH="$SCRIPT_DIR/Files/Scripts/LogCleaner.sh"
EAMAPSH="$SCRIPT_DIR/AMAP.sh"
#OXIDE LOCATIONS:
OXIDECONFIG="/home/$USERNAME/serverfiles/oxide/config/"
OXIDEPLUGINS="/home/$USERNAME/serverfiles/oxide/plugins/"
AUTOMATEDEVENTS="/home/$USERNAME/serverfiles/oxide/config/AutomatedEvents.json"
BACKPACKS="/home/$USERNAME/serverfiles/oxide/config/Backpacks.json"
BETTERCHAT="/home/$USERNAME/serverfiles/oxide/config/BetterChat.json"
BGRADE="/home/$USERNAME/serverfiles/oxide/config/BGrade.json"
CUSTOMICON="/home/$USERNAME/serverfiles/oxide/config/CustomIcon.json"
DISCORDREPORT="/home/$USERNAME/serverfiles/oxide/config/DiscordReport.json"
EDITKITS="/home/$USERNAME/serverfiles/oxide/data/Kits/kits_data.json"
MAGICIMAGESPANEL="/home/$USERNAME/serverfiles/oxide/config/MagicPanel/MagicImagesPanel.json"
MAGICMESSAGEPANEL="/home/$USERNAME/serverfiles/oxide/config/MagicPanel/MagicMessagePanel.json"
MAGICPANEL="/home/$USERNAME/serverfiles/oxide/config/MagicPanel/MagicPanel.json"
RUSTCORD="/home/$USERNAME/serverfiles/oxide/config/Rustcord.json"
SERVERINFO="/home/$USERNAME/serverfiles/oxide/config/ServerInfo.json"
SMARTCHATBOT="/home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json"
TIMEDEXECUTE="/home/$USERNAME/serverfiles/oxide/config/TimedExecute.json"
VIPTRIAL="/home/$USERNAME/serverfiles/oxide/config/VIPTrial.json"
RUSTMOVE="mv lgsm /home/$USERNAME/ && mv rustserver /home/$USERNAME/ && mv linuxgsm.sh /home/$USERNAME/"
RUSTCONFIGS="lgsm/config-lgsm/rustserver"
# Scripts
SERVERNAME="Rust"
SAYDATE="echo $(date)"
USER="sudo -u $USERNAME "
SYNC="rsync --copy-links -avzh -s --delete"
SAY="echo $(date)"
BACKUPS="$DIR/Files/RustBackups/"
LOGS="$DIR/Files/Logs/Logs.txt"
CLEANLOGS="echo > $LOGS"
SERVER="/home/$USERNAME/./rustserver"
