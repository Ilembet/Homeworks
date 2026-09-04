# Домашнее задание к занятию «Система мониторинга Prometheus» - Илембетов Василь Ражапович (Ilembetov Vasil Razhapovich)

---

## Задание 1. Установка Prometheus

**Описание:** Установлен Prometheus, создан пользователь prometheus и настроен системный сервис.

![Systemctl Prometheus](img/1_status_prometheus.png)

> На скриншоте выводится `systemctl status prometheus` со строкой `prometheus.service — Prometheus Service Netology Lesson 9.4 — Илембетов Василь Ражапович`.

---

## Задание 2. Установка Node Exporter

**Описание:** Установлен Node Exporter и настроен системный сервис.

![Systemctl Node Exporter](https://github.com/Ilembet/Homeworks/blob/9fcbd41bab4b4c10051e29d6cdd581258122c3cb/Prometheus%20Node%20Exporter%20Grafana/img/2_status_Node%20Exporter.png)

> На скриншоте выводится `systemctl status node-exporter` со строкой `node-exporter.service — Node Exporter Netology Lesson 9.4 — Илембетов Василь Ражапович`.

---

## Задание 3. Подключение Node Exporter к Prometheus

**Описание:** В файл `prometheus.yml` добавлен таргет `node-exporter`, сервис перезапущен.

![Prometheus Configuration](img/3_status_configuration.png)

![Prometheus Targets](img/3-1_status_targets.png)

> На скриншоте конфигурации отображается вкладка **Status > Configuration** с добавленным таргетом `node-exporter`.
> На скриншоте эндпоинтов отображается вкладка **Status > Targets** с минимум двумя эндпоинтами (prometheus и node-exporter).

---

## Задание 4. Установка Grafana*

**Описание:** Установлена Grafana.

![Grafana Profile](img/4_Grafana.png)

> На скриншоте отображается интерфейс Grafana (правый верхний угол при наведении на иконку пользователя с ФИО).

---

## Задание 5. Интеграция Grafana и Prometheus*

**Описание:** Prometheus подключен в качестве источника данных (Data Source) в Grafana.

![Grafana Prometheus Integration](https://github.com/Ilembet/Homeworks/blob/bd148d7e5ab16e1c167c8cd490f6ef2c028e5f90/Prometheus%20Node%20Exporter%20Grafana/img/5_Integration%20of%20Grafana%20and%20Prometheus.png)

> На скриншоте отображается интегрированный источник данных (Data Source) или дашборд Grafana с подключённым Prometheus.
