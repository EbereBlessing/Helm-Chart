variable "eks_cluster_name" {
  description = "EKS Project"
  type = string
  default = "EKS_project"
}
variable "cluster_name" {
   description = "cluster SG"
   type = string
   default = "EKS_project"
}

variable "nodes_name" {
    description = "node SG"
    type = string
    default = "EKS_nodegroup"
}
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}
variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Defaults to AL2_x86_64. Valid values: AL2_x86_64, AL2_x86_64_GPU."
  type = string 
  default = "AL2_x86_64"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes. Defaults to 20."
  type = number
  default = 20
}

variable "instance_types" {
  type = list(string)
  default = ["t3.medium"]
  description = "Set of instance types associated with the EKS Node Group."
}

variable "private_desired_size" {
  description = "Desired number of worker nodes in private subnet"
  default = 1
  type = number
}

variable "private_max_size" {
  description = "Maximum number of worker nodes in private subnet."
  default = 1
  type = number
}

variable "private_min_size" {
  description = "Minimum number of worker nodes in private subnet."
  default = 1
  type = number
}

variable "public_desired_size" {
  description = "Desired number of worker nodes in public subnet"
  default = 1
  type = number
}

variable "public_max_size" {
  description = "Maximum number of worker nodes in public subnet."
  default = 1
  type = number
}

variable "public_min_size" {
  description = "Minimum number of worker nodes in public subnet."
  default = 1
  type = number
}
