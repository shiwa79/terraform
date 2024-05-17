variable "virginia_cidr" {
  description = "CIDR Virginia"
  type        = string
}

# variable "public_subnet" {
#     description = "CIDR public subnet"
#     type = string
# }

# variable "private_subnet" {
#     description = "CIDR private subnet"
#     type = string
# }

variable "subnets" {
  description = "Lista subnets"
  type        = list(string)
}

variable "tags" {
  description = "Tags del Proyecto"
  type        = map(string)

}
variable "sg_ingress_cidr" {
  description = "CIDR for ingress traffic"
  type        = string

}
variable "enable_monitoring" {
  description = "Habilita el despliegue de un servidor de monitoring "
  type        = bool
}
variable "ingress_port_list" {
  description = "Puertos ingress"
  type        = list(number)

}
