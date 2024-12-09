variable "service" {
  description = "Service in scope"
  type        = string
  default     = "topcon-challenge"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "Must be in: dev, stage, prod"
  }
}

## WORDPRESS VARIABLES ##

variable "wordpress_image_tag" {
  description = "Version tag of the wordpress container to deploy"
  type        = string
  default     = "latest"
}
