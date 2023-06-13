resource "aws_vpc" "this" {
  cidr_block           = var.cidr_for_vpc
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.dns_hostnames_enabled
  enable_dns_support   = var.dns_support_enabled
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  for_each   = { for index, az_name in data.aws_availability_zones.this.names : index => az_name }
  vpc_id     = aws_vpc.this.id
  # cidr_block = ""
}

# resource "aws_subnet" "private_subnet" {

# }
variable "no_of_subnets" {
  type        = number
  description = "Number of subnets to be created"
  default     = 6 #If variable is not passed then waht value needed to be considered
}

variable "cidr_subnet" {
  type        = list(string)
  description = "List of CIDR range in Subnets"
  default     = ["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27", "192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"]
}