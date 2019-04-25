// The network module creates a Subnet, Router, and Cloud NAT in the defined network

module "network_nat" {
  source = "./modules/cloud_nat"

  region            = "${var.region}"
  subnet_cidr_range = "${var.subnet_cidr_range}"
  vpc_network_name  = "${var.vpc_network_name}"
  gcp_router_name   = "${var.gcp_router_name}"
  gcp_nat_name      = "${var.gcp_nat_name}"
}

// The gke_cluster module creates a GKE cluster over the above network, and subnet

module "gke_cluster" {
  source = "./modules/gke_cluster"

  project = "${var.project}"
  region  = "${var.region}"

  vpc_network_name = "${var.vpc_network_name}"
  vpc_subnet_name  = "${module.network_nat.vpc_subnet_link}"

  master_cidr_range     = "${var.master_cidr_range}"
  authorized_cidr_range = "${var.authorized_cidr_range}"

  gke_cluster_name     = "${var.gke_cluster_name}"
  min_master_version = "${var.min_master_version}"
  node_pool_name       = "${var.node_pool_name}"
  gke_initial_node     = "${var.gke_initial_node}"
  cluster_machine_type = "${var.cluster_machine_type}"
  min_node_count       = "${var.min_node_count}"
  max_node_count       = "${var.max_node_count}"

  sfdc_username = "${var.sfdc_username}"
  sfdc_password = "${var.sfdc_password}"

  istio_version = "${var.istio_version}"
}
