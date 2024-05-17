resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "VPC_Virginia-${local.sufix}"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public_Subnet-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "Private_Subnet-${local.sufix}"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }



  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_main_route_table_association" "crta_public_subnet" {
  vpc_id         = aws_vpc.vpc_virginia.id
  route_table_id = aws_route_table.public_crt.id
}


resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public Instance SG-${local.sufix}"
  }


}

# resource "aws_vpc_security_group_ingress_rule" "sg_allow" {
#   description       = "SSH  over internet"
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = var.sg_ingress_cidr
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
#   tags = {
#     Name = "Public instance SG-${local.sufix}"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "sg_allow-2" {
#   description       = "httpd over internet"
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = var.sg_ingress_cidr
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
#   tags = {
#     Name = "Public instance SG-${local.sufix}"
#   }
# }



# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.sg_public_instance.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }
