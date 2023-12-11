#!/bin/bash

LOG_FILE="/home/alienatedmammal/Documents/RustBackups/wipescripts/Logs/Logs.txt"

# Check if RustDedicated is running
if pgrep -x "RustDedicated" > /dev/null
then
    echo "$(date)" "ServerChecker: Rust Server  is running." >> "$LOG_FILE"
else
    # If RustDedicated is not running, run the test script
    /home/alienatedmammal/Documents/RustBackups/wipescripts/./ServerStart.sh

    # Wait for 5 seconds
    sleep 5 

    # Check again if RustDedicated is running after 5 seconds
    if pgrep -x "RustDedicated" > /dev/null
    then
        echo "$(date)" "ServerChecker: Rust Server is now running." >> "$LOG_FILE"
    else
        discord_url="https://discord.com/api/webhooks/1181718409466097765/l6rD3t6sVc-z6sDVUk3QsQbyFA7kryIOPlDMIwGKHaqkvKgl0r0mDSUcGvwesHTEi9yw"

generate_post_data() {
  cat <<EOF
{
  "content": ":warning:SERVER IS OFFLINE",
  "embeds": [{
    "title": "SERVER IS OFFLINE AND NEED ATTENTION!!",
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
