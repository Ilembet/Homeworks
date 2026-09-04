#!/bin/bash
# Проверка порта 80 (nginx)
nc -z localhost 80 || exit 1
# Проверка существования файла index.html
[ -f /var/www/html/index.html ] || exit 1
exit 0
