# use ubuntu 20 AMI for EC2 instance
data "aws_ami" "ubuntu" {
    most_recent = true
filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/*22.04-amd64-server-*"]
    }
filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
owners = ["099720109477"] # Canonical
}
# provision to us-east-1 region
provider "aws" {
  region  = "us-east-1"
}
resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "ferchoitm"
tags = {
    Name = var.ec2_name
  }
}