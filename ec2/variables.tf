variable "vpc_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "existing_s3_bucket" {
  type = string
}
