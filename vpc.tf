# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Private Subnets

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.azs)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = var.azs[count.index]

  tags = {
    Name = element(var.private_subnets_name, count.index)
  }
}

# Public Subnets

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.azs)
  cidr_block        = element(var.public_subnets_cidr, count.index)
  availability_zone = var.azs[count.index]

  tags = {
    Name = element(var.public_subnets_name, count.index)
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.public_subnets_cidr)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_rt_name[count.index]
  }
}

# Route Table for Private Subnets  
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_subnets_cidr)

  tags = {
    Name = var.private_rt_name[count.index]
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.public_rt.*.id, count.index)
}

# Route Table Association for Private Subnets
resource "aws_route_table_association" "private_rt_association" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}
