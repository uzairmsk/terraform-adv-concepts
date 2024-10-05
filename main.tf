# Compute Instance module
module "web_servers" {
  source         = "./modules/compute_instance"
  instance_name  = "web-server"
  machine_type   = "e2-standard-4"
  network        = "test-vpc-network"
  # subnet         = module.vpc.subnet_name
  zones          = var.zones
  instance_count = 2
}

# Copy the index.html file from local to the remote instances
resource "null_resource" "provision_index_html" {
    count = 2  # Assuming 2 instances
  
  connection {
    type        = "ssh"
    user        = "uzairmsk_k"
    private_key = file("/home/uzairmsk_k/.ssh/id_rsa")  # Replace with actual path to private key
    host        = module.web_servers.public_ips[count.index]
  }

  # File provisioner to copy the local index.html to the remote instance's Apache directory
  provisioner "file" {
    source      = "./index.html"  # Path to local index.html file
    destination = "/home/uzairmsk_k/index.html"  # Destination on the remote instance
  }

  # Restart Apache service after copying the file
  provisioner "remote-exec" {
    inline = [
      "yes | sudo cp -rf /home/uzairmsk_k/index.html /var/www/html/index.html && sudo systemctl restart apache2"
    ]
  } 

  depends_on = [module.web_servers]
}


