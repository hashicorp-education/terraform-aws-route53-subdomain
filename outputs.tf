output "app_subdomain_url" {
  value       = "http://${var.waypoint_application}.${var.domain}"
  description = "The subdomain URL for the app."
}