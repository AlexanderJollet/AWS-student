variable "region" {
   default = "us-west-1"
}

variable "amis" {
  type = map
  default = {
    "us-east-1" = "ami-0bcc094591f354be2"
    "us-west-2" = "ami-???"
  }
}
