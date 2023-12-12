#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

echo "This is going to the install of the rust server"

# Download and install the rust server then run 
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh rustserver
echo "Install Completed" 
echo "Moving files" 
$RUSTMOVE
cd /home/$USERNAME/
echo "Files have been moved"
echo "Starting Rust Server Install" 
$USER $SERVER install

