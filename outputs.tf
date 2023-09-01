output "app_subdomain_url" {
  value       = "http://${var.waypoint_project}.${var.domain}"
  description = "The subdomain URL for the app."
}