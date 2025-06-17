variable "count"                     { type = number }
variable "environment"              { type = string }
variable "name_prefix"              { type = string }
variable "release"                  { type = string }
variable "openstack_project_id"     { type = string }
variable "openstack_project_name"   { type = string }
variable "settings" {
  type = object({
    hybrid_deployment            = bool
    aws_chamber_tfstate_key      = string
    cc_chamber_json_s3_location  = string
    cc_hub_tfstate_key           = string
    drm_cidr                     = string
    aws_admin_cidr               = string
    aws_chamber_cidr             = string
    openstack_mgmt_ip            = string
  })
}
variable "provider_vlan"           { type = string }
variable "provider_cidr"           { type = string }
variable "baremetal_network_id"    { type = string }
variable "baremetal_subnet_id"     { type = string }
variable "compute_image"           { type = string }
variable "volume_size"             { type = number }
variable "hostnum_start"           { type = number }

resource "ironic_allocation_v1" "alloc" {
  count          = var.count
  resource_class = "baremetal"
}

resource "ironic_deployment" "worker" {
  count     = var.count
  node_uuid = ironic_allocation_v1.alloc[count.index].node_uuid

  instance_info = {
    image_source = var.compute_image
    root_gb      = var.volume_size
  }

  metadata = {
    environment       = var.environment
    name_prefix       = var.name_prefix
    release           = var.release
    project_id        = var.openstack_project_id
    project_name      = var.openstack_project_name
    chamber_s3        = var.settings.cc_chamber_json_s3_location
    drm_cidr          = var.settings.drm_cidr
    aws_admin_cidr    = var.settings.aws_admin_cidr
    aws_chamber_cidr  = var.settings.aws_chamber_cidr
    provider_vlan     = var.provider_vlan
    provider_cidr     = var.provider_cidr
    hostnum           = var.hostnum_start + count.index
  }
}
==============================================================================
terraform {
  source = "../modules/baremetal"
}

inputs = {
  count                      = 2
  hostnum_start              = 101
  environment                = "test-2"
  name_prefix                = "to01"
  release                    = "main"
  openstack_project_id       = "59c2d928ef6046069a0175d74dc3dc23"
  openstack_project_name     = "cc-test-oa-chm01-prj"

  settings = {
    hybrid_deployment           = false
    aws_chamber_tfstate_key     = "cloud30-chambers/config/envs/non-prod/dev/dc01/terraform.tfstate"
    cc_chamber_json_s3_location = "s3://cadencecloud-mirrors-eu-central-1/.../to01.json"
    cc_hub_tfstate_key          = "cloud30-openstack-shr/config/envs/non-prod/qa/test-2/to00/terraform.tfstate"
    drm_cidr                    = "10.3.120.0/23"
    aws_admin_cidr              = "10.3.64.0/27"
    aws_chamber_cidr            = "10.3.66.0/23"
    openstack_mgmt_ip           = "10.107.178.0/24"
  }

  provider_vlan            = "1168"
  provider_cidr            = "10.107.168.0/23"
  baremetal_network_id     = "5c79a1a8-b294-4435-a2e6-ef1b992735d3"
  baremetal_subnet_id      = "c83e54b1-822e-4931-ac73-b731d1f6c966"

  compute_image            = "a3b8b3b7-0fe0-402c-9e35-8999dc07e564"
  volume_size              = 100
}




=================================================================================================
variable "worker_count"        { type = number }
variable "hostnum_start"       { type = number }

variable "environment"         { type = string }
variable "name_prefix"         { type = string }
variable "release"             { type = string }
variable "openstack_project_id"   { type = string }
variable "openstack_project_name" { type = string }

variable "settings" {
  type = object({
    hybrid_deployment           = bool
    aws_chamber_tfstate_key     = string
    cc_chamber_json_s3_location = string
    cc_hub_tfstate_key          = string
    drm_cidr                    = string
    aws_admin_cidr              = string
    aws_chamber_cidr            = string
    openstack_mgmt_ip           = string
  })
}

variable "provider_vlan"        { type = string }
variable "provider_cidr"        { type = string }
variable "baremetal_network_id" { type = string }
variable "baremetal_subnet_id"  { type = string }

variable "compute_image"        { type = string }
variable "volume_size"          { type = number }

locals {
  # Generate worker info list based on count
  workers = [
    for idx in range(var.worker_count) : {
      name        = "${var.name_prefix}-worker-${idx + 1}"
      hostnum     = var.hostnum_start + idx
      image       = var.compute_image
      volume_size = var.volume_size
    }
  ]
}

# Example of exporting the parsed worker list
output "workers" {
  value = local.workers
}

# Forward settings as output
output "settings" {
  value = var.settings
}

# Network details
output "networking" {
  value = {
    vlan      = var.provider_vlan
    cidr      = var.provider_cidr
    net_id    = var.baremetal_network_id
    subnet_id = var.baremetal_subnet_id
  }
}

