terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.55"
    }
  }

   backend "s3" {
    bucket = "terraform.ngnix.moveo"
    key    = "tfstate.json"
    region = "eu-north-1"
  
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region = var.region  
}


module vpc{
    source = "./module/vpc"
}

#                                                                   ^
#------------------------------------------------------------------VPC 
#------------------------------------------------------------------EC2
#                                                                   v

module  ec2{
    source  =   "./module/ec2"
    private_key= var.private_key
    instance_type= var.instance_type
    region= var.region
    private_subnet= module.vpc.private_subnet[0]
    public_subnet= module.vpc.public_subnet[0]
    vpc_id= module.vpc.vpc_id
    alb_sg  = module.alb.sg
    private_key_name  = var.private_key_name
}

#                                                                   ^
#------------------------------------------------------------------EC2 
#------------------------------------------------------------------ALB
#                                                                   v

module "alb"{
    source  =  "./module/alb"
    public_subnets = module.vpc.public_subnet
    vpc_id   = module.vpc.vpc_id
    instance_id = module.ec2.instance_id
    record_name = "ngnix.bargutman.click"
    certificate_arn = var.certificate_arn
}