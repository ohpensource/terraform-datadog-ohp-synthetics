resource "datadog_synthetics_test" "multi" {
  type      = var.api_type
  subtype   = var.api_subtype
  locations = var.locations
  name      = var.name
  message   = format("%s%s", var.message, local.alert_tags)
  tags      = var.tags
  status    = var.status

  dynamic "config_variable" {
    for_each = var.config_variables

    content {
      type = config_variable.value.type
      name = config_variable.value.local_variable_name
      id   = config_variable.value.global_variable_id
    }
  }

  dynamic "api_step" {
    for_each = var.api_steps

    content {
      name    = api_step.value.name
      subtype = api_step.value.subtype
      request_definition {
        url                     = api_step.value.request_definition.url
        method                  = api_step.value.request_definition.method
        body                    = lookup(api_step.value.request_definition, "body", null)
        dns_server              = lookup(api_step.value.request_definition, "dns_server", null)
        host                    = lookup(api_step.value.request_definition, "host", null)
        no_saving_response_body = lookup(api_step.value.request_definition, "no_saving_response_body", null)
        port                    = lookup(api_step.value.request_definition, "port", null)
        timeout                 = lookup(api_step.value.request_definition, "timeout", null)
        follow_redirects        = lookup(api_step.value.request_definition, "follow_redirects", null)
      }
      request_headers = lookup(api_step.value, "request_headers", null)

      dynamic "request_basicauth" {
        for_each = lookup(api_step.value, "request_basicauth", null) != null ? [api_step.value.request_basicauth] : []

        content {
          password = lookup(request_basicauth.value, "password", null)
          username = lookup(request_basicauth.value, "username", null)
        }
      }
      dynamic "request_client_certificate" {
        for_each = lookup(api_step.value, "request_client_certificate", null) != null ? [api_step.value.request_client_certificate] : []

        content {
          cert {
            content  = lookup(request_client_certificate.value.cert, "content", null)
            filename = lookup(request_client_certificate.value.cert, "filename", null)
          }
          key {
            content  = lookup(request_client_certificate.value.key, "content", null)
            filename = lookup(request_client_certificate.value.key, "filename", null)
          }
        }
      }

      dynamic "extracted_value" {
        for_each = lookup(api_step.value, "extracted_values", null) != null ? api_step.value.extracted_values : []

        content {
          name  = lookup(extracted_value.value, "name", null)
          type  = lookup(extracted_value.value, "type", null)
          field = lookup(extracted_value.value, "field", null)

          dynamic "parser" {
            for_each = lookup(extracted_value.value, "parser", null) != null ? [1] : []

            content {
              type  = lookup(extracted_value.value.parser, "type", null)
              value = lookup(extracted_value.value.parser, "value", null)
            }
          }
        }
      }

      dynamic "assertion" {
        for_each = api_step.value.assertions

        content {
          operator = lookup(assertion.value, "operator", null)
          type     = lookup(assertion.value, "type", null)
          property = lookup(assertion.value, "property", null)
          target   = lookup(assertion.value, "target", null)

          dynamic "targetjsonpath" {
            for_each = lookup(assertion.value, "targetjsonpath", null) != null ? [1] : []

            content {
              operator    = lookup(assertion.value.targetjsonpath, "operator", null)
              targetvalue = lookup(assertion.value.targetjsonpath, "targetvalue", null)
              jsonpath    = lookup(assertion.value.targetjsonpath, "jsonpath", null)
            }
          }
        }
      }
      
      retry {
        count    = var.options_list.retry_count
        interval = var.options_list.retry_interval
      }
    }
  }

  options_list {
    tick_every = var.options_list.tick_every

    retry {
      count    = var.options_list.retry_count
      interval = var.options_list.retry_interval
    }

    monitor_options {
      renotify_interval = var.options_list.renotify_interval
    }
  }
}

