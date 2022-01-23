terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~>3.7"
      }
  }
}

provider "aws"{
    shared_credentials_file = "/home/kelebra/.aws/credentials"
    profile = "default"
    region = var.region
}

module "webserver"{
    source = "../../../../modules/ec2/"
    servername = var.servername
    size       = "t3.micro"
}