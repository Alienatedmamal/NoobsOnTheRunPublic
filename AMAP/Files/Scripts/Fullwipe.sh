#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


#Stops Server, Updates, Updates Mods, Performs Full Wipe.
        $SAYDATE $SCRIPTFULL $SERVERNAME Server will now stop.... >> $LOGS
$USER $SERVER stop >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Has Stopped >> $LOGS ||
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Has Failed to Stop >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server will now update.... >> $LOGS
$USER $SERVER update >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server has updated >> $LOGS ||
        $SAYDATE $SCRIPTFULL $SERVERNAME Server has failed to update >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Plugins will now update... >> $LOGS
$USER $SERVER mods-update >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Plugins have updated >> $LOGS ||
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Plugins failed to update >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server will now begin full wipe.... >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Removing Players Data..... >> $LOGS
rm -fr /home/$USERNAME/serverfiles/server/$HOSTNAME/player* >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Player Data has been removed >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Map data does not need to be removed >> $LOGS
        $SAYDATE $SCRIPTFULL $SERVERNAME Server Has Been Full-wiped>> $LOGS ||
        $SAYDATE $SCRIPTFULL $SERVERNAME Full-wipe Has Failed to Wipe >> $LOGS
