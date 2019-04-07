// VPC
resource "aws_vpc" "yuito-eks-vpc-tera" {
  cidr_block           = "${lookup(var.common, "${terraform.env}.vpc-cider")}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-vpc-tera"
    "kubernetes.io/cluster/yuito-eks-cluster-tera" = "shared"
  }
}

// Subnet
resource "aws_subnet" "yuito-eks-public-a-tera" {
  vpc_id            = "${aws_vpc.yuito-eks-vpc-tera.id}"
  cidr_block        = "${lookup(var.common, "${terraform.env}.public-a")}"
  availability_zone = "${lookup(var.common, "${terraform.env}.region")}a"

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-yuito-eks-public-a-tera"
    "kubernetes.io/cluster/yuito-eks-cluster-tera" = "shared"
    "kubernetes.io/role/alb-ingress" = 1
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "yuito-eks-public-c-tera" {
  vpc_id            = "${aws_vpc.yuito-eks-vpc-tera.id}"
  cidr_block        = "${lookup(var.common, "${terraform.env}.public-c")}"
  availability_zone = "${lookup(var.common, "${terraform.env}.region")}c"

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-yuito-eks-public-c-tera"
    "kubernetes.io/cluster/yuito-eks-cluster-tera" = "shared"
    "kubernetes.io/role/alb-ingress" = 1
    "kubernetes.io/role/elb" = 1
  }
}

resource "aws_subnet" "yuito-eks-public-d-tera" {
  vpc_id            = "${aws_vpc.yuito-eks-vpc-tera.id}"
  cidr_block        = "${lookup(var.common, "${terraform.env}.public-d")}"
  availability_zone = "${lookup(var.common, "${terraform.env}.region")}d"

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-yuito-eks-public-d-tera"
    "kubernetes.io/cluster/yuito-eks-cluster-tera" = "shared"
    "kubernetes.io/role/alb-ingress" = 1
    "kubernetes.io/role/elb" = 1
  }
}

// Internet Gateway
resource "aws_internet_gateway" "yuito-eks-vpc-igw-tera" {
  vpc_id = "${aws_vpc.yuito-eks-vpc-tera.id}"

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-igw-tera"
  }
}

// Route Table
resource "aws_route_table" "yuito-eks-public-route-table-tera" {
  vpc_id = "${aws_vpc.yuito-eks-vpc-tera.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.yuito-eks-vpc-igw-tera.id}"
  }

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}-vpc-igw-tera"
  }
}
