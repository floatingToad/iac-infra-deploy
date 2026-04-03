###############################################################################
# Compute Module — EC2 Instances
###############################################################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "this" {
  count = var.public_key != "" ? 1 : 0

  key_name   = "${var.project_name}-key"
  public_key = var.public_key

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-key"
  })
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.public_key != "" ? aws_key_pair.this[0].key_name : null

  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  user_data = var.user_data

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-instance-${count.index + 1}"
  })
}
