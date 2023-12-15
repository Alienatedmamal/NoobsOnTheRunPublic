#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"



#This is to start the rust server. 
	$SAY $SCRIPTSERVERSTART $SERVERNAME Server Starting..... >> $LOGS
	$USER $SERVER start >> $LOGS 
        $SAY $SCRIPTSERVERSTART $SERVERNAME Server Has Started >> $LOGS ||
        $SAY $SCRIPT$SCRIPTSERVERSTART $SERVERNAME Server Has Failed To Start >> $LOGS
