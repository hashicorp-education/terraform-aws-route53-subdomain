terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "github" {
  owner = var.destination_org
  token = var.gh_token
}

resource "github_repository_file" "subdomain_url" {
  repository          = var.waypoint_application
  branch              = "main"
  file                = "shortlink.md"
  content             = "http://${var.waypoint_application}.${var.domain}"
  commit_message      = "http://${var.waypoint_application}.${var.domain}"
  commit_author       = "Platform team"
  commit_email        = "no-reply@example.com"
  overwrite_on_create = true
}

resource "aws_s3_bucket" "redirect" {
  bucket = "${var.waypoint_application}.${var.domain}"
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = "${var.waypoint_application}.${var.domain}"

  redirect_all_requests_to {
    host_name = "${var.destination_org}.github.io/${var.waypoint_application}"
  }
}

resource "aws_route53_record" "subdomain" {
  name    = "${var.waypoint_application}.${var.domain}"
  zone_id = var.route53_zone_id
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.redirect.website_domain
    zone_id                = aws_s3_bucket.redirect.hosted_zone_id
    evaluate_target_health = true
  }
}