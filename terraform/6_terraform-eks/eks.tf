module "eks" {
  source = "terraform-aws-modules/eks/aws"
   version = "~> 21.0"
#cluster info
  name               = local.name
  kubernetes_version = "1.33"
  endpoint_public_access = true
   addons={
    vpc-cni = {
        most-recent = true
    }
    kube-proxy = {
        most-recent = true
    }
    coredns = {
        most-recent = true
    }
  }
  # control plane network
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets
 # managing node in cluster

  eks_managed_node_groups = {
    ak47 = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t3.small"]
      capacity_type = "SPOT"
      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }
  

  tags = {
    Terraform = "true"
    Environment = local.env
  }
}
