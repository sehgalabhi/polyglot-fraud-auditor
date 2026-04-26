# OCI Core Stack

This stack provisions the OCI networking and OKE base required to run the project workloads.

## Resources Created

### Networking

- `oci_core_vcn.main`: project VCN
- `oci_core_internet_gateway.main`: internet gateway for public traffic
- `oci_core_route_table.public`: default route to internet gateway
- `oci_core_subnet.public`: public subnet (API endpoint / load balancer path)
- `oci_core_nat_gateway.main`: NAT gateway for private egress
- `oci_core_route_table.private`: default route to NAT gateway
- `oci_core_subnet.private`: private subnet for worker nodes
- `oci_core_subnet_route_table_attachment.private`: attaches private route table to private subnet

### OKE

- `oci_containerengine_cluster.main`: OKE control plane
- `oci_containerengine_node_pool.main`: worker node pool in private subnet

### Data Sources Used

- `oci_identity_availability_domains.ads`: selects availability domain
- `oci_containerengine_node_pool_option.main`: resolves default node image

## Variables Used

- Required:
  - `tenancy_ocid`
  - `user_ocid`
  - `fingerprint`
  - `private_key_path`
  - `region`
  - `compartment_ocid`
- Common optional:
  - `project_name`, `environment`
  - `vcn_cidr`, `public_subnet_cidr`, `private_subnet_cidr`
  - `kubernetes_version`
  - `node_pool_size`, `node_shape`, `node_ocpus`, `node_memory_gbs`
  - `freeform_tags`

## Outputs

- `vcn_id`
- `public_subnet_id`
- `private_subnet_id`
- `oke_cluster_id`
- `oke_node_pool_id`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
