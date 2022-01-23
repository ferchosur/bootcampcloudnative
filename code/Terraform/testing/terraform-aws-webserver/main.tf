resource "aws_security_group" "allow_8080"{
    name = "allow_8080"
    description = "Allow 8080 inbound traffic"
    ingress {
        description = "8080 from VPC"
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "22 from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["181.58.39.102/32"]
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
    key_name = "fercho_2"
    vpc_security_group_ids = [aws_security_group.allow_8080.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "I made a Terraform Module!" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
        Name = var.servername
    }
}
