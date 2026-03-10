terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "my-gcp-project"
  region  = "us-central1"
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "28.0.0"

  project_id             = "my-gcp-project"
  name                   = "gke-production"
  region                 = "us-central1"
  network                = "default"
  subnetwork             = "default"
  ip_range_pods          = ""
  ip_range_services      = ""
  create_service_account = true
}

module "cloud_nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "4.0.0"

  project_id    = "my-gcp-project"
  region        = "us-central1"
  router        = "nat-router"
  name          = "cloud-nat"
  network       = "default"
  create_router = true
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "8.0.0"

  project_id   = "my-gcp-project"
  network_name = "production-vpc"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"
    }
  ]
}
