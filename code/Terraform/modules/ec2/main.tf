resource "aws_security_group" "Allow_8080"{
    name = "allow_8080"
    description = "Allow 8080 inbound traffic"

    ingress {
        description = "8080 from VPC"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_ami" "ubuntu2"{
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web"{
    ami = data.aws_ami.ubuntu2.id
    instance_type = var.size

    user_data = <<-EOF
                #!/bin/bash
                echo "I made a Terraform Module!" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
        Name = var.servername
    }
}