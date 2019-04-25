output "vpc_subnet" {
  description = "Link of the Subnet"
  value       = "${module.network_nat.vpc_subnet_link}"
}

output "router_link" {
  description = "Link of the Router"
  value       = "${module.network_nat.router_link}"
}

output "nat_ip" {
  description = "NAT IP address"
  value       = "${module.network_nat.nat_ip}"
}

output "gke_cluster_endpoint" {
  description = "GKE Master endpoint"
  value       = "${module.gke_cluster.cluster_endpoint}"
}
