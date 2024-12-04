variable "service" {
  description = "Service in scope"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "env" {
  description = "Environment"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "Must be in: dev, stage, prod"
  }
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
