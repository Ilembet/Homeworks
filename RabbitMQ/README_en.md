# Homework Assignment: RabbitMQ Queues — Ilembetov Vasil

## Environment

Two virtual machines in VirtualBox running Ubuntu 24.04 with RabbitMQ 3.12. The machines are connected to the same VirtualBox "NAT Network", so they can see each other and have internet access.

| Host  | IP-Address | Role                              |
|-------|------------|-----------------------------------|
| rmq01 | 10.0.2.15  | primary node, creates the queue   |
| rmq02 | 10.0.2.4   | secondary node, clone of rmq01    |

Scripts for sending and receiving messages:

- [`scripts/producer.py`](scripts/producer.py) — script for sending messages
- [`scripts/consumer.py`](scripts/consumer.py) — script for receiving messages

Screenshots are located in the `img/` folder (format: `<number>_<name>.png`):

| Task | Screenshot | File |
|------|-----------|------|
| 1 | RabbitMQ Web Interface | `1_RabbitMQ.png` |
| 2 | Producer — hello queue | `2_producer.png` |
| 2 | Consumer — execution result | `2_consumer.png` |
| 3 | Cluster nodes (Overview → Nodes) | `3_Overview → Nodes.png` |
| 3 | ha-all policy (Admin → Policies) | `3_Admin → Policies.png` |
| 3 | `rabbitmqadmin get queue='hello'` | `3_message.png` |
| 3 | Consumer after node failure | `3_consumer.png` |

---

## Task 1. RabbitMQ Installation

Set the hostname. RabbitMQ names nodes by hostname (`rabbit@rmq01`), so the name must be changed before installation.

```bash
sudo hostnamectl set-hostname rmq01
```

Install RabbitMQ and enable the management plugin, which provides a web interface on port 15672:

```bash
sudo apt update
sudo apt install -y rabbitmq-server
sudo rabbitmq-plugins enable rabbitmq_management
```

The default `guest` user can only log in from localhost. To connect to the broker over the network, create an admin user:

```bash
sudo rabbitmqctl add_user admin admin
sudo rabbitmqctl set_user_tags admin administrator
sudo rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
```

The web interface is available at `http://localhost:15672`:

![RabbitMQ Web Interface](img/1_RabbitMQ.png)

---

## Task 2. Sending and Receiving Messages

Install the Pika library. On Ubuntu 24.04, `pip install` in system Python is blocked, so use the repository package:

```bash
sudo apt install -y python3-pika
```

In the scripts, replace `localhost` with the IP address of the RabbitMQ machine. Also added login as the `admin` user:

```python
HOST = "10.0.2.15"
credentials = pika.PlainCredentials("admin", "admin")
```

Send a message:

```bash
python3 producer.py
```

The script creates the `hello` queue and places the message `Hello Netology!` in it. In the web interface, you can see one message in the queue:

![Producer — hello queue](img/2_producer.png)

Read the message:

```bash
python3 consumer.py
```

The consumer retrieves the message from the queue and prints it. After that, the queue becomes empty:

![Consumer execution result](img/2_consumer.png)

---

## Task 3. HA Cluster

### Second Machine

The second VM was created by fully cloning rmq01 in VirtualBox with new MAC addresses. On the clone, a new machine-id was generated so the machines would not receive the same IP via DHCP, and the hostname was changed:

```bash
sudo rm /etc/machine-id
sudo systemd-machine-id-setup
sudo hostnamectl set-hostname rmq02
sudo reboot
```

### Hosts File

Added entries on both machines so nodes can resolve each other by hostname:

```bash
$ cat /etc/hosts
10.0.2.15 rmq01
10.0.2.4 rmq02
```

Verification: `ping rmq01` and `ping rmq02` work from both machines.

### Joining the Cluster

Cluster nodes trust each other if they have the same Erlang cookie (`/var/lib/rabbitmq/.erlang.cookie`). Since rmq02 is a clone, the cookie already matches.

On rmq02, restart RabbitMQ under the new name and join it to rmq01:

```bash
sudo systemctl restart rabbitmq-server
sudo rabbitmqctl stop_app
sudo rabbitmqctl reset
sudo rabbitmqctl join_cluster rabbit@rmq01
sudo rabbitmqctl start_app
```

`reset` is required because only a node without its own data can join a cluster.

### ha-all Policy

```bash
sudo rabbitmqctl set_policy ha-all ".*" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
```

The policy mirrors all queues (`".*"`) to all cluster nodes (`ha-mode: all`), and automatically synchronizes new replicas.

Cluster nodes in the web interface:

![Cluster nodes](img/3_Overview_Nodes.png)

Enabled ha-all policy:

![ha-all policy](img/3_Admin_Policies.png)


### Replication Verification

Sent a message to rmq01 via `producer.py` and read the queue on each node:

```bash
rabbitmqadmin -u admin -p admin get queue='hello'
```

The message is available on both nodes. By default, `get` returns the message back to the queue, so it is also visible on the second node.

![rabbitmqadmin get queue='hello'](img/3_message.png)

### Node Failure

Stopped RabbitMQ on rmq01, which the producer was connected to:

```bash
sudo systemctl stop rabbitmq-server
```

Changed the address in `consumer.py` to rmq02 (`10.0.2.4`) and ran the script:

![consumer.py on rmq02 after failover](img/3_consumer.png)

Message received. The node where the queue was created is unavailable, but the copy on rmq02 became the primary, and no data was lost.
