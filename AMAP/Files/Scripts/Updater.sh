#!/bin/bash
DIR="$(cd "$(dirname "$0")/../../" && pwd)"
source "$DIR/config.sh"

# Specify the URL to the file containing the version number
version_url="https://raw.githubusercontent.com/Alienatedmamal/Updater/main/Update/version.txt"

# Download the version number from the web link
desired_version=$(curl -s "$version_url")

# Specify the path to the file containing the version number
version_file="$DIR/Files/version.txt"

# Check if the file exists
if [ -e "$version_file" ]; then
    # Read the version number from the file
    current_version=$(cat "$version_file")

    # Compare the current version with the desired version
    if [ "$current_version" = "$desired_version" ]; then
        echo "Version is already up to date. Stopping further actions."
        sleep 3
        exit 0  # Exit with success status
    else
        echo "Getting Updates Ready"
        sleep 2
        echo "Clear old updates...."
        updater_directory="$DIR/Updater/"

        # Check if the directory exists
        if [ -d "$updater_directory" ]; then
            # Directory exists, remove it
            rm -fr "$updater_directory"
            echo "Updater directory deleted."
        else
            echo "Updater directory does not exist."
        fi
        sleep 2
        echo "Downloading latest Updates....."
        sleep 2
        git clone https://github.com/Alienatedmamal/Updater.git
        echo "Download Completed" || echo "Failed to Download"
        sleep 2
        echo "File move completed.." || echo "Failed to move files"
        sleep 2
        chmod +x "$DIR/Updater/Update/update.sh"
        echo "Updater is now ready to start...." || echo "Updater Failed to execute...."
        sleep 2
        echo "Starting Updater...."
        "$DIR/Updater/Update/./update.sh"
        echo "Updates completed" || echo "Updates Failed"
        sleep 2
        echo "Removing Updater"
        sleep 1
        # Check if the directory exists
        if [ -d "$updater_directory" ]; then
            # Directory exists, remove it
            rm -fr "$updater_directory"
            echo "Updater directory deleted."
            sleep 1
        else
            echo "Updater directory does not exist."
        fi
    fi
else
    echo "Getting Updates Ready"
    sleep 2
    echo "Clear old updates...."
    updater_directory="$DIR/Updater/"

    # Check if the directory exists
    if [ -d "$updater_directory" ]; then
        # Directory exists, remove it
        rm -fr "$updater_directory"
        echo "Updater directory deleted."
    else
        echo "Updater directory does not exist."
    fi
    sleep 2
    echo "Downloading latest Updates....."
    sleep 2
    git clone https://github.com/Alienatedmamal/Updater.git
    echo "Download Completed" || echo "Failed to Download"
    sleep 2
    echo "File move completed.." || echo "Failed to move files"
    sleep 2
    chmod +x "$DIR/Updater/Update/update.sh"
    echo "Updater is now ready to start...." || echo "Updater Failed to execute...."
    sleep 2
    echo "Starting Updater...."
    "$DIR/Updater/Update/./update.sh"
    echo "Updates completed" || echo "Updates Failed"
        sleep 2
        echo "Removing Updater"
        sleep 1
        # Check if the directory exists
        if [ -d "$updater_directory" ]; then
            # Directory exists, remove it
            rm -fr "$updater_directory"
            echo "Updater directory deleted."
            sleep 1
        else
            echo "Updater directory does not exist."
        fi
    fi
