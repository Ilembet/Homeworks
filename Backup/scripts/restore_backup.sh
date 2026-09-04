#!/bin/bash

BACKUP_BASE="/tmp/backup_incremental"

# Список доступных бэкапов
list_backups() {
    echo "Доступные резервные копии:"
    echo "--------------------------"
    ls -1td ${BACKUP_BASE}/backup_* 2>/dev/null | nl
}

# Восстановление из выбранной копии
restore_backup() {
    local BACKUP_NAME=$1
    local RESTORE_TARGET=${2:-$HOME}

    local BACKUP_PATH="${BACKUP_BASE}/${BACKUP_NAME}"

    if [ ! -d "$BACKUP_PATH" ]; then
        echo "Ошибка: резервная копия '${BACKUP_NAME}' не найдена!"
        exit 1
    fi

    echo "Восстановление из копии: ${BACKUP_NAME}"
    echo "Целевая директория: ${RESTORE_TARGET}"
    echo ""

    read -p "Вы уверены? Текущие данные могут быть перезаписаны. (y/N): " CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        echo "Отменено."
        exit 0
    fi

    rsync -av --delete "$BACKUP_PATH/" "$RESTORE_TARGET/" 2>&1

    if [ $? -eq 0 ]; then
        echo ""
        echo "Успешно восстановлено из: ${BACKUP_NAME}"
    else
        echo ""
        echo "Ошибка восстановления!"
        exit 1
    fi
}

# Главное меню
case "$1" in
    list)
        list_backups
        ;;
    restore)
        if [ -z "$2" ]; then
            echo "Использование: $0 restore <номер_копии> [путь_восстановления]"
            echo ""
            echo "Сначала выполните: $0 list"
            echo "чтобы увидеть список доступных копий."
            exit 1
        fi
        list_backups
        echo ""
        BACKUP=$(ls -1td ${BACKUP_BASE}/backup_* 2>/dev/null | sed -n "${2}p")
        if [ -n "$BACKUP" ]; then
            BACKUP_NAME=$(basename "$BACKUP")
            restore_backup "$BACKUP_NAME" "${3:-$HOME}"
        else
            echo "Ошибка: копия с номером $2 не найдена."
            exit 1
        fi
        ;;
    *)
        echo "Использование: $0 {list|restore <номер> [путь]}"
        echo ""
        echo "  list              - показать список резервных копий"
        echo "  restore N         - восстановить копию №N в домашнюю директорию"
        echo "  restore N /путь   - восстановить копию №N в указанную директорию"
        ;;
esac
