#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source $DIR/config.sh

#SCRIPT="LogCleaner:"

# Yuup just need it to do one thing...Clean the logs. 
echo > $LOGS
echo "$(date)" $SCRIPT Logs have been cleared >> $LOGS || echo "$(date)" $SCRIPT Failed to clear logs.. >> $LOGS
