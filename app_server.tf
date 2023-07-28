module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.10.0"
  # Autoscaling group
  name = "application -asg"
  #add the instance name field
  instance_name = "application-server"

  min_size                  = 0 # what are the minimum number of instances needed
  max_size                  = 1 # what are the maximum number of instances needed
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  # vpc_zone_identifier       = ["subnet-1235678", "subnet-87654321"]
  # we need to replace it with the private subnet as we want to add the app_Server in private subnet from the webserver.tf
  vpc_zone_identifier = [element([for each_subnet in aws_subnet.private_subnet : each_subnet.id], 1)]

  #initial_lifecycle_hooks block is not required so we can remove that as well 
  #instance_referesh block is not required so we can remove that as well  but can keep it
  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  # Launch template
  launch_template_name        = "application-lt"
  launch_template_description = "Launch template example for application server"
  update_default_version      = true

  #need to replace ami id by the ami we desired it to be (amazon linux)

  #image_id          = "ami-ebd02392"
  image_id          = "ami-0f34c5ae932e6f0e4"
  instance_type     = "t3.micro"
  ebs_optimized     = true
  enable_monitoring = true
  # create a security group it is not by default added in the template we copied but we need to add 
  #add the security group of the application_server here
  security_groups = [aws_security_group.application_server.id]

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 10
        volume_type           = "gp2"
      }
      }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 30
        volume_type           = "gp2"
      }
    }
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  cpu_options = {
    core_count       = 1
    threads_per_core = 1
  }

  credit_specification = {
    cpu_credits = "standard"
  }

  instance_market_options = {
    market_type = "spot"
    spot_options = {
      block_duration_minutes = 60
    }
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
  }

  placement = {
    availability_zone = "us-west-1b"
  }

  tag_specifications = [
    {
      resource_type = "instance"
      tags          = { WhatAmI = "Instance" }
    },
    {
      resource_type = "volume"
      tags          = { WhatAmI = "Volume" }
    },
    {
      resource_type = "spot-instances-request"
      tags          = { WhatAmI = "SpotInstanceRequest" }
    }
  ]

  tags = {
    Environment = "dev"
    # Project     = "megasecret"
  }
}

