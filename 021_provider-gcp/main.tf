terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.84.0"
    }
  }
}

provider "google" {
  credentials = "terraform-gcp-example-326401-042e1f1dc62c.json"
	project = "terraform-gcp-example-326401"
	region = "us-central1"
	zone = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config { }
  }
}