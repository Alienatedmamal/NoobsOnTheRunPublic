#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


#Stops Server, Updates, Updates Mods, Performs Full Wipe.  
	$SAYDATE $SCRIPTFULL $SERVERNAME Server will now Full wipe >> $LOGS
rm -fr /home/$USERNAME/serverfiles/server/$HOSTNAME/player* >> $LOGS
  	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Been Full-wiped>> $LOGS || 
	$SAYDATE $SCRIPTFULL $SERVERNAME Full-wipe Has Failed to Wipe   

 	$SAYDATE $SCRIPTFULL $SERVERNAME Server will now stop >> $LOGS &&
$USER $SERVER stop >> $LOGS &&
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Stopped >> $LOGS || 
	$SAYDATE $SCRIPTFULL $SERVERNAME Server Has Failed to Stop >> $LOGS   
