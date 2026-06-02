resource "aws_eks_cluster" "game_cluster" {
  name     = "game-cluster"
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids              = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]
    endpoint_private_access = true
    endpoint_public_access  = true # Allows you to issue kubectl commands from your laptop
  }

  depends_on = [aws_iam_role_policy_attachment.cluster_policy]
}