terraform {
  required_version = "~>1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "terraform"
  assume_role {
    role_arn     = "arn:aws:iam::972348856143:role/stsassumerole"
    session_name = "stsrole"
  }
}