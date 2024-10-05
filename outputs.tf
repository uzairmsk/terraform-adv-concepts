output "web_server_ips" {
  description = "Public IPs of the web servers"
  value       = module.web_servers.public_ips
}
