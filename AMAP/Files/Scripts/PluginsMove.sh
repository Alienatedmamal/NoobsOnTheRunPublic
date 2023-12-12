#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Define source and target directories
source_dir="$DIR/Files/plugins"
target_dir="/home/$USERNAME/serverfiles/oxide/plugins"

# Create target directory if it doesn't exist
mkdir -p "$target_dir"

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

total_files=${#files[@]}
current_file=1

for file in "${files[@]}"; do
  echo "Progress: [$((current_file * 100 / total_files))%]"

  cp "$source_dir/$file" "$target_dir/"

  ((current_file++))
done

echo "Files copied to $target_dir"
