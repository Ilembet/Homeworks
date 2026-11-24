# 🎓 DevOps Homeworks — Илембетов Василь Ражапович

[English version](README.en.md)

> Домашние задания по курсу **Нетология** — *DevOps-инженер с нуля: расширенный курс*

Практическая отработка навыков, полученных в ходе обучения. Каждая папка — отдельное задание с решением, конфигурациями и скриншотами. У каждого задания есть README на русском и английском.

---

## 📂 Задания

### Мониторинг

| # | Задание | Описание |
|---|---|---|
| 1 | [Zabbix. Часть 1](./zabbix1) | Установка Zabbix Server (PostgreSQL, Apache), подключение агентов на Linux и Windows |
| 2 | [Zabbix. Часть 2](./zabbix2) | Свои шаблоны и дашборд, UserParameter на Bash и Python, Vagrant-скрипт для агентов |
| 3 | [Prometheus + Node Exporter + Grafana](./Prometheus%20Node%20Exporter%20Grafana) | Развёртывание стека мониторинга Prometheus, Node Exporter и Grafana |
| 4 | [Prometheus. Часть 2](./Prometheus%202) | Правила оповещения, Alertmanager, экспорт метрик Docker |

### Отказоустойчивость

| # | Задание | Описание |
|---|---|---|
| 5 | [Disaster Recovery. FHRP и Keepalived](./Disaster%20Recovery.%20FHRP%20%D0%B8%20Keepalived) | HSRP в Cisco Packet Tracer, плавающий IP на Keepalived с Bash-проверкой |
| 6 | [HAProxy + Nginx](./HAProxy%20%2B%20Nginx) | Балансировка Round-Robin на L4 и Weighted Round-Robin на L7, связка HAProxy и Nginx |
| 7 | [Резервное копирование](./Backup) | Бэкап через rsync, расписание cron, инкрементные копии и восстановление |
| 8 | [Отказоустойчивость в облаке](./Cloud%20server%20fault%20tolerance) | Yandex Cloud через Terraform: две ВМ, Target Group, Network Load Balancer |

### Кеширование, логи и очереди

| # | Задание | Описание |
|---|---|---|
| 9 | [Redis & Memcached](./Redis-memcached) | Кеширование, TTL в Memcached, запись данных и работа с числами в Redis |
| 10 | [ELK](./ELK) | Elasticsearch, Kibana, Logstash и Filebeat в Docker Compose, сбор логов Nginx |
| 11 | [RabbitMQ](./RabbitMQ) | Очереди сообщений, кластер из двух нод, политика ha-all, отказ ноды |

### Базы данных

| # | Задание | Описание |
|---|---|---|
| 12 | [Базы данных](./Databases) | Проектирование модели данных по отчёту заказчика: 9 таблиц, схема, SQL-скрипт для PostgreSQL |
| 13 | [Работа с данными (DDL/DML)](./DDL_DML) | MySQL 8: пользователи и права, восстановление дампа sakila, первичные ключи, частичный отзыв прав |
| 14 | [SQL. Часть 1](./SQL.%20Part%201) | Выборки с LIKE, диапазоны дат, сортировка и LIMIT, строковые функции |
| 15 | [SQL. Часть 2](./SQL.%20Part%202) | JOIN, подзапросы, группировка и HAVING, CASE, NOT EXISTS |
| 16 | [Индексы](./Indexes) | Размер индексов, EXPLAIN ANALYZE и оптимизация запроса (3.34 с → 3 мс), типы индексов PostgreSQL |
| 17 | [Репликация и масштабирование. Часть 1](./Replication%20and%20Scaling.%20Part%201) | Репликация MySQL master-slave и master-master на двух ВМ |
| 18 | [Репликация и масштабирование. Часть 2](./Replication%20and%20Scaling.%20Part%202) | Преимущества master-slave схем, план вертикального и горизонтального шардинга, шардинг PostgreSQL в Docker (postgres_fdw) |

### Информационная безопасность

| # | Задание | Описание |
|---|---|---|
| 19 | [Уязвимости и атаки на информационные системы](./Vulnerabilities%20and%20Attacks) | Сканирование Metasploitable через nmap, поиск уязвимостей на exploit-db, SYN/FIN/Xmas/UDP-сканирование в Wireshark |

---

## 🛠 Используемые технологии

- **Мониторинг и алертинг:** Zabbix, Prometheus, Alertmanager, Node Exporter, Grafana
- **Отказоустойчивость и балансировка:** HSRP, Keepalived, HAProxy, Nginx
- **Резервное копирование:** rsync, cron
- **IaC и облако:** Terraform, Yandex Cloud (VPC, Network Load Balancer, Target Group), cloud-init
- **Логирование:** Elasticsearch, Logstash, Kibana, Filebeat (ELK)
- **Кеширование и очереди:** Redis, Memcached, RabbitMQ
- **Информационная безопасность:** nmap, Wireshark, exploit-db, Metasploitable
- **Базы данных:** MySQL 8, PostgreSQL, SQL, индексы и оптимизация запросов, репликация, шардинг
- **Инструменты:** Linux (Ubuntu), Bash, Python, Docker, Docker Compose, Vagrant, VirtualBox, Git

---

## 🏫 Информация о курсе

| Поле | Значение |
|------|----------|
| **Учебное заведение** | Нетология |
| **Курс** | DevOps-инженер с нуля: расширенный курс |
| **Студент** | Илембетов Василь Ражапович |

---

> 💡 *Репозиторий пополняется по мере прохождения курса.*
