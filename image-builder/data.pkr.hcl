data "amazon-ami" "this" {
  filters = {
    virtualization-type = "hvm"
    root-device-type    = "ebs"
    name                = "al2023-ami-*"
  }
  owners      = ["137112412989"]
  most_recent = true
  region      = var.region
}

data "aws_ami" "example" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["myami-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}