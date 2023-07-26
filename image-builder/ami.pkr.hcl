locals {
  image_name = "${var.app_name}-new-packer-lwplabs"
}


source "amazon-ebs" "this" {
  assume_role {
    role_arn     = "arn:aws:iam::869190274350:role/stsassumerole"
    session_name = "packer-session"
  }
  region        = var.region
  source_ami    = data.amazon-ami.this.id
  instance_type = var.instance_type
  ssh_username  = var.ssh_user_name
  ami_name      = local.image_name
}

build {
  sources = [
    "source.amazon-ebs.this"
  ]

  provisioner shell {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo echo '<h1>Welcome to Terraform class at learnwithproject</h1>'|sudo tee /var/www/html/index.html"
    ]
  }
}
