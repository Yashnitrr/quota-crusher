/*
Creates a subnet in specified network, and region

Refer https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html
*/

resource "google_compute_subnetwork" "custom_istio_subnet" {
  name   = "${var.vpc_network_name}-istio"
  region = "${var.region}"

  ip_cidr_range            = "${var.subnet_cidr_range}"
  network                  = "${var.vpc_network_name}"
  private_ip_google_access = true
}

/*
Reserves a Public IP address for NAT

https://www.terraform.io/docs/providers/google/r/compute_address.html
*/

resource "google_compute_address" "address" {
  name   = "${var.vpc_network_name}-istio-demo"
  region = "${var.region}"
}

/*
Creates a Cloud Router

https://www.terraform.io/docs/providers/google/r/compute_router.html
*/

resource "google_compute_router" "router" {
  name    = "${var.gcp_router_name}"
  network = "${var.vpc_network_name}"
  region  = "${var.region}"
}

/*
Creates a Cloud NAT and only serves to the subnet created by Terraform

https://www.terraform.io/docs/providers/google/r/compute_router_nat.html
*/

resource "google_compute_router_nat" "nat" {
  name                   = "${var.gcp_nat_name}"
  region                 = "${var.region}"
  router                 = "${google_compute_router.router.name}"
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = ["${google_compute_address.address.self_link}"]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "${google_compute_subnetwork.custom_istio_subnet.self_link}"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
