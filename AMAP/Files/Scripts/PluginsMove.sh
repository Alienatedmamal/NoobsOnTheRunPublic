#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Define source and target directories
source_dir="$DIR/Files/plugins"
target_dir="/home/$USERNAME/serverfiles/oxide/plugins"

# Start right with a good old clean screen. 
clear 
# Create target directory if it doesn't exist
mkdir -p "$target_dir"

# Array of available plugins
files=(
"BetterChatFlood.cs"
"BetterSay.cs"
"BGrade.cs"
"BlueprintManager.cs"
"BodiesToBags.cs"
"BuildingSkins.cs"
"BypassQueue.cs"
"ColouredChat.cs"
"CopyPaste.cs"
"CustomIcon.cs"
"DiscordReport.cs"
"DiscordStatus.cs"
"FireworkGun.cs"
"Freeze.cs"
"ImageLibrary.cs"
"InfiniteAmmo.cs"
"InventoryViewer.cs"
"Kits.cs"
"LoadingMessages.cs"
"MagicImagesPanel.cs"
"MagicMessagePanel.cs"
"MagicPanel.cs"
"NoGiveNotices.cs"
"Payback.cs"
"PermissionsManager.cs"
"PlayerAdministration.cs"
"Rustcord.cs"
"ServerInfo.cs"
"ServerPop.cs"
"Skins.cs"
"SkipNightVote.cs"
"SmartChatBot.cs"
"TimedExecute.cs"
"TimeOfDay.cs"
"UFilter.cs"
"Vanish.cs"
"VIPTrial.cs"
"VoiceMute.cs"
"Welcomer.cs"
)

# Display the list of available plugins
echo "Available plugins:"
for ((i = 0; i < ${#files[@]}; i++)); do
  echo "$((i + 1)): ${files[i]}"
done

# Prompt user to select plugins to move
echo "Select plugins to move (e.g., 1-4,6-11,9,13,16):"
read -r input

# Split the input into an array of selected indices
IFS=',' read -ra indices <<< "$input"

for index in "${indices[@]}"; do
  # Check if the index is a range
  if [[ $index =~ ^([0-9]+)-([0-9]+)$ ]]; then
    start=${BASH_REMATCH[1]}
    end=${BASH_REMATCH[2]}
    for ((i = start; i <= end; i++)); do
      plugin="${files[i - 1]}"
      cp "$source_dir/$plugin" "$target_dir/"
      echo "Plugin '$plugin' copied to $target_dir"
    done
  else
    # If it's a single index
    plugin="${files[index - 1]}"
    cp "$source_dir/$plugin" "$target_dir/"
    echo "Plugin '$plugin' copied to $target_dir"
  fi
done
