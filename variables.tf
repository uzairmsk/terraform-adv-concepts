variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default= "devops-demo-431609"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zones" {
  description = "List of zones to deploy the instances"
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b"]
}
