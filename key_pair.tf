resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxakVENVkZwnB36y//YCEnXvE+1CmbYWH9zkcB/rRT9UJwODn0RlzPMQ0kdaQrx7gdDhc5DqrYXGyMk93h6qJEbiPSYvUbPDAzqPa1vi3fv6j4xYJasGgKlreS/gNOtXqAMhXOUvu1OUTETIfqeWB8HbabH07m4kRXe+9IFtiDSoFduDaPjsE54UGlIyz285ic54T0MQgfhK7bwfesWFe3Paq6n7Vv45FNVJLmXP2uDj/FXkhIpetl/e1FVDGgl8CtOzEdsMEEuzaBNcL1KQxIBahBPfErZQuzybMewzFR3PvsGed4VzEKoaA7MTfTtRfAGxQtOUjjF4tOp4O+ScMqlz3uH99A28NubVXvu+vuCBLlfebpitPXhtblk5cyIR1x2k2CIvhSuU0oiZ9sgJRx/LnCx8dOLQ1xRbj+oClRx8s9DzvvqlRfwRnCNqFn5rO5LmqKSc7uFiZC49z8EuHOUQSrIp2lm86KZ1tdyD/jz2A8xXGsrWhJm9KxkdqyctM= aditya@aditya-Inspiron-3576"
}