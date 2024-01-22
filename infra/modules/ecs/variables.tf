variable "project_name" {
  description = "The project name to be used as a prefix for resources"
  type        = string
}

variable "pub_subnet_ids" {
  type = list(string)
}

variable "priv_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string  
}

variable "repository_name" {
  description = "The name of the ECR repository to store container images"
  type        = string
  default     = "salsify-docker-registry"
}

variable "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  type = number
  default = 2
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type = number
  default = 2
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type = number
  default = 2
}

variable "container_name" {
  description = "Container name to run on ECS"
  type = string
  default = "salsify-gifmachine-container"
}

variable "container_port" {
  description = "Container Port"
  type = number
  default = 4567
}

variable "ecs_cluster_name" {
  description = "Name of the Cluster"
  type = string
  default = "salsify-ecs-cluster"
}

variable "ecs_optimized_ami" {
  description = "EC2 image optimized for ECS service"
  type = string
  default = "ami-0b74aeb97fba885ea"
}

variable "ecs_ec2_instance_type" {
  description = "T-shirt size"
  type = string
  default = "t2.small"
}

variable "ssh_key_name" {
  description = "SSH key"
  type = string
  default = "vockey"
}

# Applications specific vars
variable "database_url" {
  description = "Postgres database url in the format: postgres://user:pass@ip_addr:port/gifmachine"
  type        = string
}

variable "rack_env" {
  description = "Gifmachine app run-mode (development | *production)"
  type        = string
}

variable "gifmachine_password" {
  description = "To be discussed"
  type        = string
}