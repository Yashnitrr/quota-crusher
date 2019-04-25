output "cluster_endpoint" {
  value = "${google_container_cluster.istio_cluster.endpoint}"
}
