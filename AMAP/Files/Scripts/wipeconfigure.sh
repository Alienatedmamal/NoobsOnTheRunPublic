#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Ask for user input
read -p "Enter the Year : " YR
read -p "Enter the Month : " MN
read -p "Enter the Day : " DY
read -p "Enter the old Seed: " OS
read -p "Enter the new Seed: " NS
read -p "Enter the old Year: " OYR
read -p "Enter the old Month: " OMN
read -p "Enter the old Day: " ODY
read -p "Is it a Full-wipe or a Map-wipe? (Type 'Full' or 'Map'): " WIPE_TYPE

# Define the output file path
OUTPUT_FILE="$WIPER"

# Generate output based on the wipe type
if [ "$WIPE_TYPE" == "Full" ]; then
   WIPE_COMMAND="commands[\"20$OYR-$OMN-$ODY\"]=\"/home/$USERNAME/AMAP/Files/Scripts/./Fullwipe.sh && sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/ServerInfo.json ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json ; echo Files have been copied >> $LOGS || echo Failed to copy files >> $LOGS && /home/$USERNAME/ServerStart.sh" >> "$OUTPUT_FILE"
echo "$WIPE_COMMAND" >> "$OUTPUT_FILE"
elif [ "$WIPE_TYPE" == "Map" ]; then
    WIPE_COMMAND="commands[\"20$OYR-$OMN-$ODY\"]=\"/home/$USERNAME/AMAP/Files/Scripts/./Mapwipe.sh && sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/ServerInfo.json ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json ; echo Files have been copied >> $LOGS || echo Failed to copy files >> $LOGS && /home/$USERNAME/ServerStart.sh" >> "$OUTPUT_FILE"
 echo "$WIPE_COMMAND" >> "$OUTPUT_FILE"
else
    echo "Invalid wipe type. Please enter 'Full' or 'Map'."
    exit 1
fi

# Provide feedback to the user
echo "Wipe details have been written to $OUTPUT_FILE"
