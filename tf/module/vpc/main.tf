module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "5.8.1"

    name = "Nginx-YO"
    cidr = "10.0.0.0/16"
    map_public_ip_on_launch = true

    azs             = ["eu-north-1a","eu-north-1b"]
    private_subnets  = ["10.0.1.0/24"]
    public_subnets  = ["10.0.2.0/24", "10.0.3.0/24"]
    
    enable_nat_gateway = true
    single_nat_gateway  = true
}




