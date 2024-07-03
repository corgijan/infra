#!/bin/bash

# Set variables
RAW_URL="https://raw.githubusercontent.com/corgijan/infra/master/server/scripts/authorized_keys"  # Change to your raw file URL
AUTHORIZED_KEYS_PATH="$HOME/.ssh/authorized_keys"

# Ensure ~/.ssh directory exists
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
fi

# Download the authorized_keys file
echo "Downloading authorized keys..."
if curl -fSL "$RAW_URL" -o "$AUTHORIZED_KEYS_PATH"; then
    chmod 600 "$AUTHORIZED_KEYS_PATH"
    echo "Authorized keys have been updated."
else
    echo "Error: Failed to download authorized_keys file."
    exit 1
fi
