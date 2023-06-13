resource "aws_vpc" "this" {
  cidr_block       = "192.168.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "Aditya-first-tf-vpc"
  }
}

resource "aws_subnet" "subnet_az1" {
  # for_each   = toset(["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27", " 192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"])
  for_each          = { "public_subnet_1_az1" : "192.168.0.0/27", "private_subnet_1_az1" : "192.168.0.32/27", "private_subnet_2_az1" : "192.168.0.64/27" }
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet_${each.key}"
  }
}

resource "aws_subnet" "subnet_az2" {
  # for_each   = toset(["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27", " 192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"])
  for_each          = { "public_subnet_1_az2" : "192.168.0.96/27", "private_subnet_1_az2" : "192.168.0.128/27", "priavte_subnet2_az2" : "192.168.0.160/27" }
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet_${each.key}"
  }
}

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