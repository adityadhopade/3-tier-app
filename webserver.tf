resource "aws_instance" "this" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  key_name      = "ultimate-cicd-pipeline"
  subnet_id     = element([for each_subnet in aws_subnet.private_subnet : each_subnet.id], 1)

  tags = {
    Name = local.web_server
  }

  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = file("${path.module}/user_data.sh")
}

resource "aws_security_group" "this" {
  name        = "allow_webserver"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.this.id
  dynamic "ingress" {
    for_each = var.inbound_rules_web
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [aws_vpc.this.cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_webserver"
  }
}