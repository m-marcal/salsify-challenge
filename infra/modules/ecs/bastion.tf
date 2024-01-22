resource "aws_instance" "bastion_host" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 LTS
  instance_type = "t2.small"
  key_name      = var.ssh_key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.bastion_sg.id]
  subnet_id = var.pub_subnet_ids[0]

  tags = {
    Name = "${var.project_name}-bastion-host"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for Bastion Host"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-bastion_sg"
  }


  # Allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}