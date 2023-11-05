resource "aws_subnet" "restaurantPublicSubnet1" {
  vpc_id            = data.aws_vpc.restaurant-vpc.id
  cidr_block        = "10.0.16.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "restaurantPublicSubnet2" {
  vpc_id            = data.aws_vpc.restaurant-vpc.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "restaurantPublicSubnet3" {
  vpc_id            = data.aws_vpc.restaurant-vpc.id
  cidr_block        = "10.0.48.0/20"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
}