resource "google_compute_instance" "web_server" {
  count        = var.instance_count
  name         = "${var.instance_name}-${count.index + 1}"
  machine_type = var.machine_type
  zone         = element(var.zones, count.index)

  boot_disk {
    auto_delete = true
    device_name = "instance-20241005-110453"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240910"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src           = "vm_add-tf"
    goog-ops-agent-policy = "v2-x86-template-1-3-0"
  }

  metadata = {
    enable-osconfig = "TRUE"
    ssh-keys = "uzairmsk_k:${file("~/.ssh/id_rsa.pub")}"
  }


  network_interface {
    network = var.network
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/devops-demo-431609/regions/us-central1/subnetworks/test-vpc-network"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "215827230323-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]



  # Startup script to install and configure Apache
  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
  EOT
}
