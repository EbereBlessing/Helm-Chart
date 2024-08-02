#VPC  Setup
resource "aws_vpc" "eks_vpc" {
  # Your VPC must have DNS hostname and DNS resolution support. 
  cidr_block       = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  
  
  tags = {
    Name = "${var.vpc_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
  }
}

# Create the private subnet
resource "aws_subnet" "eks_private_subnet" {
  count = 2
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index + 2)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "private"
  }
}
# Create the public subnet
resource "aws_subnet" "eks_public_subnet" {
  count = 2
  vpc_id            = "${aws_vpc.eks_vpc.id}"
  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index )
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "public"
  }

  map_public_ip_on_launch = true
}
data "aws_availability_zones" "available" {}

# Create IGW for the public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.eks_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "${var.route_table_name}"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "public_subnet" {
  count = 2
  subnet_id      = "${aws_subnet.eks_public_subnet[count.index].id}"
  route_table_id = "${aws_route_table.main.id}"
}

# Create Elastic IP
resource "aws_eip" "main" {
  domain             = "vpc"
}

# Create NAT Gateway
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.eks_public_subnet[0].id

  tags = {
    Name = "NAT Gateway for EKS Project"
  }
}

# Add route to route table
resource "aws_route" "main" {
  route_table_id            = aws_vpc.eks_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
}
