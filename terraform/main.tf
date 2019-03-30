variable "region" {
  default = "ap-northeast-1"
}

provider "aws" {
  region = "${var.region}"
}

# resource "aws_vpc" "aws-yuito-sandbox-vpc" {
#   cidr_block           = "192.168.0.0/16"
#   enable_dns_support   = true
#   enable_dns_hostnames = true

#   tags {
#     Name = "aws-yuito-sandbox-vpc"
#   }
# }

# resource "aws_internet_gateway" "aws-yuito-sandbox-internet-gateway" {
#   vpc_id = "${aws_vpc.aws-yuito-sandbox-vpc.id}"

#   tags = {
#     Name = "aws-yuito-sandbox-internet-gateway"
#   }
# }

# resource "aws_route_table" "aws-yuito-sandbox-route-table" {
#   vpc_id = "${aws_vpc.aws-yuito-sandbox-vpc.id}"

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "${aws_internet_gateway.aws-yuito-sandbox-internet-gateway.id}"
#   }

#   tags = {
#     Name    = "aws-yuito-sandbox-route-table"
#     Network = "Public"
#   }
# }

# resource "aws_subnet" "aws-yuito-sandbox-subnet1" {
#   vpc_id            = "${aws_vpc.aws-yuito-sandbox-vpc.id}"
#   cidr_block        = "192.168.64.0/18"
#   availability_zone = "ap-northeast-1a"

#   tags = {
#     Name = "aws-yuito-sandbox-subnet1"
#   }
# }

# resource "aws_subnet" "aws-yuito-sandbox-subnet2" {
#   vpc_id            = "${aws_vpc.aws-yuito-sandbox-vpc.id}"
#   cidr_block        = "192.168.128.0/18"
#   availability_zone = "ap-northeast-1d"

#   tags = {
#     Name = "aws-yuito-sandbox-subnet2"
#   }
# }

# resource "aws_subnet" "aws-yuito-sandbox-subnet3" {
#   vpc_id            = "${aws_vpc.aws-yuito-sandbox-vpc.id}"
#   cidr_block        = "192.168.192.0/18"
#   availability_zone = "ap-northeast-1c"

#   tags = {
#     Name = "aws-yuito-sandbox-subnet3"
#   }
# }

# resource "aws_route_table_association" "aws-yuito-sandbox-route-table-association-1" {
#   subnet_id      = "${aws_subnet.aws-yuito-sandbox-subnet1.id}"
#   route_table_id = "${aws_route_table.aws-yuito-sandbox-route-table.id}"
# }

# resource "aws_route_table_association" "aws-yuito-sandbox-route-table-association-2" {
#   subnet_id      = "${aws_subnet.aws-yuito-sandbox-subnet2.id}"
#   route_table_id = "${aws_route_table.aws-yuito-sandbox-route-table.id}"
# }

# resource "aws_route_table_association" "aws-yuito-sandbox-route-table-association-3" {
#   subnet_id      = "${aws_subnet.aws-yuito-sandbox-subnet3.id}"
#   route_table_id = "${aws_route_table.aws-yuito-sandbox-route-table.id}"
# }

# resource "aws_security_group" "aws-yuito-sandbox-security-group" {
#   vpc_id      = "${aws_vpc.aws-yuito-sandbox-vpc.id}"
#   description = "Cluster communication with worker nodes"
# }

# resource "aws_eks_cluster" "aws-yuito-sandbox-eks-cluster" {
#   name     = "aws-yuito-sandbox-eks-cluster"
#   role_arn = "arn:aws:iam::975293561412:role/aws-yuito-sandbox-eks-service-role"

#   vpc_config {
#     subnet_ids = [
#       "${aws_subnet.aws-yuito-sandbox-subnet1.id}",
#       "${aws_subnet.aws-yuito-sandbox-subnet2.id}",
#       "${aws_subnet.aws-yuito-sandbox-subnet3.id}",
#     ]
#   }
# }
