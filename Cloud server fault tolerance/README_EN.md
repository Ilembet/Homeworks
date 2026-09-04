# Cloud Server Fault Tolerance

Student: Ilembetov Vasil Razhapovich

## Objective

Deploy a fault-tolerant web infrastructure in Yandex Cloud using Terraform: provision two identical virtual machines with Nginx installed, register them in a Target Group, configure a Network Load Balancer (NLB) with HTTP health check, and verify service availability.

## Architecture

The infrastructure is deployed within a single Yandex Cloud VPC segment:

```
Internet
    │
    ▼
┌─────────────────────┐
│  Network Load Balancer  │  (port 80, HTTP health check → /)
└─────────────────────┘
    │
    ▼
┌─────────────────────────┐
│  Target Group              │
│  ┌─────────────────────┐ │
│  │  nginx-1 (Nginx)    │ │
│  │  nginx-2 (Nginx)    │ │
│  └─────────────────────┘ │
└─────────────────────────┘
```

### Network Topology

- **VPC network** (`netology-lb-network`)
- **Subnet** (`netology-lb-subnet`, `192.168.10.0/24`, zone `ru-central1-a`)
- Two VMs with external NAT addresses

## Steps Performed

### 1. Creating Two Identical VMs via Terraform `count`

In `main.tf`, the `yandex_compute_instance` resource uses `count = 2`, which creates two identical virtual machines (`nginx-1` and `nginx-2`) with 2 CPU cores, 2 GB RAM, and a 10 GB disk based on the Ubuntu 22.04 image.

### 2. Installing Nginx via `cloud-init`

The `user-data` configuration for both VMs is sourced from `cloud-init.yaml`. The script updates packages, installs Nginx, enables auto-start, and starts the service.

### 3. Creating a Target Group

The `yandex_lb_target_group` resource dynamically collects all created VMs (via `for_each = yandex_compute_instance.nginx`) and registers them in the target group bound to the subnet.

### 4. Creating a Network Load Balancer

The `yandex_lb_network_load_balancer` resource creates a load balancer with a TCP listener on port 80, forwarding traffic to targets on the same port.

### 5. HTTP Health Check on Port 80

The NLB configuration includes a healthcheck with HTTP options: probing path `/` on port 80. If at least one target passes the check, the balancer is considered healthy.

### 6. Traffic Forwarding from LB to VMs on Port 80

Client traffic arrives at the external IP address of the Network Load Balancer, which distributes requests across the two VMs in the Target Group on port 80.

### 7. Verifying Availability

After deploying the infrastructure, Nginx is accessible on each VM. Accessing the external IP address of the load balancer returns the default Nginx welcome page.

### 8. Final Result

A fault-tolerant infrastructure was successfully deployed in Yandex Cloud: two backends behind a Network Load Balancer with health checks, ensuring service availability even if a single target fails.

## Project Files

- [main.tf](scripts/main.tf) — core configuration: provider, network, subnet, VMs, Target Group, NLB
- [variables.tf](scripts/variables.tf) — variables (cloud_id, folder_id, zone, SSH key)
- [outputs.tf](scripts/outputs.tf) — outputs: internal and external VM IPs, load balancer IP
- [cloud-init.yaml](scripts/cloud-init.yaml) — initialization script: install and start Nginx

## Results

### Network Load Balancer

![Network Load Balancer](img/2_Network_Load_Balancer.png)

### Target Group

![Target Group](img/2_target_group.png)

### Nginx Verification on VM

![Nginx Welcome Page](img/3_Welcome_to_nginx.png)
