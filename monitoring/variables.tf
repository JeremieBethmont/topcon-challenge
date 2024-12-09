## GENERAL ##

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

## MONITORING ##

variable "notification_email" {
  description = "Email where to send alarms"
  type        = string
  default     = "jeremie.bethmont@pm.me"
}
