# 🎓 DevOps Homeworks — Ilembetov Vasil Razhapovich

[Русская версия](README.md)

> Home assignments for the **Netology** course — *DevOps Engineer from Scratch: Advanced Course*

Hands-on practice of the skills learned during the course. Each folder is a separate assignment with a solution, configurations and screenshots. Every assignment has a README in both Russian and English.

---

## 📂 Assignments

### Monitoring

| # | Assignment | Description |
|---|---|---|
| 1 | [Zabbix. Part 1](./zabbix1) | Zabbix Server installation (PostgreSQL, Apache), connecting agents on Linux and Windows |
| 2 | [Zabbix. Part 2](./zabbix2) | Custom templates and dashboard, UserParameter in Bash and Python, Vagrant script for agents |
| 3 | [Prometheus + Node Exporter + Grafana](./Prometheus%20Node%20Exporter%20Grafana) | Deploying the Prometheus, Node Exporter and Grafana monitoring stack |
| 4 | [Prometheus. Part 2](./Prometheus%202) | Alerting rules, Alertmanager, Docker metrics export |

### Fault tolerance

| # | Assignment | Description |
|---|---|---|
| 5 | [Disaster Recovery. FHRP and Keepalived](./Disaster%20Recovery.%20FHRP%20%D0%B8%20Keepalived) | HSRP in Cisco Packet Tracer, floating IP with Keepalived and a Bash health check |
| 6 | [HAProxy + Nginx](./HAProxy%20%2B%20Nginx) | Round-Robin balancing on L4 and Weighted Round-Robin on L7, HAProxy with Nginx |
| 7 | [Backup](./Backup) | Backups with rsync, cron schedule, incremental copies and restore |
| 8 | [Cloud server fault tolerance](./Cloud%20server%20fault%20tolerance) | Yandex Cloud with Terraform: two VMs, Target Group, Network Load Balancer |

### Caching, logging and queues

| # | Assignment | Description |
|---|---|---|
| 9 | [Redis & Memcached](./Redis-memcached) | Caching, TTL in Memcached, writing data and working with numbers in Redis |
| 10 | [ELK](./ELK) | Elasticsearch, Kibana, Logstash and Filebeat in Docker Compose, collecting Nginx logs |
| 11 | [RabbitMQ](./RabbitMQ) | Message queues, two-node cluster, ha-all policy, node failure |

### Databases

| # | Assignment | Description |
|---|---|---|
| 12 | [Databases](./Databases) | Designing a data model from a customer report: 9 tables, schema, SQL script for PostgreSQL |
| 13 | [Working with data (DDL/DML)](./DDL_DML) | MySQL 8: users and privileges, restoring the sakila dump, primary keys, partial revokes |
| 14 | [SQL. Part 1](./SQL.%20Part%201) | Queries with LIKE, date ranges, sorting and LIMIT, string functions |
| 15 | [SQL. Part 2](./SQL.%20Part%202) | JOIN, subqueries, grouping and HAVING, CASE, NOT EXISTS |
| 16 | [Indexes](./Indexes) | Index size, EXPLAIN ANALYZE and query optimization (3.34 s → 3 ms), PostgreSQL index types |
| 17 | [Replication and Scaling. Part 1](./Replication%20and%20Scaling.%20Part%201) | MySQL master-slave and master-master replication on two VMs |
| 18 | [Replication and Scaling. Part 2](./Replication%20and%20Scaling.%20Part%202) | Benefits of master-slave setups, vertical and horizontal sharding plan, PostgreSQL sharding in Docker (postgres_fdw) |

---

## 🛠 Technologies Used

- **Monitoring and alerting:** Zabbix, Prometheus, Alertmanager, Node Exporter, Grafana
- **Fault tolerance and load balancing:** HSRP, Keepalived, HAProxy, Nginx
- **Backup:** rsync, cron
- **IaC and cloud:** Terraform, Yandex Cloud (VPC, Network Load Balancer, Target Group), cloud-init
- **Logging:** Elasticsearch, Logstash, Kibana, Filebeat (ELK)
- **Caching and queues:** Redis, Memcached, RabbitMQ
- **Databases:** MySQL 8, PostgreSQL, SQL, indexes and query optimization, replication, sharding
- **Tools:** Linux (Ubuntu), Bash, Python, Docker, Docker Compose, Vagrant, VirtualBox, Git

---

## 🏫 Course Information

| Field | Value |
|-------|-------|
| **Institution** | Netology |
| **Course** | DevOps Engineer from Scratch: Advanced Course |
| **Student** | Ilembetov Vasil Razhapovich |

---

> 💡 *The repository grows as the course progresses.*
