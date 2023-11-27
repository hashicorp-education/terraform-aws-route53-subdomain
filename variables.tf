variable "destination_org" {
  description = "The name of the organization in Github that will contain the templated repo."
  default     = "hashicorp-education"
}

variable "gh_token" {
  description = "Github token with permissions to create and delete repos."
}

variable "waypoint_application" {
  type        = string
  description = "Name of the Waypoint project."

  validation {
    condition     = !contains(["-", "_"], var.waypoint_application)
    error_message = "waypoint_application must not contain dashes or underscores."
  }
}

variable "domain" {
  description = "The top level domain name used for redirects."
  default     = "hathatgames.com"
}

variable "aws_region" {
  description = "The AWS region to contain resources."
  default     = "us-east-1"
}

variable "route53_zone_id" {
  description = "The premade route53 zone ID. The zone is created outside of here so that the domain config can be set up beforehand."
}