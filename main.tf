provider "aws" {
  region = "us-east-2"
}
variable "inetrnal_ports" {
  type    = list(any)
  default = ["8200", "4200", "5000", "9500"]
}
variable "external_ports" {
  type    = list(any)
  default = ["80", "8080", "443"]
}

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "for allowing access to internet"
  vpc_id      = "vpc-02c2fbf1e4c85a09c"

  dynamic "ingress" {
    for_each = var.inetrnal_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  dynamic "egress" {
    for_each = var.external_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
