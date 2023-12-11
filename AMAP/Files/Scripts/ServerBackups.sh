#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"
SCRIPT="ServerBackup:"




$SAYDATE $SCRIPT ServerBackups starting >> $LOGS && 
	$SYNC /home/alienatedmammal/serverfiles/oxide $BACKUPS && 
$SAYDATE $SCRIPT Oxide Files Have Been Backed Up >> $LOGS || $SAYDATE Failed To Backup Oxide >> $LOGS && 
	$SYNC /home/alienatedmammal/serverfiles/server/NoobsOnTheRun $BACKUPS && 
$SAYDATE $SCRIPT NoobsOnTheRun Files Have Been Backed Up >> $LOGS || $SAYDATE Failed To Backup NoobsOnTheRun >> $LOGS && 
	$SYNC /home/alienatedmammal/lgsm $BACKUPS && 
$SAYDATE $SCRIPT lgsm Files Have Been Backed Up >> $LOGS || $SAYDATE Failed To Backup lgsm >> $LOGS &&
	$SYNC /home/alienatedmammal/lgsm/config-lgsm/rustserver $BACKUPS && 
$SAYDATE $SCRIPT rustserver Files Have Been Backed Up >> $LOGS || $SAYDATE $SCRIPT Failed To Backup rustserver >> $LOGS &&
$SAYDATE $SCRIPT ServerBackup Has Finished >> $LOGS 
