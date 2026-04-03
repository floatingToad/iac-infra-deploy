###############################################################################
# Root Variables — Set your values in terraform.tfvars, not here.
# These are the defaults. Override them by editing terraform.tfvars.
###############################################################################

# --- General ---

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Your name or team name (used in tags)"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

# --- Networking ---

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH (restrict to your IP for security)"
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

# --- Compute ---

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID (leave empty for latest Amazon Linux 2023)"
  type        = string
  default     = ""
}

variable "public_key" {
  description = "SSH public key for EC2 access (leave empty to skip key pair)"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "user_data" {
  description = "User data script for instance bootstrapping"
  type        = string
  default     = null
}

# --- Database ---

variable "db_engine" {
  description = "Database engine (mysql, postgres, mariadb)"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Database storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "db_multi_az" {
  description = "Enable Multi-AZ for RDS"
  type        = bool
  default     = false
}

variable "db_backup_retention_period" {
  description = "Backup retention in days"
  type        = number
  default     = 7
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

# --- S3 ---

variable "s3_bucket_suffix" {
  description = "Suffix appended to project name for the bucket name"
  type        = string
  default     = "bucket"
}

variable "s3_enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "s3_block_public_access" {
  description = "Block all public access to the S3 bucket"
  type        = bool
  default     = true
}

variable "s3_force_destroy" {
  description = "Allow Terraform to destroy the bucket even if it has objects"
  type        = bool
  default     = false
}

variable "s3_bucket_policy_principals" {
  description = "List of IAM role/user ARNs allowed to read from the S3 bucket"
  type        = list(string)
  default     = []
}

variable "s3_enable_lifecycle_rule" {
  description = "Enable lifecycle rule for S3 objects"
  type        = bool
  default     = false
}

variable "s3_lifecycle_glacier_transition_days" {
  description = "Days before transitioning S3 objects to Glacier"
  type        = number
  default     = 90
}

variable "s3_lifecycle_expiration_days" {
  description = "Days before expiring S3 objects"
  type        = number
  default     = 365
}
