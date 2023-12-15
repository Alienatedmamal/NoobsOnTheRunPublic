#!/bin/bash
DIR="$(cd "$(dirname "$0")"/../../ && pwd)"
source "$DIR/config.sh"

echo "Getting Updates Ready...."
sleep 1
echo "Downloading Updates...."
git clone https://github.com/Alienatedmamal/Updater.git "$DIR/Files/Scripts/Updater"
echo "Download Completed"
sleep 1
echo "Moving Updates...."
sleep 1
cp "$DIR/Files/Scripts/Updater/Update" "$DIR/Files/"
sleep 1
echo "Files have moved" || echo "Files have FAILED to move"
chmod +x "$DIR/Files/Update/update.sh"
echo "Update is now executable"
$UPDATER
