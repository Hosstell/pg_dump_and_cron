#!/bin/bash

# Переменные окружения для подключения к базе данных
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-postgres}
DB_PASSWORD=${DB_PASSWORD:-password}
DB_NAME=${DB_NAME:-mydatabase}
BACKUP_DIR=${BACKUP_DIR:-/backups}

# Создаем директорию для резервных копий, если она не существует
mkdir -p $BACKUP_DIR

# Формируем имя файла резервной копии
TIMESTAMP=$(date +"%F-%H-%M")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

# Выполняем резервное копирование
PGPASSWORD=$DB_PASSWORD pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c -b -v -f $BACKUP_FILE $DB_NAME

# Логируем результат
echo "Backup completed: $BACKUP_FILE" >> /var/log/cron.log
