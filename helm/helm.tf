resource "helm_release" "topcon-wordpress" {
  name       = "${var.service}-${var.env}-wordpress"
  repository = "oci://registry-1.docker.io/bitnamicharts/"
  chart      = "wordpress"

  values = [
    templatefile("${path.module}/templates/wordpress-values.yaml", {
      service        = var.service
      env            = var.env
      image_tag      = var.wordpress_image_tag
      region         = data.aws_region.current.name
      aws_account_id = data.aws_caller_identity.current.account_id
    })
  ]
}

resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  values = [
    templatefile("${path.module}/templates/cluster-autoscaler-values.yaml", {
      cluster  = data.aws_eks_cluster.topcon-dev.id
      region   = data.aws_region.current.name
      role_arn = data.aws_iam_role.cluster-autoscaler.arn
    })
  ]
}
