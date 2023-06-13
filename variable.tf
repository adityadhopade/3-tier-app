variable "cidr_for_vpc" {
  description = "the cidr range for VPC"
  type        = string
}

#If we want to input the value from the user then we do not need to add the "default"

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