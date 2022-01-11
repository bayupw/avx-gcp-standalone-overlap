resource "google_compute_router" "onprem-gcp-router1" {
  name    = "onprem-gcp-router1"
  region  = var.onprem_region
  network = module.onprem_vpc.network_name
  project = var.gcp_project_id

  bgp {
    asn = "65000"
  }
}

module "vpn_onprem_prod" {
  source  = "terraform-google-modules/vpn/google"
  version = "~> 1.2.0"

  project_id         = var.gcp_project_id
  region             = var.onprem_region
  network            = module.onprem_vpc.network_name
  gateway_name       = "vpn-onprem-prod"
  tunnel_name_prefix = "vpn-onprem"
  shared_secret      = "secrets"
  tunnel_count       = 1
  peer_ips           = [resource.aviatrix_gateway.avx_standalone_gw[0].eip]

  route_priority = 1000
  remote_subnet  = ["100.64.11.0/24"]

  ike_version = 2
}
