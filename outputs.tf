output "nginx-public-ip" {
  value = google_compute_instance.nginx_instance.network_interface[0].access_config[0].nat_ip
}

output "webserver-ips" {
  value = { for instance in google_compute_instance.web-instances: instance.name => instance.network_interface[0].network_ip }
}

output "db-private-ip" {
  value = google_compute_instance.mysqldb.network_interface[0].network_ip
}