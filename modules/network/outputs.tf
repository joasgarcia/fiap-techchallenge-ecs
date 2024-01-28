#output "aws_subnets" {
#  value = {
#    subnet1 = aws_subnet.restaurantPublicSubnet1.id
#    subnet2 = aws_subnet.restaurantPublicSubnet2.id
#    subnet3 = aws_subnet.restaurantPublicSubnet3.id
#  }
#}

output "aws_subnets" {
  value = {
    subnet1 = "subnet-0502770f7e2901bb7"
    subnet2 = "subnet-0ea4edbbcf6ed6739"
    subnet3 = "subnet-0035e7eff69774017"
  }
}