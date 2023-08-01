variable "cidr_for_vpc" {
  description = "the cidr range for VPC"
  type        = string
}

variable "tenancy" {
  description = "The tenancy value to provide to vpc for 3 tier app"
  type        = string
  default     = "default"
}

variable "dns_hostnames_enabled" {
  description = "A boolean flag to enable or disable the DNS support in VPC"
  type        = bool
  default     = true
}

variable "dns_support_enabled" {
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
  default     = true

}

variable "vpc_name" {
  description = "Name of the vpc"
  default     = "vpc-3tier"
}

variable "web_server_name" {
  type        = string
  description = "name of the instance created as web server"

}

variable "inbound_rules_web" {
  description = "ingress rules for security group of web server"
  type = list(object({
    port        = number
    description = string
    protocol    = string
  }))

  default = [{
    port        = 22
    description = "This is for the ssh connection here"
    protocol    = "tcp"
    },
    {
      port        = 80
      description = "This is for the webshoting connection"
      protocol    = "tcp"
  }]
}

#add the variable for inbound_rules_application(Application server)

variable "inbound_rules_application" {
  description = "ingress rules for security group of application server"
  type = list(object({
    port        = number
    description = string
    protocol    = string
  }))

  #As it would be running the Tomcat Application we will be needing port 8080 in inbound rules and we would be removing ssh [port 22] for that we will add manually its one of the usecase
  default = [{
    port        = 8080
    description = "This is for the application hosting"
    protocol    = "tcp"
  }]
}


variable "key_name" {
  type        = string
  description = "key pair name"
  default     = "deployer name"
}

# added to add the key file in it
variable "mykey" {
  type = string
}

variable "db_user_name" {
  description = "Username to connect with db"
  type        = string
  #to hide the sensitive info
  sensitive = true
}

variable "db_password" {
  description = "Password to connect with db"
  type        = string
  #to hide the sensitive info
  sensitive = true
}

