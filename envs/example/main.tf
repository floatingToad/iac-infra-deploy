###############################################################################
# Root Configuration
#
# Deploy modules one at a time. Start with networking, then uncomment
# additional modules as needed. Run `terraform plan` before each apply.
###############################################################################

# ---------- Step 1: Deploy Networking First ----------
module "networking" {
  source = "../../modules/networking"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  allowed_ssh_cidr     = var.allowed_ssh_cidr
  allowed_rdp_cidr     = var.allowed_rdp_cidr
  enable_s3_endpoint   = var.enable_s3_endpoint

  common_tags = local.common_tags
}

# ---------- Step 2: Uncomment to Deploy EC2 Instances ----------
# Deploy networking first, then uncomment this block and run terraform apply.
# You can create multiple compute blocks — one for each role.
#
# Security groups:
#   - Linux/Nginx (web): use [module.networking.web_security_group_id]
#   - Windows (RDP):     use [module.networking.rdp_security_group_id]
#   - Both on same box:  use [module.networking.web_security_group_id, module.networking.rdp_security_group_id]
#
# Both Linux and Windows go in public subnets for internet access.
# Only RDS belongs in private subnets.

# --- Linux / Nginx instance (public subnet 1) ---
# module "compute" {
#   source = "../../modules/compute"
#
#   project_name        = var.project_name
#   instance_count      = var.instance_count
#   instance_type       = var.instance_type
#   ami_id              = var.ami_id
#   subnet_ids          = [module.networking.public_subnet_ids[0]]  # First public subnet
#   security_group_ids  = [module.networking.web_security_group_id]
#   public_key          = var.public_key
#   associate_public_ip = true
#   root_volume_size    = var.root_volume_size
#   user_data           = var.user_data
#
#   common_tags = local.common_tags
# }

# --- Windows instance (public subnet 2, separate from proxy) ---
# module "compute_windows" {
#   source = "../../modules/compute"
#
#   project_name        = var.project_name
#   instance_count      = 1
#   instance_type       = "t3.medium"
#   ami_id              = ""                                        # Set a Windows Server AMI ID
#   subnet_ids          = [module.networking.public_subnet_ids[1]]  # Second public subnet
#   security_group_ids  = [module.networking.rdp_security_group_id]
#   associate_public_ip = true
#   root_volume_size    = 30
#
#   common_tags = local.common_tags
# }

# ---------- Step 3: Uncomment to Deploy RDS Database ----------
# Deploy networking first, then uncomment this block and run terraform apply.

# module "database" {
#   source = "../../modules/database"
#
#   project_name  = var.project_name
#   vpc_id        = module.networking.vpc_id
#   subnet_ids    = module.networking.private_subnet_ids
#   allowed_cidr  = var.vpc_cidr
#
#   engine           = var.db_engine
#   engine_version   = var.db_engine_version
#   instance_class   = var.db_instance_class
#   allocated_storage = var.db_allocated_storage
#
#   db_name     = var.db_name
#   db_username = var.db_username
#   db_password = var.db_password
#   db_port     = var.db_port
#
#   multi_az               = var.db_multi_az
#   backup_retention_period = var.db_backup_retention_period
#   skip_final_snapshot    = var.db_skip_final_snapshot
#   deletion_protection    = var.db_deletion_protection
#
#   common_tags = local.common_tags
# }

# ---------- Step 4: Uncomment to Deploy S3 Buckets ----------
# Uncomment this block and run terraform apply to create your S3 bucket.
# The bucket stays PRIVATE. To allow your EC2 Nginx to read from it,
# pass the EC2 IAM role ARN in bucket_policy_principals.

# module "s3" {
#   source = "../../modules/s3"
#
#   project_name             = var.project_name
#   bucket_suffix            = var.s3_bucket_suffix
#   enable_versioning        = var.s3_enable_versioning
#   block_public_access      = var.s3_block_public_access
#   force_destroy            = var.s3_force_destroy
#   bucket_policy_principals = var.s3_bucket_policy_principals
#
#   enable_lifecycle_rule             = var.s3_enable_lifecycle_rule
#   lifecycle_glacier_transition_days = var.s3_lifecycle_glacier_transition_days
#   lifecycle_expiration_days         = var.s3_lifecycle_expiration_days
#
#   common_tags = local.common_tags
# }

# ---------- Local Values (do not modify unless adding custom tags) ----------
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
  }
}
