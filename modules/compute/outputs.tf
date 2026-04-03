###############################################################################
# Compute Module — Outputs
###############################################################################

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.this[*].id
}

output "public_ips" {
  description = "List of public IP addresses (empty if no public IP)"
  value       = aws_instance.this[*].public_ip
}

output "private_ips" {
  description = "List of private IP addresses"
  value       = aws_instance.this[*].private_ip
}

output "key_pair_name" {
  description = "Name of the created key pair (null if none)"
  value       = var.public_key != "" ? aws_key_pair.this[0].key_name : null
}
