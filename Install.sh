#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/config.sh

echo "This project is still in the works any issues please report"
sleep 1 
echo "NOW STARTING....."
sleep 1
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
  "$DIR/$FILELOC/PluginsMove.sh"
  "$DIR/$FILELOC/ServerConfigurator.sh"
)

total_files=${#files[@]}
current_file=1

# List of packages to install
packages=(
    bc
    binutils
    bsdmainutils
    bzip2
    ca-certificates
    cpio
    curl
    distro-info
    file
    gzip
    hostname
    jq
    lib32gcc-s1
    lib32stdc++6
    lib32z1
    libsdl2-2.0-0:i386
    netcat
    python3
    steamcmd
    tar
    tmux
    unzip
    util-linux
    uuid-runtime
    wget
    xz-utils
)

# Function to display the progress bar
function show_progress {
    local current=$1
    local total=$2
    local width=50
    local progress=$((current * width / total))
    local dots=$((width - progress))
    
    printf "\r[%-${progress}s%*s] %d/%d" "" "$dots" "$current" "$total"
}

# Function to check if a package is installed
function is_installed {
    dpkg -l "$1" &> /dev/null
}

# Install packages with status bar
total_packages=${#packages[@]}
current_package=0


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
echo "Checking for RSYNC installation"
sleep 1 
if ! command -v rsync &> /dev/null
then
    echo "RSYNC is not installed, installing now..."
    sudo apt-get update
    sudo apt-get install rsync -y
    echo "Installation of RSYNC Completed" || { echo "RSYNC Failed to install"; exit 1; }
else
    echo "RSYNC is already installed"
fi
echo "Checking for nano text editor"
sleep 1
if ! command -v nano &> /dev/null
then
    echo "RSYNC is not installed, installing now..."
    sudo apt-get update
    sudo apt-get install nano -y
    echo "Nano Editor Installed" || { echo "NANO Failed to install"; exit 1; }
else
    echo "Nano is already installed"
fi
sleep 1 
echo "Installing packages:"
sleep 2 
for package in "${packages[@]}"; do
    ((current_package++))
    show_progress "$current_package" "$total_packages"
    
    # Check if the package is already installed
    if is_installed "$package"; then
        echo -e "Package $package is already installed. Skipping."
    else
        # Install the package
        sudo apt-get install -y "$package" > /dev/null 2>&1
        
        # Check installation status
        if [ $? -eq 0 ]; then
            echo -e "Package $package installed successfully."
        else
            echo -e "Failed to install package $package."
        fi
    fi
done
echo 
echo "Installation is now completed. Starting AMAP"
sleep 2 
echo "Edit config.sh file to finish Installation"
sleep 2 
cd ..//
rm -fr NoobsOnTheRunPublic
cd AMAP 
nano config.sh
./AMAP.sh


