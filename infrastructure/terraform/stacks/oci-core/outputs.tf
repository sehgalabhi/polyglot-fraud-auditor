output "vcn_id" {
  description = "OCID of the OCI VCN."
  value       = oci_core_vcn.main.id
}

output "public_subnet_id" {
  description = "OCID of the public subnet."
  value       = oci_core_subnet.public.id
}

output "private_subnet_id" {
  description = "OCID of the private subnet."
  value       = oci_core_subnet.private.id
}

output "oke_cluster_id" {
  description = "OCID of the OKE cluster."
  value       = oci_containerengine_cluster.main.id
}

output "oke_node_pool_id" {
  description = "OCID of the OKE node pool."
  value       = oci_containerengine_node_pool.main.id
}
