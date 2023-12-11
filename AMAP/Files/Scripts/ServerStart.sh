#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"
SCRIPT="ServerStart:"


#This is to start the rust server. 
	$USER $SERVER start >> $LOGS ;
        $SAY $SCRIPT $SERVERNAME Server Has Started >> $LOGS ||
        $SAY $SCRIPT $SERVERNAME Server Has Failed To Start >> $LOGS
