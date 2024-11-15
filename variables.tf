variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
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
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_name" {
  type    = list(string)
  default = ["Network-Private-Subnet-1", "Network-Private-Subnet-2"]
}

variable "public_subnets_cidr" {
  description = "Public subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
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
  type        = list(string)
  default     = ["Network-Public-RT-1", "Network-Public-RT-2"]
}

variable "private_rt_name" {
  description = "Name of the Private Route Table"
  type        = list(string)
  default     = ["Network-Private-RT-1", "Network-Private-RT-2"]
}
