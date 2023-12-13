#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

#Stops Server, Updates, Updates Mods, and Restart.  
	$SAYDATE $SCRIPTNIGHTLY Server will now stop >> $LOGS &&
$USER $SERVER stop >> $LOGS &&
	$SAYDATE $SERVERNAME $SCRIPTNIGHTLY Server Has Stopped >> $LOGS || 
	$SAYDATE $SERVERNAME $SCRIPTNIGHTLY Server Has Failed to Stop >> $LOGS 
# Currently this stops any plugins from working after an update. Working on a fix. See GitHub for more information 
#	$SAYDATE $SERVERNAME $SCRITPNAME will Now Update >> $LOGS &&
#$USER $SERVER update >> $LOGS &&
#	$SAYDATE $SERVERNAME $SCRITPNAME Server Has Updated >> $LOGS || 
#	$SAYDATE $SERVERNAME $SCRITPNAME Server Failed To Update >> $LOGS ; 
#	$SAYDATE $SERVERNAME $SCRITPNAME Server MODS Will Update >> $LOGS ;
#$USER $SERVER mods-update >> $LOGS &&
#	$SAYDATE $SERVERNAME $SCRITPNAME Server Mods Have Been Updated >> $LOGS || 
#	$SAYDATE $SERVERNAME $SCRITPNAME Server Mods Have Failed to Update && 
#    $SAYDATE $SCRITPNAME Nightly Restart Completed. Restarting Now.... >> $LOGS 

