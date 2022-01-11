# Simulate Prod VPC
module "gcp_prod_vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id                             = var.gcp_project_id
  network_name                           = "production-vpc"
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = true

  subnets = [
    {
      subnet_name   = "prod-useast1-subnet1"
      subnet_ip     = "10.1.1.0/24"
      subnet_region = "us-east1"
    },
    {
      subnet_name   = "prod-euwest2-subnet1"
      subnet_ip     = "10.2.2.0/24"
      subnet_region = "europe-west2"
    }
  ]
}

# Simulate On Prem
module "onprem_vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 3.0"

  project_id                             = var.gcp_project_id
  network_name                           = "onprem-vpc"
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = true

  subnets = [
    {
      subnet_name   = "prod-subnet1"
      subnet_ip     = "10.1.1.0/24"
      subnet_region = var.onprem_region
    },
    {
      subnet_name   = "prod-subnet2"
      subnet_ip     = "10.2.2.0/24"
      subnet_region = var.onprem_region
    }
  ]
}