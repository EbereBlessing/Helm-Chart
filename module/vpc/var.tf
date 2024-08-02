variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  default = "EKS Cluster Project"
  type = string
}

variable "vpc_name" {
  type        = string
  default = "EKS vpc"
}

variable "route_table_name" {
  type        = string
  default     = "EKS main"
  description = "Route table description"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block range for vpc"
}
variable "ec2_ami" {
  type = string
  default = "ami-0862be96e41dcbf74"  # Replace with a valid AMI for Jenkins on Amazon Linux 2
}

variable "instance_type" {
  type = string
  default = "t3.medium"  # Choose an appropriate instance type
}

variable "ssh_key_name" {
  type = string
  default = "k8s_key"  # Replace with your existing SSH key name
}


