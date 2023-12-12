#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

echo "This project is still in the works any issues please report"
sleep 1 
echo "NOW STARTING....." && sleep 1
echo "Making files Executable"
sleep 1 

files=(
  "$DIR/$FILELOC/RustServerInstall.sh"
  "$DIR/$FILELOC/Fullwipe.sh"
  "$DIR/$FILELOC/Mapwipe.sh"
  "$DIR/$FILELOC/LogCleaner.sh"
  "$DIR/$FILELOC/Nightly.sh"
  "$DIR/$FILELOC/Schedule.sh"
  "$DIR/$FILELOC/ServerBackups.sh"
  "$DIR/$FILELOC/ServerChecker.sh"
  "$DIR/$FILELOC/ServerStart.sh"
  "$DIR/$FILELOC/wipeconfigure.sh"
  "$DIR/$FILEMAIN/AMAP.sh"
  "$DIR/$FILEMAIN/AMAPNC.sh"
)

total_files=${#files[@]}
current_file=1

for file in "${files[@]}"; do
  echo "Progress: [$((current_file * 100 / total_files))%]"

  chmod +x "$file"

  ((current_file++))
done

echo "Files are now Executable"
sleep 1
echo "Moving AMAP files"
mv AMAP ..//
echo "Move Completed" || echo "Failed"
echo "Install RSYNC" 
sudo apt install rsync -y 
echo "Installation of RSYNC Completed" || echo "RSYNC Failed to install"
sleep 1 
cd ..//
cd AMAP 
./AMAP


