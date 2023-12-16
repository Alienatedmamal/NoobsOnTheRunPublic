#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


echo "Getting Updates Ready"
sleep 2
echo "Clear old updates...."
updater_directory="$DIR/Files/Updater/"

# Check if the directory exists
if [ -d "$updater_directory" ]; then
    # Directory exists, remove it
    rm -fr "$updater_directory"
    echo "Updater directory deleted."
else
    echo "Updater directory does not exist."
fi
sleep 2
echo "Downloading latest Updates....."
sleep 2
git clone https://github.com/Alienatedmamal/Updater.git
echo "Download Completed" || echo "Failed to Download"
sleep 2
mv $DIR/Updater $DIR/Files
echo "File move complted.." || echo "Failed to move files"
sleep 2
chmod +x $DIR/Updater/Update/update.sh
echo "Updater is now ready to start...." || echo "Updater Failed to execute...."
sleep 2
echo "Starting Updater...."
$DIR/Updater/Update/./update.sh

echo "Updates completed" || echo "Updates Failed"
exit 0
