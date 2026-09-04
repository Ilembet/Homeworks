output "vm_internal_ips" {
  value = [
    for vm in yandex_compute_instance.nginx :
    vm.network_interface[0].ip_address
  ]
}

output "vm_external_ips" {
  value = [
    for vm in yandex_compute_instance.nginx :
    vm.network_interface[0].nat_ip_address
  ]
}

output "load_balancer_ip" {
  value = one([
    for listener in yandex_lb_network_load_balancer.nginx.listener :
    one([
      for address_spec in listener.external_address_spec :
      address_spec.address
    ])
  ])
}
