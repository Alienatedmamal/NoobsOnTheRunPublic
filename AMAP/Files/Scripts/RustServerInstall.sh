#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

echo "This is going to the install of the rust server"

# Download and install the rust server then run 
wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh rustserver
sleep 3
echo "Install Completed" 
echo "Moving files" 
mv lgsm /home/$USERNAME/
mv rusterver /home/$USERNAME/
mv linuxgsm.sh /home/$USERNAME/
echo "Files have been moved"
echo "Starting Rust Server Install" 
/home/$USERNAME/./rustserver install

