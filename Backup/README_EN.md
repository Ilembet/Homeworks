# Homework: Backup with rsync   Ilembetov Vasil Razhapovich

## 🇬🇧 Description

This homework assignment is about setting up backup of the user's home directory using the `rsync` utility and `cron` scheduler.

### Project Structure

```
Backup/
├── img/          # Images (screenshots for the report)
├── scripts/      # Scripts for completing the assignments
└── README_EN.md  # This file
```

---

## Task 1: rsync Command for Mirror Backup

Create an `rsync` command that generates a mirror copy of the user's home directory to `/tmp/backup`.

**Requirements:**
- Exclude all directories starting with a dot (hidden files)
- Force hash computation for all files, even if modification time and size match

**Solution:**

```bash
rsync -a --delete --exclude='.*' --checksum ~ /tmp/backup
```

**Parameter breakdown:**

| Parameter | Description |
|-----------|-------------|
| `-a` | Archive mode (preserves permissions, modification times, symlinks, etc.) |
| `--delete` | Deletes files in the destination that are not in the source (mirror copy) |
| `--exclude='.*'` | Excludes all files and directories starting with a dot |
| `--checksum` | Uses checksum verification instead of modification time and size |
| `~` | Source directory (home directory) |
| `/tmp/backup` | Destination directory |

**Execution result:**

![Task 1](img/1.png)

---

## Task 2: Regular Backup via cron

Write a script and configure a task for regular backup of the user's home directory using `rsync` and `cron`.

**Requirements:**
- The backup must be a complete mirror copy
- The backup must run once a day
- A log entry must appear in the system log for success or failure
- The backup is stored locally in `/tmp/backup`

### Script: `scripts/backup.sh`

```bash
#!/bin/bash

BACKUP_DIR="/tmp/backup"
SOURCE_DIR="$HOME"
LOG_FILE="/var/log/backup.log"

rsync -a --delete --exclude='.*' --checksum "$SOURCE_DIR" "$BACKUP_DIR" 2>&1 | tee -a "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "$(date): Backup completed successfully" >> "$LOG_FILE"
else
    echo "$(date): Backup failed" >> "$LOG_FILE"
fi
```

### Cron Configuration

Open the crontab editor:

```bash
crontab -e
```

Add a line for daily execution (e.g., at 2:00 AM):

```
0 2 * * * /path/to/scripts/backup.sh
```

**Crontab contents:**

```
0 2 * * * /home/vboxuser/scripts/backup.sh >> /var/log/backup.log 2>&1
```

**Execution result:**

![Task 2](img/2.png)

---

## Task 3: Incremental Backup and Backup Management

Write a script for local incremental backup of the user's home directory using `rsync` with old backup management.

**Requirements:**
- Local incremental backup of the user's home directory using `rsync`
- Delete old backups (keep only the last 5)
- Management script: select a backup and restore data

### How It Works

Incremental backup is implemented using the `--link-dest` option, which creates hard links to unchanged files from the previous backup. This saves disk space, since only files that have changed since the last backup are copied.

```
backup_20240101_120000/   ← full backup
backup_20240102_120000/   ← only changed files, rest are hard links to the first backup
backup_20240103_120000/   ← only changed files, rest are hard links to the second backup
```

### Backup Script: `scripts/backup_incremental.sh`

```bash
#!/bin/bash

BACKUP_BASE="/tmp/backup_incremental"
SOURCE_DIR="$HOME"
MAX_BACKUPS=5

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_BASE"

# Current timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}"
BACKUP_PATH="${BACKUP_BASE}/${BACKUP_NAME}"

# Find the latest backup for --link-dest
LATEST_BACKUP=$(ls -1d ${BACKUP_BASE}/backup_* 2>/dev/null | sort | tail -n 1)

# Step 1: Incremental copy using rsync
if [ -n "$LATEST_BACKUP" ] && [ -d "$LATEST_BACKUP" ]; then
    echo "Creating incremental backup based on: ${LATEST_BACKUP}"
    rsync -a --delete --exclude='.*' --link-dest="$LATEST_BACKUP" "$SOURCE_DIR/" "$BACKUP_PATH/" 2>&1
else
    echo "Creating full backup (first backup)"
    rsync -a --delete --exclude='.*' "$SOURCE_DIR/" "$BACKUP_PATH/" 2>&1
fi

if [ $? -eq 0 ]; then
    echo "$(date): Backup ${BACKUP_NAME} completed successfully."
else
    echo "$(date): Backup ${BACKUP_NAME} failed!"
    exit 1
fi

# Step 2: Delete old backups (keep only the last MAX_BACKUPS)
BACKUP_COUNT=$(ls -1d ${BACKUP_BASE}/backup_* 2>/dev/null | wc -l)

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    REMOVE_COUNT=$((BACKUP_COUNT - MAX_BACKUPS))
    echo "Deleting ${REMOVE_COUNT} old backups..."
    ls -1d ${BACKUP_BASE}/backup_* | sort | head -n "$REMOVE_COUNT" | while read OLD_BACKUP; do
        echo "  Deleting: ${OLD_BACKUP}"
        rm -rf "$OLD_BACKUP"
    done
fi

echo "Backup ${BACKUP_NAME} completed successfully."
```

### Management Script: `scripts/restore_backup.sh`

```bash
#!/bin/bash

BACKUP_BASE="/tmp/backup_incremental"

# List available backups
list_backups() {
    echo "Available backups:"
    echo "--------------------------"
    ls -1td ${BACKUP_BASE}/backup_* 2>/dev/null | nl
}

# Restore from selected backup
restore_backup() {
    local BACKUP_NAME=$1
    local RESTORE_TARGET=${2:-$HOME}

    local BACKUP_PATH="${BACKUP_BASE}/${BACKUP_NAME}"

    if [ ! -d "$BACKUP_PATH" ]; then
        echo "Error: backup '${BACKUP_NAME}' not found!"
        exit 1
    fi

    echo "Restoring from backup: ${BACKUP_NAME}"
    echo "Target directory: ${RESTORE_TARGET}"
    echo ""

    read -p "Are you sure? Current data may be overwritten. (y/N): " CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "Cancelled."
        exit 0
    fi

    rsync -av --delete "$BACKUP_PATH/" "$RESTORE_TARGET/" 2>&1

    if [ $? -eq 0 ]; then
        echo ""
        echo "Successfully restored from: ${BACKUP_NAME}"
    else
        echo ""
        echo "Restore failed!"
        exit 1
    fi
}

# Main menu
case "$1" in
    list)
        list_backups
        ;;
    restore)
        if [ -z "$2" ]; then
            echo "Usage: $0 restore <backup_number> [restore_path]"
            echo ""
            echo "First run: $0 list"
            echo "to see the list of available backups."
            exit 1
        fi
        list_backups
        echo ""
        BACKUP=$(ls -1td ${BACKUP_BASE}/backup_* 2>/dev/null | sed -n "${2}p")
        if [ -n "$BACKUP" ]; then
            BACKUP_NAME=$(basename "$BACKUP")
            restore_backup "$BACKUP_NAME" "${3:-$HOME}"
        else
            echo "Error: backup #${2} not found."
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {list|restore <number> [path]}"
        echo ""
        echo "  list              - show list of backups"
        echo "  restore N         - restore backup #N to home directory"
        echo "  restore N /path   - restore backup #N to specified directory"
        ;;
esac
```

### Usage

```bash
# Run incremental backup
./scripts/backup_incremental.sh

# List available backups
./scripts/restore_backup.sh list

# Restore backup #1 to home directory
./scripts/restore_backup.sh restore 1

# Restore backup #2 to a specific directory
./scripts/restore_backup.sh restore 2 /tmp/restore_test
```

**Script execution results:**

![Task 3 — running backup and listing](img/3_1.png)

![Task 3 — restoring from backup](img/3_2.png)

---

## License

This is a university homework assignment.
