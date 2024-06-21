provider "aws" {
  region = "us-east-2"
}

# Security Group for EC2 Instance
resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip] # Replace with your IP address
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for RDS Instance
resource "aws_security_group" "rds_sg" {
  name        = "allow_rds_access"
  description = "Allow access to RDS"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "linux_ec2" {
  ami           = "ami-033fabdd332044f06" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "LinuxEC2"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y docker
                service docker start
                usermod -a -G docker ec2-user
                docker run -d -p 80:80 --name mycontainer \
                  -e POSTGRES_HOST=${aws_db_instance.postgres.endpoint} \
                  -e POSTGRES_DB=mydb \
                  -e POSTGRES_USER=admin \
                  -e POSTGRES_PASSWORD=password \
                  djha736/ec2-rds:latest
              EOF
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  instance_class       = "db.t2.micro"
  db_name              = "post-rds-db"
  username             = "admin"
  password             = "Hari-test"
  parameter_group_name = "default.postgres10"
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
