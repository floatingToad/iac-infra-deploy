###############################################################################
# Compute Module — Input Variables
###############################################################################

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID to use (leave empty for latest Amazon Linux 2023)"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instances into (round-robin)"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
}

variable "public_key" {
  description = "SSH public key material for key pair (leave empty to skip)"
  type        = string
  default     = ""
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20
}

variable "user_data" {
  description = "User data script for instance bootstrapping"
  type        = string
  default     = null
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
