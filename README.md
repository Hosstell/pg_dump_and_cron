# PostgreSQL Backup Docker Image

Этот Docker образ предназначен для выполнения резервного копирования базы данных PostgreSQL с использованием `pg_dump` и запуска этой операции по расписанию с помощью cron.

## Содержание

- [Особенности](#особенности)
- [Требования](#требования)
- [Установка и запуск](#установка-и-запуск)
- [Переменные окружения](#переменные-окружения)
- [Пример использования](#пример-использования)
- [Логи](#логи)

## Особенности

- Автоматическое резервное копирование базы данных PostgreSQL.
- Гибкое расписание выполнения резервного копирования с помощью cron.
- Хранение резервных копий в указанной директории.

## Требования

- Docker
- Docker Compose

## Установка и запуск

1. Клонируйте репозиторий:

    ```bash
    git clone <URL вашего репозитория>
    cd <имя вашего репозитория>
    ```

2. Соберите Docker образ:

    ```bash
    docker-compose build
    ```

3. Запустите контейнеры:

    ```bash
    docker-compose up -d
    ```

## Переменные окружения

Для настройки образа используйте следующие переменные окружения:

- `DB_HOST`: Хост базы данных PostgreSQL (по умолчанию: `localhost`).
- `DB_PORT`: Порт базы данных PostgreSQL (по умолчанию: `5432`).
- `DB_USER`: Пользователь базы данных PostgreSQL (по умолчанию: `postgres`).
- `DB_PASSWORD`: Пароль пользователя базы данных PostgreSQL (по умолчанию: `password`).
- `DB_NAME`: Имя базы данных PostgreSQL (по умолчанию: `mydatabase`).
- `BACKUP_DIR`: Директория для хранения резервных копий (по умолчанию: `/backups`).
- `CRON_SCHEDULE`: Расписание cron для выполнения резервного копирования (обязательная переменная).

## Пример использования

Пример файла `docker-compose.yml`:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres\:latest
    environment:
      POSTGRES_DB: mydatabase
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  backup:
    build: .
    environment:
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: postgres
      DB_PASSWORD: password
      DB_NAME: mydatabase
      BACKUP_DIR: /backups
      CRON_SCHEDULE: "0 2 * * *"  # Расписание cron
    volumes:
      - backup_data:/backups
    depends_on:
      - postgres

volumes:
  postgres_data:
  backup_data:

