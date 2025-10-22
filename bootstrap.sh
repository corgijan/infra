#!/bin/bash

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if Ansible is available
if ! command_exists ansible; then
    echo "Ansible is not installed."
    if ! command_exists git; then
        echo "git is not installed."
    fi
    exit 1
fi


# Clone .config repository
#echo "Cloning .config repository..."
#git clone <url_of_config_repo.git> ~/.config

# Clone infrastructure repository
echo "Cloning infrastructure repository..."
git clone https://github.com/Iamjava/infra.git infra

# Change directory to infra
cd infra/ansible || exit

# Run the run.sh script
echo "Running run.sh script..."
bash run.sh
