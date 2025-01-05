#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if assetfinder is installed; if not, install it
if ! command_exists "assetfinder"; then
    echo "Installing assetfinder..."
    sudo apt install -y assetfinder
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install assetfinder."
        exit 1
    fi
fi

# Check if httprobe is installed; if not, install it
if ! command_exists "httprobe"; then
    echo "Installing httprobe..."
    sudo apt install -y httprobe
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install httprobe."
        exit 1
    fi
fi

echo -e "\e[34m ███████ ██    ██ ██████      ██████   ██████  ███    ███  █████  ██ ███    ██ 
██      ██    ██ ██   ██     ██   ██ ██    ██ ████  ████ ██   ██ ██ ████   ██ 
███████ ██    ██ ██████      ██   ██ ██    ██ ██ ████ ██ ███████ ██ ██ ██  ██ 
     ██ ██    ██ ██   ██     ██   ██ ██    ██ ██  ██  ██ ██   ██ ██ ██  ██ ██ 
███████  ██████  ██████      ██████   ██████  ██      ██ ██   ██ ██ ██   ████ 
                                                                            
                                                                                                          \e[0m"

read -p "Enter the domain: " hai

# Correctly pass the domain to assetfinder
assetfinder "$hai" > subs

# Process subdomains and check if they are live
cat subs | httprobe > live

# Remove duplicates and sort
sort -u live > sorted

# Display the sorted live subdomains
cat sorted
