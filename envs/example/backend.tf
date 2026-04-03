###############################################################################
# Backend Configuration — State Storage
#
# By default, state is stored locally on your machine (gitignored).
#
# To use S3 remote state instead:
#   1. Create an S3 bucket and DynamoDB table in your AWS account
#   2. Uncomment the backend "s3" block below
#   3. Replace the bucket, key, and region with your values
#   4. Run: terraform init -migrate-state
###############################################################################

terraform {
  # Local backend is active by default — no configuration needed.

  # --- Uncomment below to switch to S3 remote state ---
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "envs/your-name/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}
