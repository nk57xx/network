# Create RAM Resource Share
resource "aws_ram_resource_share" "share_vpc_subnets" {
  name = var.ram_name

  tags = {
    Name = "Network-RAM-share-for-vpc-subnets"
  }
}

# Share to Sandbox OU
resource "aws_ram_principal_association" "principal_association_sandbox_ou" {
  principal          = var.ou_sandbox_arn
  resource_share_arn = aws_ram_resource_share.share_vpc_subnets.arn
}

# Associate Private Subnets to RAM
resource "aws_ram_resource_association" "private_subnets" {
  count              = length(var.private_subnets_cidr)
  resource_arn       = aws_subnet.private_subnets[count.index].arn
  resource_share_arn = aws_ram_resource_share.share_vpc_subnets.arn
}

# Associate Public Subnets to RAM
resource "aws_ram_resource_association" "public_subnets" {
  count              = length(var.public_subnets_cidr)
  resource_arn       = aws_subnet.public_subnets[count.index].arn
  resource_share_arn = aws_ram_resource_share.share_vpc_subnets.arn
}
