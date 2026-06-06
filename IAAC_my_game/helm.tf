provider "helm" {

  kubernetes {
    host = data.aws_eks_cluster.game_cluster.endpoint

    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.game_cluster.certificate_authority[0].data
    )

    token = data.aws_eks_cluster_auth.game_cluster.token
  }
}

resource "helm_release" "aws_load_balancer_controller" {

  name       = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"

  chart      = "aws-load-balancer-controller"

  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.game_cluster.name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "region"
    value = "ap-south-1"
  }

  set {
    name  = "vpcId"
    value = aws_vpc.terraform_vpc.id
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb_controller.arn
  }

  depends_on = [
    aws_eks_node_group.spot_nodes,
    aws_iam_role_policy_attachment.alb_controller
  ]
}