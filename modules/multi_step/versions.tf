// Terraform Backend
terraform {
  required_version = "~>0.14"

  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 2.21"
    }
  }
}
