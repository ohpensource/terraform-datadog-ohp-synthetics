variable "name" {
  description = "Name to apply to resources"
}
variable "region" { default = "eu-west-1" }
variable "tags" {
  type        = map(any)
  description = "(Required) Map of tags to apply to repository"
}
