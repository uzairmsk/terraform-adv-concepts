variable "instance_name" {
  description = "The name of the compute instances"
  type        = string
}

variable "machine_type" {
  description = "The machine type to use for the instances"
  type        = string
  default     = "e2-micro"
}

variable "network" {
  description = "The VPC network to attach the instances to"
  type        = string
}

# variable "subnet" {
#   description = "The subnet to attach the instances to"
#   type        = string
# }

variable "zones" {
  description = "The zones where the instances will be deployed"
  type        = list(string)
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
}
