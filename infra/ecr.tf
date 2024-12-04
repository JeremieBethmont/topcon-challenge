resource "aws_ecr_repository" "foo" {
  name                 = "${var.service}-${var.env}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
