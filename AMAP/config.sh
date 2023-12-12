# config.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Replace with your information
USERNAME="SYSTEMS USER HERE"
HOSTNAME="NAME OF RUST SERVER"





# Location of Rust Server
SERVER_LOCATION="/home/$USERNAME/"

# Rust Server Control:
SERVERDETAILS="$SERVER details"
SERVERCONSOLE="$SERVER console"
SERVERSTOP="$SERVER stop"
SERVERSTART="$SERVER start"
SERVERUPDATE="$SERVER update && $SERVER mods-update"

# AMAP:
SCRIPTS="$SCRIPT_DIR/Files/Scripts"
FILES="$SCRIPT_DIR/Files/"
AMAPNC="$SCRIPT_DIR/./AMAPNC.sh"
AMAP="$SCRIPT_DIR/./AMAP.sh"
CONFIG="Files/config.sh"
AMAPLOGO="Files/logo"
OPTIONS="Files/menu"
SERVERMAN="Files/servman"
WIPECON="Files/wipecon"
LOGGING="Files/logging"
BACKUPCON="Files/backup"

# Running Scripts:
LOGCLEANER="$SCRIPT_DIR/Files/Scripts/./LogCleaner.sh"
SERVERBACKUP="$SCRIPT_DIR/Files/Scripts/./ServerBackups.sh"
WIPECONFIGURE="$SCRIPT_DIR/Files/Scripts/./WipeConfigure.sh"

# Sripts File Locations:
FULLWIPESH="$SCRIPT_DIR/Files/Scripts/Fullwipe.sh"
MAPWIPESH="$SCRIPT_DIR/Files/Scripts/Mapwipe.sh"
NIGHTLYSH="$SCRIPT_DIR/Files/Scripts/Nightly.sh"
SERVERBACKUPSH="$SCRIPT_DIR/Files/Scripts/ServerBackup.sh"
SERVERCHECKERSH="$SCRIPT_DIR/Files/Scripts/ServerChecker.sh"
SERVERSTARTSH="$SCRIPT_DIR/Files/Scripts/ServerStart.sh"
SCHEDULESH="$SCRIPT_DIR/Files/Scripts/Schedule.sh"
LOGCLEANERSH="$SCRIPT_DIR/Files/Scripts/LogCleaner.sh"
EAMAPSH="$SCRIPT_DIR/AMAP.sh"

#OXIDE LOCATIONS:
OXIDECONFIG="$SCRIPT_DIR/serverfiles/oxide/config/"
OXIDEPLUGINS="$SCRIPT_DIR/serverfiles/oxide/plugins/"
AUTOMATEDEVENTS="$SCRIPT_DIR/serverfiles/oxide/config/AutomatedEvents.json"
BACKPACKS="$SCRIPT_DIR/serverfiles/oxide/config/Backpacks.json"
BETTERCHAT="$SCRIPT_DIR/serverfiles/oxide/config/BetterChat.json"
BGRADE="$SCRIPT_DIR/serverfiles/oxide/config/BGrade.json"
CUSTOMICON="$SCRIPT_DIR/serverfiles/oxide/config/CustomIcon.json"
DISCORDREPORT="$SCRIPT_DIR/serverfiles/oxide/config/DiscordReport.json"
EDITKITS="$SCRIPT_DIR/serverfiles/oxide/data/Kits/kits_data.json"
MAGICIMAGESPANEL="$SCRIPT_DIR/serverfiles/oxide/config/MagicPanel/MagicImagesPanel.json"
MAGICMESSAGEPANEL="$SCRIPT_DIR/serverfiles/oxide/config/MagicPanel/MagicMessagePanel.json"
MAGICPANEL="$SCRIPT_DIR/serverfiles/oxide/config/MagicPanel/MagicPanel.json"
RUSTCORD="$SCRIPT_DIR/serverfiles/oxide/config/Rustcord.json"
SERVERINFO="$SCRIPT_DIR/serverfiles/oxide/config/ServerInfo.json"
SMARTCHATBOT="$SCRIPT_DIR/serverfiles/oxide/config/SmartChatBot.json"
TIMEDEXECUTE="$SCRIPT_DIR/serverfiles/oxide/config/TimedExecute.json"
VIPTRIAL="$SCRIPT_DIR/serverfiles/oxide/config/VIPTrial.json"
RUSTMOVE="mv lgsm /home/$USERNAME/ && mv rustserver /home/$USERNAME/ && mv linuxgsm.sh /home/$USERNAME/"

# Scripts
SERVERNAME="Rust"
SAYDATE="echo $(date)"
USER="sudo -u $USERNAME "
SYNC="rsync --copy-links -avzh -s --delete"
SAY="echo $(date)"
BACKUPS="$DIR/Files/RustBackups/"
LOGS="$DIR/Files/Logs/Logs.txt"
SERVERNAME="Rust"
CLEANLOGS="echo > $LOGS"
SERVER="/home/$USERNAME/./rustserver"
