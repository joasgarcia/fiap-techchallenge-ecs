output "aws_subnets" {
  value = {
    subnet1 = aws_subnet.restaurantPublicSubnet1.id
    subnet2 = aws_subnet.restaurantPublicSubnet2.id
    subnet3 = aws_subnet.restaurantPublicSubnet3.id
  }
}