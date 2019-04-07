resource "aws_iam_role" "yuito-eks-cluster-master-role-tera" {
  name = "yuito-eks-cluster-master-role-tera"
  assume_role_policy = "${data.aws_iam_policy_document.yuito-eks-cluster-master-role-tera-policy.json}"
}

data "aws_iam_policy_document" "yuito-eks-cluster-master-role-tera-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.yuito-eks-cluster-master-role-tera.name}"
}

resource "aws_iam_role_policy_attachment" "eks-service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.yuito-eks-cluster-master-role-tera.name}"
}

data "aws_iam_policy_document" "ops-user-yuito-eks-cluster-master-role-tera-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "AWS"
      identifiers = ["arn:aws:iam::417025923863:root"]
    }
  }
}

resource "aws_iam_role" "ops-user-yuito-eks-cluster-master-role-tera" {
  name =  "ops-user-yuito-eks-cluster-master-role-tera"
  assume_role_policy = "${data.aws_iam_policy_document.ops-user-yuito-eks-cluster-master-role-tera-policy.json}"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-to-ops-user-yuito-eks-cluster-master-role-tera" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.ops-user-yuito-eks-cluster-master-role-tera.name}"
}

resource "aws_iam_role_policy_attachment" "eks-service-policy-to-ops-user-yuito-eks-cluster-master-role-tera" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.ops-user-yuito-eks-cluster-master-role-tera.name}"
}

data "aws_iam_policy_document" "describe-cluster-policy-document" {
  statement {
    effect = "Allow"
    actions = ["eks:DescribeCluster"]
    resources = ["arn:aws:eks:ap-northeast-1:417025923863:cluster/${lookup(var.common, "${terraform.env}.cluster_name")}"]
  }
}

resource "aws_iam_policy" "describe-cluster-policy" {
  name        = "describe-cluster"
  description = "describe cluster policy"
  policy      = "${data.aws_iam_policy_document.describe-cluster-policy-document.json}"
}

resource "aws_iam_role_policy_attachment" "describe-cluster-policy-to-ops-user-yuito-eks-cluster-master-role-tera" {
  policy_arn = "${aws_iam_policy.describe-cluster-policy.arn}"
  role       = "${aws_iam_role.ops-user-yuito-eks-cluster-master-role-tera.name}"
}

resource "aws_iam_instance_profile" "yuito-eks-cluster-node-role-profile-tera" {
  name = "yuito-eks-cluster-node-role-profile-tera"
  role = "${aws_iam_role.yuito-eks-cluster-node-role-tera.name}"
}

resource "aws_iam_role" "yuito-eks-cluster-node-role-tera" {
  name =  "yuito-eks-cluster-node-role-tera"
  assume_role_policy = "${data.aws_iam_policy_document.yuito-eks-cluster-node-role-tera-policy.json}"
}

data "aws_iam_policy_document" "yuito-eks-cluster-node-role-tera-policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.yuito-eks-cluster-node-role-tera.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.yuito-eks-cluster-node-role-tera.name}"
}

resource "aws_iam_role_policy_attachment" "ec2-container-registry-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.yuito-eks-cluster-node-role-tera.name}"
}

resource "aws_iam_role_policy_attachment" "ec2-role-for-ssm" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = "${aws_iam_role.yuito-eks-cluster-node-role-tera.name}"
}
