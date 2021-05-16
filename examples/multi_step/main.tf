provider "datadog" {
  api_url = "https://api.datadoghq.eu/"
  app_key = var.app_key
  api_key = var.api_key
}

module "multi_step" {
  source    = "git@bitbucket.org:ohpen-dev/terraform-datadog-ohp-synthetics.git//modules//multi_step?ref=v0.1.0"
  name      = "test"
  api_steps = local.api_steps
  tags      = ["env:tst"]

}

data "aws_secretsmanager_secret" "cognito" {
  name = "${var.client}-${var.dtap}-internal-monitor"
}

data "aws_secretsmanager_secret_version" "cognito" {
  secret_id = data.aws_secretsmanager_secret.cognito.id
}
