data "aws_autoscaling_groups" "groups" {
  filter {
    name   = "tag:eks:cluster-name"
    values = ["${var.service}-${var.env}"]
  }
}
