#!/bin/bash
DIR="$(cd "$(dirname "$0")"/../../ && pwd)"
source "$DIR/config.sh"

echo "Getting Updates Ready...."
sleep 1
echo "Downloading Updates...."
git clone https://github.com/Alienatedmamal/Updater.git
echo "Download Completed"
sleep 1
echo "Moving Updates...."
sleep 1
mv -f "$DIR/Files/Scripts/Updater" "$DIR/Files/"
sleep 1
echo "Files have moved" || echo "Files have FAILED to move"
chmod +x "$DIR/Files/Update/update.sh"
echo "Update is now executable"
$UPDATER
