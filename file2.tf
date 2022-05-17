
module "gce-container" {
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"
  container = {
      image = "gcr.io/george-tannous/myserver:latest"
  }
}
module "gce-advanced-container" {
    # container for database
  source  = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"
  container = {
      image = "gcr.io/george-tannous/mydatabase:latest"
  }
}

resource "google_compute_instance_template" "myserver" {
  name         = "my-instance-template"
  machine_type = "c2-standard-4"
  description = "Template made for running mutliple VM compute instances in order to run the flask app"
  disk {
    source_image = "cos-cloud/cos-stable"
    auto_delete  = true
    boot         = true
  }
  metadata = {
    gce-container-declaration = module.gce-container.metadata_value 

  }
  tags = ["http-server"]
  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {
      
    }

  }
  service_account {
    scopes = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/pubsub",
    "https://www.googleapis.com/auth/cloudplatformprojects.readonly",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/cloud-platform.read-only",
    "https://www.googleapis.com/auth/cloudplatformprojects",
    "https://www.googleapis.com/auth/bigquery",
    "https://www.googleapis.com/auth/datastore",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/source.full_control",
    "https://www.googleapis.com/auth/source.read_only",
    "https://www.googleapis.com/auth/compute.readonly"
  ]
  }
}

  resource "google_compute_autoscaler" "scaler" {
      zone = "us-central1-a"
      name = "scaler-from-1-to-10"
      target = google_compute_instance_group_manager.flask-server.id
      autoscaling_policy {
        min_replicas = 1
        max_replicas = 10
        cpu_utilization {
          target = 0.5
        }
      }
    
  }
  resource "google_compute_instance_group_manager" "flask-server" {
  name = "flask-server-igm"

  base_instance_name = "flask-server"
  zone = "us-central1-a"


  version {
    instance_template = google_compute_instance_template.myserver.id
  }
}

resource "google_compute_instance" "my-data-base" {

name  = "data-base-instance"
  machine_type = "c2-standard-4"
  boot_disk {
    initialize_params  {
        image = "cos-cloud/cos-stable"
    }
  }
  metadata = {
    gce-container-declaration = module.gce-advanced-container.metadata_value 

  }
  
  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {
      
    }
  }
  service_account {
    scopes = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/pubsub",
    "https://www.googleapis.com/auth/cloudplatformprojects.readonly",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/cloud-platform.read-only",
    "https://www.googleapis.com/auth/cloudplatformprojects",
    "https://www.googleapis.com/auth/bigquery",
    "https://www.googleapis.com/auth/datastore",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/source.full_control",
    "https://www.googleapis.com/auth/source.read_only",
    "https://www.googleapis.com/auth/compute.readonly"
  ]
  }  

}
  
