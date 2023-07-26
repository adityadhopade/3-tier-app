packer {
  required_plugins {
    amazon = {
      version = ">= 1.4.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
