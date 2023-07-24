resource "aws_instance" "bastion" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  key_name      = "new-ultimate-cicd"
  subnet_id     = element([for each_subnet in aws_subnet.public_subnet : each_subnet.id], 1)

  # provisioner "local-exec" {
  #   command = "scp -o StrictHostKeyChecking=no -i  ~/Downloads/new-ultimate-cicd.pem ~/Downloads/new-ultimate-cicd.pem ec2-user@${self.public_ip}:~"
  # }


  tags = {
    Name = local.bastion_host
  }

  vpc_security_group_ids = [aws_security_group.bastion_host.id]
  user_data              = file("${path.module}/user_data.sh")
}

resource "aws_security_group" "bastion_host" {
  name        = "allow_bastion_host"
  description = "Allow ssh into the private subnet resources using this"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow the ssh traffic to private subnet bastion host from private subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_bastion_host_security"
  }
}
