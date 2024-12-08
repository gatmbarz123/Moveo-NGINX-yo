variable region {
  type        = string
  description     = "aws-region"
}

variable key_pairs{
    type        = string
  description     = "key_pairs"
}

variable private_subnet{
    type        = string
  description     = "private_subnet"
}

variable public_subnet{
    type        = string
  description     = "public_subnet"
}

variable instance_type {
    type        = string
    description     = "instance_type"
}

variable vpc_id{
    type  = string
    
    description = "vpc_id"
}

variable alb_sg{
  type  = string
  description = "alb security group id "
}

variable path_to_key{
  type  = string
  description = "for the bastion host key "
}