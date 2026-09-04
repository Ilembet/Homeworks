#!/bin/bash

SOURCE="/home/$USER/"
DESTINATION="/tmp/backup"
LOG_TAG="rsync-backup"

mkdir -p "$DESTINATION"

rsync -a --delete --checksum \
    --exclude='.*' \
    "$SOURCE" "$DESTINATION"

if [ $? -eq 0 ]; then
    logger -t "$LOG_TAG" "Backup completed successfully"
else
    logger -t "$LOG_TAG" "Backup failed"
fi
