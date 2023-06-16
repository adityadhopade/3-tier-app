output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  # This will perform the for loop on the list of public subnets and each_subnet will define the itteration and in each it will traverse the id of each subnet in each itteration
  value = [for each_subnet in aws_subnet.public_subnet : each_subnet.id]
}

output "private_subnet_ids" {
  # This will perform the for loop on the list of public subnets and each_subnet will define the itteration and in each it will traverse the id of each subnet in each itteration
  value = [for each_subnet in aws_subnet.private_subnet : each_subnet.id]
}
