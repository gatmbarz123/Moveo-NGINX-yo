variable region {
  type        = string
  description     = "aws-region"
}

variable private_key{
  type  = string
}
variable instance_type{
    type  = string
}

variable "certificate_arn" {
  description = "The certificate arn"
  type        = string

}

variable path_to_key{
  type  = string
  description = "for the bastion host key "
}