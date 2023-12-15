#!/bin/bash
DIR="$(cd "$(dirname "$0")/../" && pwd)"
source $DIR/config.sh

packages=(
    bc
    binutils
    bsdmainutils
    bzip2
    ca-certificates
    cpio
    curl
    distro-info
    file
    gzip
    hostname
    jq
    lib32gcc-s1
    lib32stdc++6
    lib32z1
    libsdl2-2.0-0:i386
    netcat
    python3
    steamcmd
    tar
    tmux
    unzip
    util-linux
    uuid-runtime
    wget
    xz-utils
)

total_packages=${#packages[@]}
current_package=0

for package in "${packages[@]}"; do
    current_package=$((current_package + 1))
    percentage=$((current_package * 100 / total_packages))

    if ! dpkg -l | grep -q "^ii  $package"; then
        echo "Installing $package [$current_package/$total_packages] - $percentage%"
        sudo apt-get install -y "$package"
    else
        echo "$package is already installed. Skipping [$current_package/$total_packages] - $percentage%"
    fi
done

echo "Installation complete."
