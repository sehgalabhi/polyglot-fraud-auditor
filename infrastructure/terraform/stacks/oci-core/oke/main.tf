data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.network_state_bucket
    key    = var.network_state_key
    region = var.network_state_region
  }
}

resource "oci_containerengine_cluster" "main" {
  compartment_id     = var.compartment_ocid
  kubernetes_version = var.kubernetes_version
  name               = "${local.name_prefix}-oke"
  vcn_id             = data.terraform_remote_state.network.outputs.vcn_id
  freeform_tags      = local.common_tags

  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = data.terraform_remote_state.network.outputs.public_subnet_id
  }

  options {
    service_lb_subnet_ids = [data.terraform_remote_state.network.outputs.public_subnet_id]
  }
}

resource "oci_containerengine_node_pool" "main" {
  cluster_id          = oci_containerengine_cluster.main.id
  compartment_id      = var.compartment_ocid
  kubernetes_version  = var.kubernetes_version
  name                = "${local.name_prefix}-node-pool"
  node_shape          = var.node_shape
  freeform_tags       = local.common_tags

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
      subnet_id           = data.terraform_remote_state.network.outputs.public_subnet_id
    }
    size = var.node_pool_size
  }

  node_shape_config {
    ocpus         = var.node_ocpus
    memory_in_gbs = var.node_memory_gbs
  }

  node_source_details {
    source_type = "IMAGE"
    image_id    = data.oci_containerengine_node_pool_option.main.sources[0].image_id
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_containerengine_node_pool_option" "main" {
  node_pool_option_id = "all"
  compartment_id      = var.compartment_ocid
}
