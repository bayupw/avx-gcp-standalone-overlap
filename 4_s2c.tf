resource "aviatrix_site2cloud" "prod_onprem_s2c" {
  vpc_id                     = "${module.gcp_prod_vpc.network_name}~-~${var.gcp_project_id}"
  connection_name            = "prod_onprem_s2c"
  connection_type            = "mapped"
  remote_gateway_type        = "generic"
  tunnel_type                = "route"
  primary_cloud_gateway_name = resource.aviatrix_gateway.avx_standalone_gw[0].gw_name

  remote_gateway_ip = module.vpn_onprem_prod.gateway_ip
  pre_shared_key    = "secrets"
  enable_ikev2      = true

  ha_enabled = false

  custom_mapped         = false
  remote_subnet_cidr    = "10.1.1.0/24"
  remote_subnet_virtual = "100.64.1.0/24"
  local_subnet_cidr     = "10.1.1.0/24"
  local_subnet_virtual  = "100.64.11.0/24"
}