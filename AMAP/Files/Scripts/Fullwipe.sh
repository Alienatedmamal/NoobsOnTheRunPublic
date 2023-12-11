#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"
SCRIPT:="FullWipe:"


#Stops Server, Updates, Updates Mods, Performs Full Wipe.  
	$SAYDATE $SCRIPT $SERVERNAME Server will now stop >> $LOGS &&
$USER $SERVER stop >> $LOGS &&
	$SAYDATE $SCRIPT $SERVERNAME Server Has Stopped >> $LOGS || 
	$SAYDATE $SCRIPT $SERVERNAME Server Has Failed to Stop >> $LOGS ; 

	$SAYDATE $SCRIPT $SERVERNAME Server will now update >> $LOGS &&
$USER $SERVER update >> $LOGS &&
	$SAYDATE $SCRIPT $SERVERNAME Server Has Updated >> $LOGS || 
	$SAYDATE $SERVERNAME Server Failed To Update >> $LOGS ; 

	$SAYDATE $SCRIPT $SERVERNAME Server mods will update >> $LOGS ;
$USER $SERVER mods-update >> $LOGS &&
	$SAYDATE $SCRIPT $SERVERNAME Server Mods Have Been Updated >> $LOGS || 
	$SAYDATE $SCRIPT $SERVERNAME Server Mods Have Failed to Update
