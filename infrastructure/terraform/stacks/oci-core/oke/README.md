# OCI Core OKE Stack

This stack provisions the OKE cluster and node pool by reading network outputs from `oci-core/network` remote state.

## Resources Created

- `oci_containerengine_cluster.main`
- `oci_containerengine_node_pool.main`

## Required Inputs

- OCI auth + compartment settings (`tenancy_ocid`, `user_ocid`, `fingerprint`, `private_key_path`, `region`, `compartment_ocid`)
- S3 remote-state location for `oci-core/network` outputs (`network_state_bucket`, `network_state_key`, `network_state_region`)

## Always Free Baseline Defaults

- `node_pool_size = 1`
- `node_shape = "VM.Standard.A1.Flex"`
- `node_ocpus = 2`
- `node_memory_gbs = 12`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
