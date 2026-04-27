# OCI Core OKE Stack

This stack provisions the OKE cluster and node pool using network IDs from `oci-core/network`.

## Resources Created

- `oci_containerengine_cluster.main`
- `oci_containerengine_node_pool.main`

## Required Inputs

- `vcn_id`
- `public_subnet_id`

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
