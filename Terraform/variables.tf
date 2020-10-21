variable "aws_region" {
  default = "us-east-1"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "key" {
  default = "my-keypair"
}

variable "public_key" {
  default = "my-keypair.pub"
}

variable kubernetes_cluster_dns {
  default = "10.31.0.1"
}

variable "ami" {
  default = "ami-0947d2ba12ee1ff75"
}
### VARIABLES BELOW MUST NOT BE CHANGED ###

variable vpc_cidr {
  default = "10.43.0.0/16"
}

variable kubernetes_pod_cidr {
  default = "10.200.0.0/16"
}