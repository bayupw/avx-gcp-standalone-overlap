# Create Standalone Aviatrix Gateway in each region/subnet
resource "aviatrix_gateway" "avx_standalone_gw" {
  count = length(module.gcp_prod_vpc.subnets_regions)

  cloud_type   = 4
  account_name = var.gcp_account_name
  gw_name      = "${module.gcp_prod_vpc.subnets_regions[count.index]}gw"
  vpc_id       = module.gcp_prod_vpc.network_name
  vpc_reg      = "${module.gcp_prod_vpc.subnets_regions[count.index]}-b"
  gw_size      = "n1-standard-1"
  subnet       = module.gcp_prod_vpc.subnets_ips[count.index]
}

/* 
# Create Standalone Aviatrix Gateway in EU
resource "aviatrix_gateway" "eu_prod_1" {
  cloud_type   = 4
  account_name = var.gcp_account_name
  gw_name      = "euprodgw"
  vpc_id       = module.gcp_prod_vpc.network_name
  vpc_reg      = "${module.gcp_prod_vpc.subnets_regions[1]}-b"
  gw_size      = "n1-standard-1"
  subnet       = module.gcp_prod_vpc.subnets_ips[1]
} */