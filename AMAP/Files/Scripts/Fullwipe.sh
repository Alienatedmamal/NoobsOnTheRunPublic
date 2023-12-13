#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


#Stops Server, Updates, Updates Mods, Performs Full Wipe.  
	$SAYDATE $SCRIPTFULL $SERVERNAME Server will now stop >> $LOGS &&
$USER $SERVER stop >> $LOGS &&
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Stopped >> $LOGS || 
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Failed to Stop >> $LOGS ; 

	$SAYDATE $SCRIPTFULL $SERVERNAME Server will now update >> $LOGS &&
$USER $SERVER update >> $LOGS &&
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Updated >> $LOGS || 
	$SAYDATE $SERVERNAME Server Failed To Update >> $LOGS ; 

	$SAYDATE $SCRIPTFULL $SERVERNAME Server mods will update >> $LOGS ;
$USER $SERVER mods-update >> $LOGS &&
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Mods Have Been Updated >> $LOGS || 
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Mods Have Failed to Update
