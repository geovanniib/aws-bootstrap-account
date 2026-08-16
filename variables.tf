
variable "tags" {
  type = map(string)
  default = {
    Name        = "bootstrap-terraform"
    Environment = "dev"
  }
}


variable "prefix_base" {
  type    = string
  default = "bootstrap-terraform"
}

variable "region" {
  type    = string
  default = "us-east-1"
}