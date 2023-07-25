variable region {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable instance_type {
  description = "instance type to launching AMI"
  type        = string
  default     = "t3.micro"
}

variable ssh_user_name {
  description = "ssh user name for instance"
  type        = string
  default     = "ec2-user"
}

variable app_name {
  description = "app name for web server image"
  type        = string
  default     = "web-server-image"
}
