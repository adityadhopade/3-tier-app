# webserver sg
resource "aws_security_group" "web_server" {
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

# appplication server sg
resource "aws_security_group" "application_server" {
  name        = "allow_application_traffic"
  description = "Allow application traffic"
  vpc_id      = aws_vpc.this.id
  dynamic "ingress" {
    for_each = var.inbound_rules_application
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      #   cidr_blocks = [aws_vpc.this.cidr_block]
      security_groups = [aws_security_group.web_server.id]
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

#bastion host sg

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

# application_lb sg

resource "aws_security_group" "lb_sg" {
  name        = "allow_lb"
  description = "Allow access to load balancers from the internet"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow access to load balancers from the internet"
    from_port   = 80
    to_port     = 80
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
    Name = "allow_access_to_lb_from_internet"
  }
}