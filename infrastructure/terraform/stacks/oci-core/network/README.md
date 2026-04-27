# OCI Core Network Stack

This stack provisions OCI networking resources used by OKE.

## Resources Created

- `oci_core_vcn.main`
- `oci_core_internet_gateway.main`
- `oci_core_route_table.public`
- `oci_core_subnet.public`
- `oci_core_subnet.private` (reserved for future private-node setup)

## Outputs

- `vcn_id`
- `public_subnet_id`
- `private_subnet_id`

## How to Use

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```
