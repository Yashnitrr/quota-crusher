output "vpc_subnet_link" {
  value = "${google_compute_subnetwork.custom_istio_subnet.self_link}"
}

output "router_link" {
  value = "${google_compute_router.router.self_link}"
}

output "nat_ip" {
  value = "${google_compute_address.address.address}"
}
