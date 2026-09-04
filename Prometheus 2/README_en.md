# Homework Assignment for "Prometheus. Part 2"

**Student:** Ilembetov Vasil Razhapovich

---

## Assignment 1

### Configuring an Alert Rule in Prometheus

**Description:** Create an alerting rule in Prometheus that triggers under certain conditions, and verify that the rule is correctly interpreted by the system.


**Screenshot of Pending status:**

![Pending Status](img/1_status_Pending.png)

---

## Assignment 2

### Installing Alertmanager and Integrating with Prometheus

**Description:** Download and install Alertmanager, configure it with notification channels, and integrate it with Prometheus for sending alerts.


**Screenshot of Firing status in Prometheus and active rule in Alertmanager:**

![Firing Status](img/2_status_firing.png)

![Alertmanager Rules](img/2-1_alertmaanger_rules.png)

---

## Assignment 3

### Activating a Metrics Exporter in Docker and Connecting to Prometheus

**Description:** Run a Docker container, enable the metrics exporter in Docker: create and open the daemon configuration file, specify the endpoint. Add as a target in Prometheus (in the yaml file) to collect metrics.


**Screenshot of the open exporter endpoint:**

![Open Endpoint](img/3_open_endpoint.png)

**Screenshot of Targets list in Prometheus:**

![Targets Prometheus](img/3-1_targets_prometheus.png)
