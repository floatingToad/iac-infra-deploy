###############################################################################
# Database — RDS Instance
###############################################################################

# ---------- DB Subnet Group ----------
resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

# ---------- DB Security Group ----------
resource "aws_security_group" "db" {
  name        = "${var.project_name}-db-sg"
  description = "Allow database access from application tier"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "db_access" {
  security_group_id = aws_security_group.db.id
  description       = "Database port access from allowed CIDR"
  from_port         = var.db_port
  to_port           = var.db_port
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_cidr

  tags = { Name = "db-ingress" }
}

resource "aws_vpc_security_group_egress_rule" "db_egress" {
  security_group_id = aws_security_group.db.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = { Name = "db-egress" }
}

# ---------- RDS Instance ----------
resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-db"

  # Engine
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  parameter_group_name = var.parameter_group_name

  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  # Credentials
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  # Networking
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  port                   = var.db_port
  multi_az               = var.multi_az

  # Maintenance & Backup
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project_name}-db-final-snapshot"
  deletion_protection     = var.deletion_protection

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-db"
  })
}
