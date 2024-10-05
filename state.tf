terraform {
  backend "gcs" {
    bucket = "terraform-state76"
    prefix = "terraform/state"
  }
}
