variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "Network-VPC"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "private_subnets_cidr" {
  description = "Private subnets"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "private_subnets_name" {
  type    = list(string)
  default = ["Network-Private-Subnet-1", "Network-Private-Subnet-2"]
}

variable "public_subnets_cidr" {
  description = "Public subnets"
  type        = list(string)
  default     = ["172.16.3.0/24", "172.16.4.0/24"]
}

variable "public_subnets_name" {
  type    = list(string)
  default = ["Network-Public-Subnet-1", "Network-Public-Subnet-2"]
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
  default     = "Network-IGW"
}

variable "public_rt_name" {
  description = "Name of the Public Route Table"
  type        = string
  default     = "Network-Public-RT"
}

variable "private_rt_name" {
  description = "Name of the Private Route Table"
  type        = string
  default     = "Network-Private-RT"
}
