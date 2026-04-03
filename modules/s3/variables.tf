###############################################################################
# S3 Module — Input Variables
###############################################################################

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "bucket_name" {
  description = "Explicit bucket name (overrides auto-generated name)"
  type        = string
  default     = ""
}

variable "bucket_suffix" {
  description = "Suffix appended to project_name for the bucket name"
  type        = string
  default     = "bucket"
}

# --- Versioning ---

variable "enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

# --- Encryption ---

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "KMS key ARN for encryption (only used when sse_algorithm is aws:kms)"
  type        = string
  default     = null
}

# --- Access ---

variable "block_public_access" {
  description = "Block all public access to the bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow Terraform to destroy the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "bucket_policy_principals" {
  description = "List of IAM ARNs allowed to read from this bucket (leave empty to skip bucket policy)"
  type        = list(string)
  default     = []
}

# --- Lifecycle ---

variable "enable_lifecycle_rule" {
  description = "Enable lifecycle rule for object transition and expiration"
  type        = bool
  default     = false
}

variable "lifecycle_glacier_transition_days" {
  description = "Days before transitioning objects to Glacier"
  type        = number
  default     = 90
}

variable "lifecycle_expiration_days" {
  description = "Days before expiring objects"
  type        = number
  default     = 365
}

variable "common_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
