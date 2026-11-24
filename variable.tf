variable "instance_type" {
  type        = string
  description = "my ec2 instance type"
  default     = "t3.micro"
}

variable "ingress" {
  type    = list(number)
  default = ["22", "80", "8080", "53", "443"]
}

variable "egress" {
  type    = list(number)
  default = ["0"]
}

variable "key" {
  type    = string
  default = "maya"
}