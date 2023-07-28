resource "aws_instance" "bastion" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = element([for each_subnet in aws_subnet.public_subnet : each_subnet.id], 1)

  # provisioner "local-exec" {
  #   command = "scp -o StrictHostKeyChecking=no -i  ~/Downloads/new-ultimate-cicd.pem ~/Downloads/new-ultimate-cicd.pem ec2-user@${self.public_ip}:~"
  # }


  tags = {
    Name = local.bastion_host
  }

  vpc_security_group_ids = [aws_security_group.bastion_host.id]
  # user_data              = file("${path.module}/user_data.sh")
}
