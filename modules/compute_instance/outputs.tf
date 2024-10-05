output "instance_names" {
  value = google_compute_instance.web_server.*.name
}

output "public_ips" {
  value = google_compute_instance.web_server[*].network_interface.0.access_config[0].nat_ip
}
