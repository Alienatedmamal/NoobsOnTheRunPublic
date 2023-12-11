#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

echo "This is going to the install of the rust server"

# Download and install the rust server then run 
wget -P $SERVER_LOCATION -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh rustserver
sleep 3
echo "Starting Rust Server" 

