#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"


# Check if RustDedicated is running
if pgrep -x "RustDedicated" > /dev/null
then
    echo "$(date)" "ServerChecker: Rust Server  is running." >> "$LOGS"
    echo -e "\e[1;32m$(cat $DIR/Files/Images/Online)\e[0m" > $DIR/Files/Images/Status
else
    # If RustDedicated is not running, run the test script
    echo "$(date)" "ServerChecker: Rust not running. Attempting restart" >> "$LOGS"
    $SERVER start
    echo -e "\e[1;31m$(cat $DIR/Files/Images/Offline)\e[0m" > $DIR/Files/Images/Status
    # Wait for 5 seconds
    sleep 5

    # Check again if RustDedicated is running after 5 seconds
    if pgrep -x "Rustedicated" > /dev/null
    then
        echo "$(date)" "ServerChecker: Rust Server is now running." >> "$LOGS"
        echo -e "\e[1;32m$(cat $DIR/Files/Images/Online)\e[0m" > $DIR/Files/Images/Status
    else
        echo -e "\e[1;31m$(cat $DIR/Files/Images/Offline)\e[0m" > $DIR/Files/Images/Status
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
