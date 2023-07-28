resource "aws_instance" "web" {
  ami           = data.aws_ami.this.id
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = element([for each_subnet in aws_subnet.private_subnet : each_subnet.id], 1)

  tags = {
    Name = local.web_server
  }

  vpc_security_group_ids = [aws_security_group.web_server.id]
  # user_data              = file("${path.module}/user_data.sh")
}