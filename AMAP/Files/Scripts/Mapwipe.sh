#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"
SCRIPT="MapeWipe:"

#Stops Server, Performs Map Wipe.  
	$SAYDATE $SCRIPT $SERVERNAME Server will now stop >> $LOGS
$USER $SERVER stop >> $LOGS
	$SAYDATE $SCRIPT $SERVERNAME Server Has Stopped >> $LOGS || 
	$SAYDATE $SCRIPT $SERVERNAME Server Has Failed to Stop >> $LOGS  
	$SAYDATE $SCRIPT $SERVERNAME Server Map will now wipe  >> $LOGS 
$USER $SERVER map-wipe >> $LOGS 
	$SAYDATE $SCRIPT $SERVERNAME Map wipe has been completed.  >> $LOGS || 
	$SAYDATE $SCRIPT $SERVERNAMEMap has FAILED to Wipe  >> $LOGS 
	sleep 1 
	$SAYDATE $SCRIPT Automation Map wipe completed  >> $LOGS 
	$SAYDATE $SCRIPT Starting Server Now.....  >> $LOGS 

