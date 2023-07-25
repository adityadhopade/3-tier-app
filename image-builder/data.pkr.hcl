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