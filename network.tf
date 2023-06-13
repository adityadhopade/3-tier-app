resource "aws_vpc" "this" {
  cidr_block       = "192.168.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "Aditya-first-tf-vpc"
  }
}


resource "aws_subnet" "this" {
  # for_each   = toset(["192.168.0.0/27", "192.168.0.32/27", "192.168.0.64/27", " 192.168.0.96/27", "192.168.0.128/27", "192.168.0.160/27"])
  for_each   = { "1": "192.168.0.0/27", "2":"192.168.0.32/27", "3": "192.168.0.64/27", "4": "192.168.0.96/27", "5": "192.168.0.128/27", "6": "192.168.0.160/27"}
  vpc_id     = aws_vpc.this.id
  cidr_block = each.value

  tags = {
    Name = "Main_${each.key}"
  }
}