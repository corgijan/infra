Hier bitte einmal diesen tun

# Create the directory if it doesn't exist
mkdir -p ./n8n_data ./local-files

# Set proper permissions (node user is typically UID 1000)
sudo chown 1000:1000 ./n8n_data ./local-files
sudo chmod 755 ./n8n_data ./local-files
