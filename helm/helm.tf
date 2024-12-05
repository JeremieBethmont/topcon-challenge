resource "helm_release" "topcon-wordpress" {
  name       = "${var.service}-${var.env}-wordpress"
  repository = "oci://registry-1.docker.io/bitnamicharts/"
  chart      = "wordpress"

  set {
    name  = "image.registry"
    value = "881490094297.dkr.ecr.eu-west-1.amazonaws.com" # Should be pulled dynamically
  }

  set {
    name  = "image.repository"
    value = "topcon-challenge-dev" # Should be pulled dynamically
  }

  set {
    name  = "image.tag"
    value = "b483060b16420825cb72bba5135966c800d70dac" # Should be pulled dynamically
  }

  set {
    name  = "global.defaultStorageClass"
    value = "gp2"
  }

  set {
    name  = "mariadb.auth.rootPassword"
    value = "secretpassword" # Could be pulled from secrets
  }

  set {
    name  = "wordpressPassword"
    value = "password" # Could be pulled from secrets
  }

  set {
    name  = "wordpressUsername"
    value = "admin"
  }
}
