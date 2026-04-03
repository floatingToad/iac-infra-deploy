###############################################################################
# Root Outputs — Uncomment each section when using its module
###############################################################################

# --- Networking ---

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = module.networking.vpc_cidr
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnet_ids
}

output "web_security_group_id" {
  description = "Web security group ID"
  value       = module.networking.web_security_group_id
}

output "rdp_security_group_id" {
  description = "RDP security group ID"
  value       = module.networking.rdp_security_group_id
}

# --- Compute (Linux): Uncomment after enabling compute module in main.tf ---

# output "instance_public_ips" {
#   description = "Linux EC2 public IP addresses"
#   value       = module.compute.public_ips
# }

# output "instance_private_ips" {
#   description = "Linux EC2 private IP addresses"
#   value       = module.compute.private_ips
# }

# --- Compute (Windows): Uncomment after enabling compute_windows module ---

# output "windows_public_ips" {
#   description = "Windows EC2 public IP addresses"
#   value       = module.compute_windows.public_ips
# }

# --- Database: Uncomment these after enabling the database module in main.tf ---

# output "db_endpoint" {
#   description = "RDS connection endpoint"
#   value       = module.database.db_endpoint
# }

# output "db_address" {
#   description = "RDS hostname"
#   value       = module.database.db_address
# }

# --- S3: Uncomment these after enabling the s3 module in main.tf ---

# output "s3_bucket_id" {
#   description = "S3 bucket ID"
#   value       = module.s3.bucket_id
# }

# output "s3_bucket_arn" {
#   description = "S3 bucket ARN"
#   value       = module.s3.bucket_arn
# }
