output "instance_id" {
  value = aws_instance.ngnix.id
  description = "The ID of the example EC2 instance."
}