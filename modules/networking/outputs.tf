###############################################################################
# Networking Module — Outputs
###############################################################################

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway (empty if disabled)"
  value       = var.enable_nat_gateway ? aws_nat_gateway.this[0].id : null
}

output "web_security_group_id" {
  description = "ID of the web security group (HTTP/HTTPS/SSH)"
  value       = aws_security_group.web.id
}

output "rdp_security_group_id" {
  description = "ID of the RDP security group (Windows remote desktop)"
  value       = aws_security_group.rdp.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "s3_endpoint_id" {
  description = "ID of the S3 VPC Gateway Endpoint (null if disabled)"
  value       = var.enable_s3_endpoint ? aws_vpc_endpoint.s3[0].id : null
}
