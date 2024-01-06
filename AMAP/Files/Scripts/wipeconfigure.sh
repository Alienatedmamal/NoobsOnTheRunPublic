#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Function to print in green
print_green() {
  echo -e "\e[32m$1\e[0m"
}
# Ask for user input in green
print_green "Enter the Start date of wipe must include space (MN DY YR) e.g. 1 4 21 : "
read OMN ODY OYR

print_green "Enter the End Date of wipe (YR MN DY) e.g. 1 18 24 : "
read MN DY YR

print_green "Enter the Previous Seed (see WipeOutput.txt) : "
read OS

print_green "Enter the New map Seed: "
read NS

print_green "Is it a Full-wipe (including BP's) or a Map-wipe (BP's Not Included)? (Type 'Full' or 'Map'): "
read WIPE_TYPE


# Define the output file path
OUTPUT_FILE="$WIPER"

# Generate output based on the wipe type
if [ "$WIPE_TYPE" == "Full" ]; then
   WIPE_COMMAND="commands[\"20$OYR-$OMN-$ODY\"]=\"/home/$USERNAME/AMAP/Files/Scripts/./Fullwipe.sh && sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/ServerInfo.json ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json ; echo Files have been copied >> $LOGS || echo Failed to copy files >> $LOGS && /home/$USERNAME/AMAP/Files/Scripts/./ServerStart.sh\""
echo "$WIPE_COMMAND" >> "$OUTPUT_FILE"
elif [ "$WIPE_TYPE" == "Map" ]; then
    WIPE_COMMAND="commands[\"20$OYR-$OMN-$ODY\"]=\"/home/$USERNAME/AMAP/Files/Scripts/./Mapwipe.sh && sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OS/$NS/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/common.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/lgsm/config-lgsm/rustserver/rustserver.cfg ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/ServerInfo.json ; sed -i 's/$OMN\/$ODY\/$OYR/$MN\/$DY\/$YR/g' /home/$USERNAME/serverfiles/oxide/config/SmartChatBot.json ; echo Files have been copied >> $LOGS || echo Failed to copy files >> $LOGS && /home/$USERNAME/AMAP/Files/Scripts/./ServerStart.sh\""
echo "$WIPE_COMMAND" >> "$OUTPUT_FILE"

else
    echo "Invalid wipe type. Please enter 'Full' or 'Map'."
    exit 1
fi

# Provide feedback to the user
echo "Wipe details have been written to $OUTPUT_FILE"
