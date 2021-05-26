// Terraform Backend
terraform {
  required_version = "~>0.15"

  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 2.21"
    }
  }
}
