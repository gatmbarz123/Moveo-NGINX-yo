resource "aws_instance" "ngnix"{
    ami           = data.aws_ami.ubuntu_ami.id 
    key_name    =   var.key_pairs
    vpc_security_group_ids = [aws_security_group.ngnix_sg.id]
    subnet_id   = var.private_subnet
    instance_type   =   var.instance_type

    tags = {
    Name = "ngnix-yo"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo snap install docker",
      "sleep 5",
      "sudo systemctl start snap.docker.dockerd.service",  
      "sudo systemctl enable snap.docker.dockerd.service", 
      "sleep 10",
      "sudo docker pull diskoproject/ngnix-yo123",
      "sudo docker run -d -p 80:80 diskoproject/ngnix-yo123"
    ]

    connection {
      type                = "ssh"
      user                = "ubuntu"
      private_key         = file(var.path_to_key)
      host                = aws_instance.ngnix.private_ip
      bastion_host        = aws_instance.bastion_host.public_ip
      bastion_user        = "ubuntu"
      bastion_private_key = file(var.path_to_key)
    }
  }

}

resource "aws_security_group" "ngnix_sg" {
  name        = "ngnix_yo_sg"   
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.alb_sg]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





#------------------------------------------------------------------------ Nginx_private_instance
#------------------------------------------------------------------------ Bastion_Host_instance_public






resource "aws_instance" "bastion_host"{
    ami           = data.aws_ami.ubuntu_ami.id 
    key_name    =   var.key_pairs
    vpc_security_group_ids = [aws_security_group.bastion_host_sg.id]
    subnet_id   = var.public_subnet
    instance_type   =   var.instance_type

    user_data = <<-EOF
                apt-get update
                s

    EOF
    tags = {
    Name = "bastion_host"
  }


  provisioner "file" {
    source      = var.path_to_key 
    destination = "/home/ubuntu/private-key.pem"  

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"                     
      private_key = file(var.path_to_key)  
    }
  }

   provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu/private-key.pem"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.path_to_key)
    }
  }

}




resource "aws_security_group" "bastion_host_sg" {
  name        = "bastion_host_sg"   
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}