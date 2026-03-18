resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  # Optional: only needed if you want SSH access
  key_name = var.key_name

  # Private instance for SSM-based access
  associate_public_ip_address = false

  # Required for SSM Session Manager
  iam_instance_profile = var.instance_profile_name

  tags = {
    Name = "${var.project_name}-web"
  }
}