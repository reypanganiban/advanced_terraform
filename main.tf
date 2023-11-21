### PROVIDER
provider "google" {
  project = var.project-id
  region  = var.region
  zone    = var.zone
}

### NETWORK
data "google_compute_network" "default" {
  name                    = "default"
}

## SUBNET
resource "google_compute_subnetwork" "subnet-1" {
  name                     = var.subnet-name
  ip_cidr_range            = var.subnet-cidr
  network                  = data.google_compute_network.default.self_link
  region                   = var.region
  private_ip_google_access = var.private_google_access
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = data.google_compute_network.default.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000", "22"]
  }

  source_tags = var.compute-source-tags
}

### COMPUTE
## NGINX PROXY
resource "google_compute_instance" "nginx_instance" {
  name         = "nginx-proxy"
  machine_type = var.environment_machine_type[var.target_environment]
  tags         = var.compute-source-tags
  labels       = {
    environment = var.environment_map[var.target_environment]
  }
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
    access_config {
      
    }
  }
}

## Buckets

resource "google_storage_bucket" "environment_buckets" {
  for_each = toset(var.environment_list)
  name     = "${lower(each.key)}_${var.project-id}"
  location = "US"
  versioning {
    enabled = true
  }
}

## WEB-INSTANCES: will create 3 web instances
# resource "google_compute_instance" "web-instances" {
#   count        = 3
#   name         = "web-${count.index}"
#   machine_type = var.environment_machine_type[var.target_environment]
#   labels       = {
#     environment = var.environment_map[var.target_environment]
#   }
  
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     # A default network is created for all GCP projects
#     network = data.google_compute_network.default.self_link
#     subnetwork = google_compute_subnetwork.subnet-1.self_link
#   }
# }

## WEB MAP INSTANCES: will create machines for all the environments - dev, qa, staging, production
resource "google_compute_instance" "web-instances" {
  for_each     = var.environment_instance_settings
  name         = "${lower(each.key)}-web"
  machine_type = each.value.machine_type
  labels       =  each.value.labels

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}


## DB
resource "google_compute_instance" "mysqldb" {
  name         = "mysqldb"
  machine_type = var.environment_machine_type[var.target_environment]
  labels       = {
    environment = var.environment_map[var.target_environment]
  }
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }  
}