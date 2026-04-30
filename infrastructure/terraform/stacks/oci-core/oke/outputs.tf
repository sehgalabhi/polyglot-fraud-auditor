output "oke_cluster_id" {
  description = "OCID of the OKE cluster."
  value       = oci_containerengine_cluster.main.id
}

output "oke_node_pool_id" {
  description = "OCID of the OKE node pool."
  value       = oci_containerengine_node_pool.main.id
}

output "oidc_issuer_url" {
  description = "OIDC issuer discovery endpoint for the OKE cluster."
  value       = oci_containerengine_cluster.main.open_id_connect_discovery_endpoint
}
