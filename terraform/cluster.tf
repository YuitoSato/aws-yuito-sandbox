locals {
  userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint "${aws_eks_cluster.eks-cluster.endpoint}" --b64-cluster-ca "${aws_eks_cluster.eks-cluster.certificate_authority.0.data}" "${aws_eks_cluster.eks-cluster.name}"
USERDATA
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = "${lookup(var.common, "${terraform.env}.cluster_name")}"
  role_arn = "${aws_iam_role.yuito-eks-cluster-master-role-tera.arn}"
  version  = "1.11"

  vpc_config {
    security_group_ids = ["${aws_security_group.yuito-eks-cluster-master-sg-tera.id}"]

    subnet_ids = [
      "${aws_subnet.yuito-eks-public-a-tera.id}",
      "${aws_subnet.yuito-eks-public-c-tera.id}",
      "${aws_subnet.yuito-eks-public-d-tera.id}"

    ]

    endpoint_private_access=true
    endpoint_public_access=true
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-cluster-policy",
    "aws_iam_role_policy_attachment.eks-service-policy",
  ]
}


resource "aws_launch_configuration" "yuito-eks-lc-tera" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.yuito-eks-cluster-node-role-profile-tera.id}"
  image_id                    = "ami-07fdc9272ce5b0ce5"
  instance_type               = "t3.micro"
  name_prefix                 = "eks-node"
  key_name                    = "yuito-key"
  enable_monitoring           = false

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
  }

  security_groups  = ["${aws_security_group.yuito-eks-cluster-nodes-sg-tera.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "yuito-eks-asg-tera" {
  name                 = "yuito-eks-autoscale-group"
  desired_capacity     = "3"
  launch_configuration = "${aws_launch_configuration.yuito-eks-lc-tera.id}"
  max_size             = "3"
  min_size             = "3"

  tag {
    key                 = "kubernetes.io/cluster/${lookup(var.common, "${terraform.env}.cluster_name")}"
    value               = "owned"
    propagate_at_launch = true
  }

  vpc_zone_identifier = [
    "${aws_subnet.yuito-eks-public-a-tera.id}",
    "${aws_subnet.yuito-eks-public-c-tera.id}",
    "${aws_subnet.yuito-eks-public-d-tera.id}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}
