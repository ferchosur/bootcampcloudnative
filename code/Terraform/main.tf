terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "3.7"
      }
  }
}

provider "aws"{
    region = "us-east-1"
}

module "webserver"{
    source = "./module/ec2"
    servername = "terraformdemo"
    sice       = "t3.micro"
}