#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


# Check if RustDedicated is running
if pgrep -x "RustDedicated" > /dev/null
then
    echo "$(date)" "ServerChecker: Rust Server  is running." >> "$LOGS"
    cat $DIR/Files/Scripts/Online > $DIR/Files/Scripts/Status
else
    # If RustDedicated is not running, run the test script
    $SERVERSTART
    cat $DIR/Files/Scripts/Offline > $DIR/Files/Scripts/Status
    # Wait for 5 seconds
    sleep 5

    # Check again if RustDedicated is running after 5 seconds
    if pgrep -x "Rustedicated" > /dev/null
    then
        echo "$(date)" "ServerChecker: Rust Server is now running." >> "$LOGS"
        cat $DIR/Files/Scripts/Online > $DIR/Files/Scripts/Status
    else
        cat $DIR/Files/Scripts/Offline > $DIR/Files/Scripts/Status
        discord_url="$DISCORDURL"

generate_post_data() {
  cat <<EOF
{
  "content": ":warning: SERVER IS OFFLINE",
  "embeds": [{
    "title": "SERVER IS OFFLINE AND NEEDS ATTENTION!!",
    "description": "Server is offline and has failed to restart. Attention is needed!",
    "color": "11086"
  }]
}
EOF
}


# POST request to Discord Webhook
curl -H "Content-Type: application/json" -X POST -d "$(generate_post_data)" $discord_url
    fi
fi
