#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

#Stops Server, Updates, Updates Mods, and Restart.  
	$SAYDATE $SCRIPTNIGHTLY Server will now stop >> $LOGS &&
$USER $SERVER stop >> $LOGS &&
	$SAYDATE $SCRIPTNIGHTLY $SERVERNAME Server Has Stopped >> $LOGS || 
	$SAYDATE $SCRIPTNIGHTLY $SERVERNAME Server Has Failed to Stop >> $LOGS 
 	$SAYDATE $SCRIPTNIGHTLY Restart Completed. Restarting Now.... >> $LOGS

