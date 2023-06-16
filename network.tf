resource "aws_vpc" "this" {
  cidr_block           = var.cidr_for_vpc
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.dns_hostnames_enabled
  enable_dns_support   = var.dns_support_enabled
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet" {
  for_each          = { for index, az_name in slice(data.aws_availability_zones.this.names, 0, 2) : index => az_name }
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_for_vpc, length(data.aws_availability_zones.this.names) > 4 ? 3 : 2, each.key)
  availability_zone = each.value
  tags = {
    Name = "private-subnet-${each.key}"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each          = { for index, az_name in slice(data.aws_availability_zones.this.names, 0, 2) : index => az_name }
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_for_vpc, length(data.aws_availability_zones.this.names) > 4 ? 3 : 2, each.key + length(data.aws_availability_zones.this.names))
  availability_zone = each.value
  tags = {
    Name = "public-subnet-${each.key}"
  }
}

resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = {
    Name = "private_rt_${var.vpc_name}"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "public_rt_${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "igw-${var.vpc_name}"
  }
}

# route table association for private subnets

resource "aws_route_table_association" "private_subnet_association" {
  for_each       = toset([for each_subnet in aws_subnet.private_subnet : each_subnet.id])
  subnet_id      = each.key
  route_table_id = aws_default_route_table.this.id
}
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = toset([for each_subnet in aws_subnet.public_subnet : each_subnet.id])
  subnet_id      = each.key
  route_table_id = aws_route_table.this.id
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = element([for each_subnet in aws_subnet.public_subnet : each_subnet.id], 0)
  tags = {
    Name = "nat_gw_${var.vpc_name}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]
}

resource "aws_eip" "this" {
  domain = "vpc"
}