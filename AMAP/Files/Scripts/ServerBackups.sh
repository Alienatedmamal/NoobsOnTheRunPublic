#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


$SAYDATE $SCRIPTBACKUPS ServerBackups starting >> $LOGS && 
	$SYNC /home/$USERNAME/serverfiles/oxide $BACKUPS && 
$SAYDATE $SCRIPTBACKUPS Oxide Files Have Been Backed Up >> $LOGS || $SAYDATE $SCRIPTBACKUPS Failed To Backup Oxide >> $LOGS && 
	$SYNC /home/$USERNAME/serverfiles/server/$HOSTNAME $BACKUPS && 
$SAYDATE $SCRIPTBACKUPS $HOSTNAME Files Have Been Backed Up >> $LOGS || $SAYDATE $SCRIPTBACKUPS Failed To Backup $HOSTNAME >> $LOGS && 
	$SYNC /home/$USERNAME/lgsm $BACKUPS && 
$SAYDATE $SCRIPTBACKUPS lgsm Files Have Been Backed Up >> $LOGS || $SAYDATE $SCRIPTBACKUPSFailed To Backup lgsm >> $LOGS &&
	$SYNC /home/$USERNAME/lgsm/config-lgsm/rustserver $BACKUPS && 
$SAYDATE $SCRIPTBACKUPS rustserver Files Have Been Backed Up >> $LOGS || $SAYDATE $SCRIPTBACKUPS Failed To Backup rustserver >> $LOGS &&
$SAYDATE $SCRIPTBACKUPS ServerBackup Has Finished >> $LOGS 
