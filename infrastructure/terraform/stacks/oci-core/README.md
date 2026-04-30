# OCI Core Stacks

`oci-core` is split into resource-specific Terraform roots, similar to `aws-core`.

## Prerequisites

- Terraform `>= 1.6`
- OCI credentials configured via `terraform.tfvars` values:
  - `tenancy_ocid`, `user_ocid`, `fingerprint`, `private_key_path`, `region`
- Target compartment OCID set in `compartment_ocid`
- (Recommended) Remote backend configured before first apply

## Layout

- `network/`: VCN, internet gateway, route table, and subnets.
- `oke/`: OKE cluster and node pool (reads network IDs from `network` remote state).

## How to Use

```bash
cd network
cp terraform.tfvars.example terraform.tfvars
terraform init && terraform apply

cd ../oke
cp terraform.tfvars.example terraform.tfvars
terraform init && terraform apply
```

## Notes

- Public subnet is intended for ingress paths (for example, load balancer/API endpoint exposure).
- Worker nodes run in the public subnet by default, so these stacks do not create NAT resources.
- If you increase `node_pool_size`, ensure aggregate A1 OCPU and memory usage stays within your tenancy's Always Free allowance.
- If you already bootstrapped remote state, run `terraform init -reconfigure` with your backend config.
