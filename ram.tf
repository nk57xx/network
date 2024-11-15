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

# Get amount of existing Private Subnets
data "aws_subnet" "private" {
  for_each = aws_subnet.private_subnets
  id       = each.value.id
}

# Get amount of existing Public Subnets
data "aws_subnet" "private" {
  for_each = aws_subnet.public_subnets
  id       = each.value.id
}

# Associate Private Subnets to RAM
resource "aws_ram_resource_association" "private_subnets" {
  for_each           = data.aws_subnet.private_subnets
  resource_arn       = each.value.arn
  resource_share_arn = aws_ram_resource_share.share_vpc_subnets.arn
}

# Associate Public Subnets to RAM
resource "aws_ram_resource_association" "public_subnets" {
  for_each           = data.aws_subnet.public_subnets
  resource_arn       = each.value.arn
  resource_share_arn = aws_ram_resource_share.share_vpc_subnets.arn
}
