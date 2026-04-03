###############################################################################
# Networking Module — Input Variables
###############################################################################

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to deploy into"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnet internet access"
  type        = bool
  default     = true
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into instances (restrict to your IP)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_rdp_cidr" {
  description = "CIDR block allowed to RDP into Windows instances (restrict to your IP)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "enable_s3_endpoint" {
  description = "Create an S3 VPC Gateway Endpoint (free, keeps S3 traffic inside AWS)"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
