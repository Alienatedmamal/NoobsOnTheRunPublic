#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


# Check if RustDedicated is running
if pgrep -x "RustDedicated" > /dev/null
then
    echo "$(date)" "ServerChecker: Rust Server  is running." >> "$LOGS"
else
    # If RustDedicated is not running, run the test script
    $SERVERSTART

    # Wait for 5 seconds
    sleep 5 

    # Check again if RustDedicated is running after 5 seconds
    if pgrep -x "RustDedicated" > /dev/null
    then
        echo "$(date)" "ServerChecker: Rust Server is now running." >> "$LOGS"
    else
        discord_url=""$DISCORDURL""

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
