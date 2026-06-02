resource "aws_eks_node_group" "spot_nodes" {
  cluster_name    = aws_eks_cluster.game_cluster.name
  node_group_name = "multi-az-spot-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = [aws_subnet.public_1a.id, aws_subnet.public_1b.id]

  # Cost Saver: Spot pricing drops t3.medium costs by up to 70%
  capacity_type  = "SPOT"
  instance_types = ["t3.medium"] 

  scaling_config {
    desired_size = 2 # Deploys 2 nodes total, allowing 1 node per Availability Zone
    min_size     = 2
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}