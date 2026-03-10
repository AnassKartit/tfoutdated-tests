terraform {
  source = "tfr:///terraform-aws-modules/eks/aws?version=19.0.0"
}

inputs = {
  cluster_name                   = "production-cluster"
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true

  vpc_id     = "vpc-12345"
  subnet_ids = ["subnet-1", "subnet-2"]

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
  }

  tags = { Environment = "production" }
}
