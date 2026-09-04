# Homework for the Lesson «Prometheus Monitoring System»

**Completed by:** Ilembetov Vasily Rajapovich

---

## Assignment 1. Installing Prometheus

**Description:** Prometheus has been installed, the prometheus user has been created and the system service has been configured.

![Systemctl Prometheus](img/1_status_prometheus.png)

> The screenshot shows `systemctl status prometheus` with the line `prometheus.service — Prometheus Service Netology Lesson 9.4 — Ilembetov Vasily Rajapovich`.

---

## Assignment 2. Installing Node Exporter

**Description:** Node Exporter has been installed and the system service has been configured.

![Systemctl Node Exporter](https://github.com/Ilembet/Homeworks/blob/c381014015f6811e596bf6e33e9b3d7754027da8/Prometheus%20Node%20Exporter%20Grafana/img/2_status_Node%20Exporter.png)

> The screenshot shows `systemctl status node-exporter` with the line `node-exporter.service — Node Exporter Netology Lesson 9.4 — Ilembetov Vasily Rajapovich`.

---

## Assignment 3. Connecting Node Exporter to Prometheus

**Description:** The `node-exporter` target has been added to `prometheus.yml` and the service has been restarted.

![Prometheus Configuration](img/3_status_configuration.png)

![Prometheus Targets](img/3-1_status_targets.png)

> The configuration screenshot shows the **Status > Configuration** tab with the added `node-exporter` target.
> The endpoints screenshot shows the **Status > Targets** tab with at least two endpoints (prometheus and node-exporter).

---

## Assignment 4. Installing Grafana*

**Description:** Grafana has been installed.

![Grafana Profile](img/4_Grafana.png)

> The screenshot shows the Grafana interface (upper right corner when hovering over the user icon with the full name).

---

## Assignment 5. Integrating Grafana and Prometheus*

**Description:** Prometheus has been connected as a Data Source in Grafana.

![Grafana Prometheus Integration](https://github.com/Ilembet/Homeworks/blob/bd148d7e5ab16e1c167c8cd490f6ef2c028e5f90/Prometheus%20Node%20Exporter%20Grafana/img/5_Integration%20of%20Grafana%20and%20Prometheus.png)

> The screenshot shows the integrated Data Source or Grafana dashboard with Prometheus connected.
