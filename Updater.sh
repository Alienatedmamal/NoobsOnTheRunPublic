#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh


echo "Pulling updates...."
git clone https://github.com/Alienatedmamal/Updater.git &&
echo "File Download Completed"
mv -f Updater/ $DIR/AMAP/Files/ &&
echo "AMAP is now Updated" || echo "AMAP has Failed to Update" &&
chmod +x $DIR/AMAP/Files/Updater/Update/update.sh
sleep 1
echo "Starting Updater"

$DIR/AMAP/Files/Updater/Update/./update.sh &&

sleep 1
rm -fr $DIR/AMAP/Files/Updater

echo "done"
