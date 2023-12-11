#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh


echo "NOW STARTING....." && sleep 1
echo "Making files Executable"
chmod +x $DIR/$FILELOC/Fullwipe.sh
chmod +x $DIR/$FILELOC/Mapwipe.sh
chmod +x $DIR/$FILELOC/LogCleaner.sh
chmod +x $DIR/$FILELOC/Nightly.sh
chmod +x $DIR/$FILELOC/Schedule.sh
chmod +x $DIR/$FILELOC/ServerBackup.sh
chmod +x $DIR/$FILELOC/ServerChecker.sh
chmod +x $DIR/$FILELOC/ServerStart.sh
chmod +x $DIR/$FILELOC/wipeconfigure.sh
chmod +x $DIR/$FILELOC/Wipeconfigure.sh
echo "Files are now Executable"
sleep 1
echo "Moving AMAP files"
mv AMAP ..// &&
echo "Move Completed" || echo "FAILED TO MOVE FILES"
