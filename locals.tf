locals {
  vpc_name_local = "${var.vpc_name}-lwplabs"
  web_server     = "${var.web_server_name}-terraform"
  bastion_host   = "${var.vpc_name}-bastion-host"
}