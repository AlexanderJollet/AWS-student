variable "region" {
   default = "us-west-1"
}

variable "subnet" {
   default = "10.42.1.0/24"
}

variable "bastion_ip" {
   default = "10.42.1.254"
}

variable "amis" {
  type = map
  default = {
    "us-east-1" = "ami-0bcc094591f354be2"
    "us-west-2" = "ami-???"
    "us-west-1" = "ami-???"
  }
}

