#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


#Stops Server, Performs Map Wipe.
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Server will now stop.... >> $LOGS
$USER $SERVER stop >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Server Has Stopped >> $LOGS ||
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Server Has Failed to Stop >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Server will now begin map wipe....  >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Removing Map Data..... >> $LOGS
rm -fr /home/$USERNAME/serverfiles/server/$HOSTNAME/proceduralmap* >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Player Data has been removed >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAME Map wipe has been completed.  >> $LOGS ||
        $SAYDATE $SCRIPTMAPWIPE $SERVERNAMEMap has FAILED to Wipe  >> $LOGS
        sleep 1
        $SAYDATE $SCRIPTMAPWIPE Automation Map wipe completed  >> $LOGS
        $SAYDATE $SCRIPTMAPWIPE Starting Server Now.....  >> $LOGS
