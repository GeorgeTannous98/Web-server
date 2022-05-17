terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.20.0"
    }
  }
}

provider "google" {
  credentials = file("service.json")
  project = "george-tannous"
  region = "us-central1"
  zone = "us-central1-a"
  
}


