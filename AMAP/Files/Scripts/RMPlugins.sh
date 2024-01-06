#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Set the source and target directories
source_dir="/home/$USERNAME/serverfiles/oxide/plugins"

clear

# List of files
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

# Display the list of files for selection
echo "Select files to remove by entering the corresponding numbers separated by commas:"
echo "Example: 1-4,7-8,11,23,25"
for i in "${!files[@]}"; do
  echo "$((i+1)). ${files[i]}"
done

# Prompt the user for file selection
read -p "> " user_input

# Remove spaces and split the input by commas
ranges=($(echo "$user_input" | tr -d ' ' | tr ',' '\n'))

# Remove selected files
for range in "${ranges[@]}"; do
  if [[ "$range" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    start="${BASH_REMATCH[1]}"
    end="${BASH_REMATCH[2]}"
    for i in $(seq "$start" "$end"); do
      file="${files[i-1]}"
      rm -v "$source_dir/$file"
    done
  elif [[ "$range" =~ ^[0-9]+$ ]]; then
    file="${files[range-1]}"
    rm -v "$source_dir/$file"
  else
    echo "Invalid input: $range"
    exit 1
  fi
done

echo "Files removed successfully."
