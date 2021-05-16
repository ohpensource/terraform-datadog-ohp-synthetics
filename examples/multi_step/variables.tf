variable "api_key" {
  type      = string
  sensitive = true
}
variable "app_key" {
  type      = string
  sensitive = true
}


variable "datadog_synthetic_ip_addrs" {
  type = map(any)
  default = {
    eu-west-1 = [
      "63.35.33.198/32",
      "18.200.120.237/32",
      "63.34.100.178/32"
    ]
  }
}

variable "client" {
  type    = string
  default = "rbc"
}

variable "dtap" {
  type    = string
  default = "tst"
}

variable "cognito_scope" {
  type    = string
  default = "monitoring"
}
