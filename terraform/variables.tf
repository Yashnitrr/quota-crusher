//Variables must be changed according to the executing project/environment

variable project {
  description = "The ID of the project in which the resources will belong"
  default     = "palo-alto-networks-234507"
}

variable region {
  description = "A reference to the region for the deployment"
  default     = "us-west1"
}

variable vpc_network_name {
  description = "A reference to the network for the deployment. The terraform must be ran from same network for reachability."
  default     = "default"
}

variable vpc_subnet_name {
  description = "The name of the subnet resource to be created in the network"
  default     = "istio"
}

variable subnet_cidr_range {
  description = "The range of internal addresses that are owned by this subnetwork."
  default     = "192.168.0.0/24"
}

variable gcp_router_name {
  description = "A name for resource Router"
  default     = "istio-demo"
}

variable gcp_nat_name {
  description = "A unique name for Cloud NAT"
  default     = "istio-nat"
}

variable master_cidr_range {
  description = "The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters. It must not overlap with any other ranges in use within the cluster's network. Must be in /28 range"
  default     = "172.16.0.0/28"
}

variable authorized_cidr_range {
  description = "Network range that can access Kubernetes master through HTTPS"
  default     = "10.138.0.0/20"
}

variable gke_initial_node {
  description = "Initial nodes to be deployed in Google Kubernetes Engine, by default it is a Regional deployment"
  default     = "1"
}

variable gke_cluster_name {
  description = "Google Kubernetes Engines cluster name"
  default     = "istio-tf"
}

variable node_pool_name {
  description = "Google Kubernetes Engines cluster node pool name"
  default     = "istio-demo-nodes"
}

variable min_master_version {
description = "Minimim master version for GKE Master, same would be used for Worker nodes"
default = "1.12.7-gke.7"
}

variable cluster_machine_type {
  description = "Google Kubernetes Engines cluster node machine type"
  default     = "n1-standard-2"
}

variable min_node_count {
  description = "GKE cluster autoscaling- minimum node"
  default     = "1"
}

variable max_node_count {
  description = "GKE cluster autoscaling- maximum node"
  default     = "6"
}

variable sfdc_username {
  description = "Username for SFDC, to be used for authentication in SFDC microservice"
}

variable sfdc_password {
  description = "Password for SFDC, to be used for authentication in SFDC microservice"
}

variable istio_version {
  description = "Istio's version to be deployed"
  default     = "1.1.3"
}
