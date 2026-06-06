#subnets
resource "aws_subnet" "public_subnet_1a" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.1.0/24"
  
  # Important for Public Node setups: Automatically assigns public IPs to instances
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1a"
    "kubernetes.io/role/elb"           = "1"
    "kubernetes.io/cluster/game-cluster" = "shared"
  }
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.2.0/24"
  
  # Important for Public Node setups: Automatically assigns public IPs to instances
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_1b"
    "kubernetes.io/role/elb"           = "1"
    "kubernetes.io/cluster/game-cluster" = "shared"
  }
  availability_zone = "ap-south-1b"
}
