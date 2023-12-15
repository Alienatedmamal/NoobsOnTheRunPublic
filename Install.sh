#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh


clear
sleep 1 
echo "Getting AMAP Ready.."
sleep 1 
clear
echo "Getting AMAP Ready..."
sleep 1
clear
echo "Getting AMAP Ready...."
sleep 1 
clear
echo "This project is still in the works any issues please report on Github."
sleep 3
echo "NOW STARTING....."
sleep 2

echo "Making files Executable"
sleep 2 

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
  "$DIR/$FILELOC/PluginsMove.sh"
  "$DIR/$FILELOC/ServerConfigurator.sh"
  "$DIR/$FILELOC/RMPlugins.sh"
  "$DIR/$FILELOC/Updater.sh"
)

total_files=${#files[@]}
current_file=1


for file in "${files[@]}"; do
  echo "Progress: [$((current_file * 100 / total_files))%]"

  chmod +x "$file"

  ((current_file++))
done

echo "Files are now Executable"
sleep 2
chmod +x Scripts/checkuser
echo "Getting Systems Username for Config file...."
sleep 2 
$USER
echo "Username Updated" || echo "Failed to get Username edit file manually" 
sleep 2 
echo "Moving AMAP files"
mv AMAP ..//
echo "Move Completed" || echo "Failed"
echo "Checking for RSYNC installation"
sleep 2 
if ! command -v rsync &> /dev/null
then
    echo "RSYNC is not installed, installing now..."
    sudo apt-get update
    sudo apt-get install rsync -y
    echo "Installation of RSYNC Completed" || { echo "RSYNC Failed to install"; exit 1; }
else
    echo "RSYNC is already installed"
fi
# D2s Fav editor ;D 
echo "Checking for nano text editor"
sleep 2
if ! command -v nano &> /dev/null
then
    echo "Nano is not installed, installing now..."
    sudo apt-get update
    sudo apt-get install nano -y
    echo "Nano Editor Installed" || { echo "NANO Failed to install"; exit 1; }
else
    echo "Nano is already installed"
fi
sleep 2 
echo "Getting Packages Ready..."
sleep 2
chmod +x Scripts/PackageInstaller.sh
sleep 2
$PACKINSTALL &&
clear
echo "Installation is now completed. Starting AMAP"
sleep 2 
cd ..//
rm -fr NoobsOnTheRunPublic
cd AMAP 
Files/Scripts/./Updater.sh
clear
echo "Edit Config File Before Starting AMAP"
echo "Press ENTER to continue"
read -r
nano config.sh 
./AMAP.sh
