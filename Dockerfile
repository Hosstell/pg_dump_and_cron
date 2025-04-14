# Используем официальный образ PostgreSQL как базовый
FROM postgres:latest

# Устанавливаем cron
RUN apt-get update && apt-get install -y cron

# Копируем скрипт для резервного копирования
COPY backup.sh /usr/local/bin/backup.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/backup.sh

# Копируем скрипт для генерации cron файла
COPY generate_crontab.sh /usr/local/bin/generate_crontab.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/generate_crontab.sh

# Устанавливаем права для cron файла
RUN touch /var/log/cron.log

# Запускаем скрипт для генерации cron файла и cron в фоновом режиме
CMD /usr/local/bin/generate_crontab.sh && cron && tail -f /var/log/cron.log

