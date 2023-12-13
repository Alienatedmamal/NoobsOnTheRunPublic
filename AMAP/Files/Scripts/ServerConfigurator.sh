#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Prompt the user for input
read -p "Server IP:(0.0.0.0 or if server has its own public) " ip
read -p "Server port:(default 28015) " port
read -p "RCON port:(default 28016) " rconport
read -p "App port:(default 28082) " appport
read -p "Query port:(default 28017) " queryport
read -p "RCON password: " rconpassword
read -p "RCON web (1 for Facepunch web panel, Rustadmin, etc. / 0 for RCON tools DEFAULT 1): " rconweb
read -p "Server name: " servername
read -p "Self Name:(nospaces) " selfname
read -p "Game mode:(vanilla, softcore) " gamemode
read -p "Server level:(Procedural Map, Barren, HapisIsland, SavasIsland) " serverlevel
read -p "Custom level URL:(leave blank if N/A) " customlevelurl
read -p "Seed: " seed
read -p "Max players: " maxplayers
read -p "World size: " worldsize
read -p "Description:(use \n for next line) " description
read -p "Header image URL: " headerimage
read -p "Server URL: " serverurl

# Create a copy in /home/alienatedmammal/Documents
backup_dir="/home/$USERNAME/AMAP/Files/"
backup_file="/home/$USERNAME/AMAP/Files/common.cfg"

# Create a backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Write the configuration to the backup file
cat <<EOL > "$backup_file"
stats="on"
ip="0.0.0.0"
port="$port"
rconport="$rconport"
appport="$appport"
queryport="$queryport"
rconpassword="$rconpassword"
rconweb="$rconweb"
servername="$servername"
selfname="$selfname"
gamemode="$gamemode"
serverlevel="$serverlevel"
customlevelurl="$customlevelurl"
seed="$seed"
salt=""
maxplayers="$maxplayers"
worldsize="$worldsize"
saveinterval="600"
tickrate="30"
description="$description"
headerimage="$headerimage"
serverurl="$serverurl"
#Add to config
$(cat "$SERVER_LOCATION/AMAP/Files/Config/finish")
EOL

echo "Configuration backup created at: $backup_file"
