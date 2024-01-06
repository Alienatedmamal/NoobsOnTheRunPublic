#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source $DIR/config.sh


# Yuup just need it to do one thing...Clean the logs. 
echo > $LOGS
echo "$(date)" $SCRIPTLOGCLEAN Logs have been cleared >> $LOGS || echo "$(date)" $SCRIPTLOGCLEAN Failed to clear logs.. >> $LOGS
