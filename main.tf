module "vpc" {
  source = "./module/vpc"
}
module "eks" {
  source            = "./module/eks"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
}
terraform {
   backend "s3" {
        bucket = "s3-statefile" 
        key    = "terraform.tfstate"
        region = "us-east-2"
  }
}

#resource "helm_release" "prometheus" {
  #name             = "prometheus"
  #chart            = "kube-prometheus-stack"
  #repository       = "prometheus-community"
  #namespace        = "monitoring"
  #version          = "61.3.1"
  #create_namespace = true
  #  values = [
  #  "${file("./HELM-CHART/Prometheus/prometheus-values.yaml")}"
 # ]

#}


