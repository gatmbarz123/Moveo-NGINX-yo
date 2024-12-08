output "private_subnet" {
  value = module.vpc.private_subnets
}

output "public_subnet" {
  value = module.vpc.public_subnets
}

output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC"
}