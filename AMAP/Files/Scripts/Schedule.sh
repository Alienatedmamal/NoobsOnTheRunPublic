#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Get Todays Date. YYYY-MM-DD
current_date=$(date +"%Y-%m-%d")

# Run the Wipe Configurator in AMAP. It will create a file for this to read.
# commands YR-MON-Day["TARGET-DATE-YOU-WANT"]="THE COMMAND YOU WANT TO RUN"

declare -A commands

# This is the output of Wipe Configurator
source "$DIR/Files/Logs/WipeOutput.txt"



# Check if the current date matches any of the target dates
for target_date in "${!commands[@]}"; do
    if [ "$current_date" == "$target_date" ]; then
        # Run the corresponding command for the matched date
        echo "$DATE Schedule: Today's date matches a target date ($target_date). Running the command..." >> $LOGS
        eval "${commands[$target_date]}"
        exit 0
    fi
done

# If no matches
echo "$DATE Schedule: There is no wipe this week." >> $LOGS
