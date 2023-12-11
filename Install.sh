#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

echo "NOW STARTING....." && sleep 1
echo "Making files Executable"

# List of files to make executable
files=(
  Fullwipe.sh
  Mapwipe.sh
  LogCleaner.sh
  Nightly.sh
  Schedule.sh
  ServerBackups.sh
  ServerChecker.sh
  ServerStart.sh
  wipeconfigure.sh
  Wipeconfigure.sh
)

# Function to display a progress bar
progress_bar() {
  local duration="$1"
  local bar_length=30
  local sleep_duration=$(echo "$duration / $bar_length" | bc -l)

  for ((i = 0; i < bar_length; i++)); do
    echo -ne "\r["
    for ((j = 0; j <= i; j++)); do
      echo -ne "="
    done
    for ((j = i + 1; j < bar_length; j++)); do
      echo -ne " "
    done
    echo -ne "] $((i * 100 / (bar_length - 1)))%"
    sleep "$sleep_duration"
  done
  echo -e "\nDone."
}

# Make files executable with progress bar
for file in "${files[@]}"; do
  chmod +x "$DIR/$FILELOC/$file"
  echo "File $file is now executable"
done | progress_bar 5  # Adjust the duration as needed

echo "Moving AMAP files"
mv AMAP ..// &&
echo "Move Completed" || echo "FAILED TO MOVE FILES"

