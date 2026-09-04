# Домашнее задание к занятию "Prometheus. Часть 2" Илембетов Василь Ражапович

---

## Задание 1

### Настройка правила оповещения в Prometheus

**Описание:** Создать правило алертинга в Prometheus, которое будет срабатывать при определённых условиях, и убедиться, что правило правильно интерпретируется системой.


**Скриншот статуса Pending:**

![Статус Pending](img/1_status_Pending.png)

---

## Задание 2

### Установка Alertmanager и интеграция с Prometheus

**Описание:** Скачать и установить, настроить его конфигурацию с каналами оповещения и интегрировать с Prometheus для отправки алертов.


**Скриншот статуса Firing в Prometheus и активного правила в Alertmanager:**

![Статус Firing](img/2_status_firing.png)

![Alertmanager правила](img/2-1_alertmaanger_rules.png)

---

## Задание 3

### Активация экспортёра метрик в Docker и подключение к Prometheus

**Описание:** Запустить Docker контейнер, включить экспортёра метрик в Docker: создать и открыть конфигурационный файл демона, прописать endpoint. Добавить как target в Prometheus (в yaml файл) для сбора метрик.


**Скриншот открытого endpoint экспортёра:**

![Open endpoint](img/3_open_endpoint.png)

**Скриншот списка Targets в Prometheus:**

![Targets Prometheus](img/3-1_targets_prometheus.png)
