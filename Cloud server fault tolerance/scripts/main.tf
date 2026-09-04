terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 1.3.0"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}


# Ubuntu 22.04
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}


# Network
resource "yandex_vpc_network" "network" {
  name = "netology-lb-network"
}


# Subnet
resource "yandex_vpc_subnet" "subnet" {
  name           = "netology-lb-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


# Two identical virtual machines
resource "yandex_compute_instance" "nginx" {
  count = 2

  name = "nginx-${count.index + 1}"

  zone = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(pathexpand(var.ssh_public_key_path))}"
    user-data = file("${path.module}/cloud-init.yaml")
  }
}


# Target group
resource "yandex_lb_target_group" "nginx" {
  name      = "nginx-target-group"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.nginx

    content {
      subnet_id = yandex_vpc_subnet.subnet.id
      address   = target.value.network_interface[0].ip_address
    }
  }
}


# Network Load Balancer
resource "yandex_lb_network_load_balancer" "nginx" {
  name = "nginx-load-balancer"

  listener {
    name        = "http"
    port        = 80
    target_port = 80
    protocol    = "tcp"

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.nginx.id

    healthcheck {
      name = "http-healthcheck"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
