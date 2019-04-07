variable "common" {
  default = {
    default.region        = "ap-northeast-1"
    default.project       = "yuito-eks"
    default.account       = "417025923863"
    default.cluster_name  = "yuito-eks-cluster-tera"
    default.vpc-cider     = "192.168.0.0/16"
    default.public-a      = "192.168.64.0/18"
    default.public-c      = "192.168.128.0/18"
    default.public-d      = "192.168.192.0/18"
  }
}
