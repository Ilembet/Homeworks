# Домашнее задание к занятию «Система мониторинга Zabbix. Часть 1» — Илембетов Василь Ражапович

[English version](README_EN.md)

---

## Задание 1. Установка Zabbix Server

Платформа: Zabbix 7.0, Ubuntu 24.04, Server, Frontend, Agent, PostgreSQL, Apache.

```bash
sudo -s

# Репозиторий Zabbix
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
apt update

# Zabbix Server, веб-интерфейс и агент
apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# База данных
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

В файле `/etc/zabbix/zabbix_server.conf` указан пароль базы данных:

```
DBPassword=password
```

Запуск и автозагрузка сервисов:

```bash
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```

Веб-интерфейс доступен по адресу `http://<IP сервера>/zabbix`.

![Авторизация в веб-интерфейсе](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D0%B0%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8%20%D0%B2%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%BA%D0%B5.png)

---

## Задание 2. Zabbix Agent на Linux

Агент установлен на второй сервер:

```bash
sudo -s
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
apt update
apt install zabbix-agent
```

В `/etc/zabbix/zabbix_agentd.conf` указаны адрес Zabbix Server (`Server`, `ServerActive`) и имя хоста. Затем агент перезапущен и добавлен в автозагрузку:

```bash
systemctl restart zabbix-agent
systemctl enable zabbix-agent
tail -n 20 /var/log/zabbix/zabbix_agentd.log
```

В веб-интерфейсе: **Data collection → Hosts → Create host**, хост `Ubuntu-Client`, шаблон *Linux by Zabbix agent active*. Поступление метрик проверено в **Monitoring → Latest data**.

Хост в разделе Hosts:

![Configuration → Hosts](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%B0%20Configuration%20%20Hosts.png)

Лог Zabbix Agent:

![Лог zabbix agent](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D0%BB%D0%BE%D0%B3%D0%B0%20zabbix%20agent.png)

Данные в Monitoring → Latest data:

![Monitoring → Latest data](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%B0%20Monitoring%20%20Latest%20data.png)

---

## Задание 3*. Zabbix Agent на Windows

С официального сайта скачан установщик Zabbix Agent для Windows, при установке указаны данные Zabbix Server. В файле `C:\Program Files\Zabbix Agent\zabbix_agentd.conf` агент переведён в активный режим, служба Zabbix Agent перезапущена.

В веб-интерфейсе создан хост `Windows_home` с шаблоном *Windows by Zabbix agent active*, поступление метрик проверено в **Monitoring → Latest data**.

![Хост Windows](img/Hosts%20Windows.png)

![Latest data Windows](img/Latest%20data%20Windows.png)

![Диск C](img/Win%20disc%20C.png)
