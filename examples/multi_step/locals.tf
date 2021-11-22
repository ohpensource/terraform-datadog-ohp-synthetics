locals {

  cognito_client_id     = jsondecode(data.aws_secretsmanager_secret_version.cognito.secret_string)["UserpoolClientIdMonitor"]
  cognito_client_secret = jsondecode(data.aws_secretsmanager_secret_version.cognito.secret_string)["UserpoolClientSecretMonitor"]

  api_steps = {
    "1" = {
      name    = "GetToken"
      subtype = "http"
      request_definition = {
        url    = "https://auth.${var.dtap}.${var.client}.ohpen.tech/oauth2/token?scope=${var.client}-${var.dtap}/${var.cognito_scope}"
        method = "POST"
        body   = "client_id=${local.cognito_client_id}&client_secret=7${local.cognito_client_secret}&grant_type=client_credentials"
      }
      request_headers = {
        "Content-Type" = "application/x-www-form-urlencoded"
      }
      extracted_values = [
        {
          name = "TOKEN"
          type = "http_body"
          parser = {
            type  = "json_path"
            value = "$.access_token"
          }
        }
      ]
      assertions = [
        {
          operator = "lessThan"
          type     = "responseTime"
          target   = 2000
        },
        {
          operator = "is"
          type     = "statusCode"
          target   = 200
        },
        {
          operator = "is"
          type     = "header"
          target   = "application/json;charset=UTF-8"
          property = "content-type"
        },
        {
          operator = "contains"
          type     = "body"
          target   = "access_token"
        },
        {
          operator = "validatesJSONPath"
          type     = "body"
          targetjsonpath = {
            jsonpath    = "$.token_type"
            operator    = "contains"
            targetvalue = "Bearer"
          }
        }
      ]
    },
    "2" = {
      name    = "GetStatus"
      subtype = "http"
      request_definition = {
        url    = "https://sentinel-rdc-webhook.${var.dtap}.${var.client}.ohpen.tech/status"
        method = "GET"
      }
      request_headers = { "Authorization" = "Bearer {{ TOKEN }}" }
      assertions = [
        {
          operator = "lessThan"
          type     = "responseTime"
          target   = 2000
        },
        {
          operator = "is"
          type     = "statusCode"
          target   = 200
        },
        {
          operator = "validatesJSONPath"
          type     = "body"
          targetjsonpath = {
            jsonpath    = "$.Status"
            operator    = "contains"
            targetvalue = "Healthy"
          }
        }
      ]
    }
  }
}
