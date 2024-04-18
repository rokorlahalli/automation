variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.18.0.0/16"
}

variable "assign_generated_ipv6_cidr_block" {
  default = "true"
}

variable "vpc_name" {
  default = "hexolt-prod-vpc"
}

variable "pub_subnet_name" {
  default = "hexolt-public-subnet-prod"
}

variable "app_subnet_name" {
  default = "hexolt-app-subnet-prod"
}

variable "db_subnet_name" {
  default = "hexolt-db-subnet-prod"
}

variable "gateway_subnet_name" {
  default = "hexolt-gateway-subnet-prod"
}

variable "monitoring_subnet_name" {
  default = "hexolt-monitoring-subnet-prod"
}

variable "public_subnet_1" {
  default = "10.18.1.0/24"
}

variable "public_subnet_2" {
  default = "10.18.5.0/24"
}

variable "public_subnet_3" {
  default = "10.18.11.0/24"
}

variable "gateway_subnet_1" {
  default = "10.18.15.0/24"
}

variable "gateway_subnet_2" {
  default = "10.18.21.0/24"
}

variable "app_subnet_1" {
  default = "10.18.25.0/24"
}

variable "app_subnet_2" {
  default = "10.18.31.0/24"
}

variable "app_subnet_3" {
  default = "10.18.35.0/24"
}

variable "db_subnet_1" {
  default = "10.18.41.0/24"
}

variable "db_subnet_2" {
  default = "10.18.45.0/24"
}

variable "db_subnet_3" {
  default = "10.18.51.0/24"
}

variable "monitoring_subnet_1" {
  default = "10.18.55.0/24"
}

variable "monitoring_subnet_2" {
  default = "10.18.61.0/24"
}

#S3 Bucket to staore tf state file.

variable "s3_bucket_name" {
  default = "hex-tf-state"
}



