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

## EKS CLUSTER ##

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "eks_node_groups" {
  description = "Map of managed node groups config for EKS"
  type        = map(any)
  default = {
    one = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 5
      desired_size = 3
    }
  }
}
