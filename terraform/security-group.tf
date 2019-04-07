resource "aws_security_group" "yuito-eks-cluster-master-sg-tera" {
  name        = "yuito-eks-cluster-master-sg-tera"
  description = "EKS cluster master security group"
  vpc_id = "${aws_vpc.yuito-eks-vpc-tera.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}"
  }

}

resource "aws_security_group" "yuito-eks-cluster-nodes-sg-tera" {
  name        = "yuito-eks-cluster-nodes-sg-tera"
  description = "EKS cluster nodes security group"
  vpc_id = "${aws_vpc.yuito-eks-vpc-tera.id}"

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"

    security_groups = ["${aws_security_group.yuito-eks-cluster-master-sg-tera.id}"]
  }

  ingress {
    description = "Allow cluster master to access cluster nodes"
    from_port   = 1025
    to_port     = 65535
    protocol    = "udp"

    security_groups = ["${aws_security_group.yuito-eks-cluster-master-sg-tera.id}"]
  }

  ingress {
    description = "Allow inter pods communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name      = "${lookup(var.common, "${terraform.env}.project")}"
  }
}
