#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Get Todays Date. YYYY-MM-DD
current_date=$(date +"%Y-%m-%d")

# Run the Wipe Configurator in AMAP. It will make a file in the Logs folder called WipeOutput.txt Copy and paste it below   
# commands YR-MON-Day["TARGET-DATE-YOU-WANT"]="THE COMMAND YOU WANT TO RUN"

declare -A commands
#commands["2023-12-07"]="/home/alienatedmammal/Documents/RustBackups/wipescripts/./Fullwipe.sh && sed -i 's/1113833374/4244780/g' /home/alienatedmammal/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/1113833374/4244780/g' /home/alienatedmammal/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/12\/7\/23/12\/21\/23/g' /home/alienatedmammal/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/12\/7\/23/12\/21\/23/g' /home/alienatedmammal/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/12\/7\/23/12\/21\/23/g' /home/alienatedmammal/serverfiles/oxide/config/ServerInfo.json ; sed -i 's/12\/7\/23/12\/21\/23/g' /home/alienatedmammal/serverfiles/oxide/config/SmartChatBot.json ; echo Files have been copied >> /home/alienatedmammal/Documents/RustBackups/wipescripts/Logs/Logs.txt || echo Failed to copy files >> /home/alienatedmammal/Documents/RustBackups/wipescripts/Logs/Logs.txt && /home/alienatedmammal/Documents/RustBackups/wipescripts/./ServerStart.sh"




# Check if the current date matches any of the target dates
for target_date in "${!commands[@]}"; do
    if [ "$current_date" == "$target_date" ]; then
        # Run the corresponding command for the matched date
        echo "Today's date matches a target date ($target_date). Running the command..." >> $LOGS
        eval "${commands[$target_date]}"
        exit 0
    fi
done

# If no matches 
echo "$(date)" "There is no wipe this week." >> $LOGS

