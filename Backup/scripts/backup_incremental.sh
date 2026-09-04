#!/bin/bash

BACKUP_BASE="/tmp/backup_incremental"
SOURCE_DIR="$HOME"
MAX_BACKUPS=5

# Создание директории для бэкапов, если не существует
mkdir -p "$BACKUP_BASE"

# Текущая метка времени
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}"
BACKUP_PATH="${BACKUP_BASE}/${BACKUP_NAME}"

# Находим предыдущий бэкап для --link-dest
LATEST_BACKUP=$(ls -1d ${BACKUP_BASE}/backup_* 2>/dev/null | sort | tail -n 1)

# Шаг 1: Инкрементное копирование с помощью rsync
if [ -n "$LATEST_BACKUP" ] && [ -d "$LATEST_BACKUP" ]; then
    echo "Создание инкрементной копии на основе: ${LATEST_BACKUP}"
    rsync -a --delete --exclude='.*' --link-dest="$LATEST_BACKUP" "$SOURCE_DIR/" "$BACKUP_PATH/" 2>&1
else
    echo "Создание полной копии (первый бэкап)"
    rsync -a --delete --exclude='.*' "$SOURCE_DIR/" "$BACKUP_PATH/" 2>&1
fi

if [ $? -eq 0 ]; then
    echo "$(date): Backup ${BACKUP_NAME} completed successfully."
else
    echo "$(date): Backup ${BACKUP_NAME} failed!"
    exit 1
fi

# Шаг 2: Удаление старых бэкапов (оставляем только последние MAX_BACKUPS)
BACKUP_COUNT=$(ls -1d ${BACKUP_BASE}/backup_* 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    REMOVE_COUNT=$((BACKUP_COUNT - MAX_BACKUPS))
    echo "Удаление ${REMOVE_COUNT} старых бэкапов..."
    ls -1d ${BACKUP_BASE}/backup_* | sort | head -n "$REMOVE_COUNT" | while read OLD_BACKUP; do
        echo "  Удаляется: ${OLD_BACKUP}"
        rm -rf "$OLD_BACKUP"
    done
fi

echo "Бэкап ${BACKUP_NAME} завершён успешно."
