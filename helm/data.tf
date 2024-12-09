data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_eks_cluster" "topcon-dev" {
  name = "${var.service}-${var.env}"
}

data "aws_iam_role" "cluster-autoscaler" {
  name = "cluster-autoscaler"
}

