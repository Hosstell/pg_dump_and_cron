#!/bin/bash

# Проверяем, установлена ли переменная CRON_SCHEDULE
if [ -z "$CRON_SCHEDULE" ]; then
  echo "Error: CRON_SCHEDULE is not set. Please provide a cron schedule."
  exit 1
fi

# Генерируем cron файл
echo "$CRON_SCHEDULE root /usr/local/bin/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron

# Устанавливаем права для cron файла
chmod 0644 /etc/cron.d/backup-cron

