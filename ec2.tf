
variable "instancias" {
  description = "Nommbre de las instancias"
  type        = list(string)
  default     = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each               = toset(var.instancias)
  ami                    = "ami-07caf09b362be10b8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    "Name" = "${each.value}-${local.sufix}"
  }


  #   provisioner "local-exec" {
  #     command = "echo instancia creada con IP ${aws_instance.public_instance.public_ip}  >> datos_instancia.txt"

  #   }
  #    provisioner "local-exec" {
  #     when = destroy
  #     command = "echo instancia creada con IP ${self.public_ip} Destruida  >> datos_instancia.txt"

  #   }
  #   provisioner "remote-exec" {
  #     inline = [ 
  #       "echo 'hola mundo' > ~/saludo.txt "
  #      ]
  #     connection {
  #          type = "ssh"
  #          host =  self.public_ip
  #          user = "ec2-user"
  #          private_key = file("/home/shiwa/Escritorio/aws/my_key.pem")
  #     } 

}


resource "aws_instance" "public_instance_monitoreo" {
  count                  = var.enable_monitoring ? 1 : 0
  ami                    = "ami-07caf09b362be10b8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
  "Name" = "Monitoring-${local.sufix}" }
}
