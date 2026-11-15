# Homework: Zabbix Monitoring System. Part 1 — Ilembetov Vasil Razhapovich

[Русская версия](README.md)

---

## Task 1. Installing Zabbix Server

Platform: Zabbix 7.0, Ubuntu 24.04, Server, Frontend, Agent, PostgreSQL, Apache.

```bash
sudo -s

# Zabbix repository
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
apt update

# Zabbix Server, frontend and agent
apt install zabbix-server-pgsql zabbix-frontend-php php8.3-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

# Database
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

The database password is set in `/etc/zabbix/zabbix_server.conf`:

```
DBPassword=password
```

Starting the services and enabling them at boot:

```bash
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```

The web interface is available at `http://<server IP>/zabbix`.

![Web interface login](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D0%B0%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8%20%D0%B2%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%BA%D0%B5.png)

---

## Task 2. Zabbix Agent on Linux

The agent is installed on a second server:

```bash
sudo -s
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.0+ubuntu24.04_all.deb
dpkg -i zabbix-release_latest_7.0+ubuntu24.04_all.deb
apt update
apt install zabbix-agent
```

`/etc/zabbix/zabbix_agentd.conf` specifies the Zabbix Server address (`Server`, `ServerActive`) and the host name. The agent is then restarted and enabled at boot:

```bash
systemctl restart zabbix-agent
systemctl enable zabbix-agent
tail -n 20 /var/log/zabbix/zabbix_agentd.log
```

In the web interface: **Data collection → Hosts → Create host**, host `Ubuntu-Client`, template *Linux by Zabbix agent active*. Incoming metrics were checked in **Monitoring → Latest data**.

The host in Hosts:

![Configuration → Hosts](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%B0%20Configuration%20%20Hosts.png)

Zabbix Agent log:

![zabbix agent log](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D0%BB%D0%BE%D0%B3%D0%B0%20zabbix%20agent.png)

Data in Monitoring → Latest data:

![Monitoring → Latest data](img/%D1%81%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%20%D1%80%D0%B0%D0%B7%D0%B4%D0%B5%D0%BB%D0%B0%20Monitoring%20%20Latest%20data.png)

---

## Task 3*. Zabbix Agent on Windows

The Zabbix Agent installer for Windows was downloaded from the official website, and the Zabbix Server details were entered during installation. In `C:\Program Files\Zabbix Agent\zabbix_agentd.conf` the agent was switched to active mode, and the Zabbix Agent service was restarted.

A host `Windows_home` with the *Windows by Zabbix agent active* template was created in the web interface, and incoming metrics were checked in **Monitoring → Latest data**.

![Windows host](img/Hosts%20Windows.png)

![Windows latest data](img/Latest%20data%20Windows.png)

![Drive C](img/Win%20disc%20C.png)
