#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

echo "This is going to the install of the rust server"

# Download and install the rust server then run 
$INSTALLRUST
sleep 3
echo "Starting Rust Server" 

