#!/bin/bash
set -euo pipefail

# Logging
LOG_FILE="/home/maine/borg-backup.log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Backup started at $(date)"

# Run borgmatic for comprehensive backup management
borgmatic

# Prune old backups
borgmatic prune

curl https://hc-ping.com/896ab3e7-6bb2-451f-81c6-b5d1278e7f5d
s3cmd put "$backup_location/backup-images.tar.gz" s3://db-backups/ --access_key=poppy --secret_key=PoppyRoot012 --host=s3.corgijan.dev --host-bucket="s3.corgijan.dev/db-backups-30d" --host=s3.corgijan.dev
echo "Backup completed at $(date)"
