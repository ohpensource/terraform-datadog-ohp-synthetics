locals {
  api_steps = [{
    name                    = "GetStatus"
    subtype                 = "http"
    enable_basic_auth       = false
    enable_client_certs     = false
    enable_extracted_values = false
    enable_assertions       = false
    request_definition = {
      url                     = "https://sentinel-rdc-webhook.tst.rbc.ohpen.tech/status" # (String) The URL to send the request to
      method                  = "GET"                                                    # The HTTP method. One of DELETE, GET, HEAD, OPTIONS, PATCH, POST, PUT
      body                    = null                                                     # (String) The request body.
      dns_server              = null                                                     # (String) DNS server to use for DNS tests (subtype = "dns")
      host                    = null                                                     # (String) Host name to perform the test with
      no_saving_response_body = null                                                     # (Boolean) Determines whether or not to save the response body
      port                    = null                                                     # Port to use when performing the test
      timeout                 = null                                                     # (Number) Timeout in seconds for the test. Defaults to 60
    }
    request_headers = null # (Map of String) Header name and value map
    request_basicauth = {
      password = null # (String, Sensitive) Password for authentication
      username = null # (String) Username for authentication
    }
    request_client_certificate = {
      cert = {
        content  = null # Required (String, Sensitive) Content of the certificate
        filename = null # (String) File name for the certificate
      },
      key = {
        content  = null # Required (String, Sensitive) Content of the certificate
        filename = null # (String) File name for the certificate
      }
    }
    extracted_values = [{
      name  = null # Required (String)
      type  = null # (String) Property of the Synthetics Test Response to use for the variable: http_body or http_header
      field = null # (String) When type is http_header, name of the header to use to extract the value.
      parser = {
        type  = null # Required (String) Type of parser for a Synthetics global variable from a synthetics test: raw, json_path, regex
        value = null # (String) Regex or JSON path used for the parser. Not used with type raw
      }
    }]
    assertions = [{
      operator = null # Required (String) Assertion operator. Note Only some combinations of type and operator are valid (please refer to Datadog documentation)
      type     = null # Required (String) Type of assertion. Choose from body, header, responseTime, statusCode. Note Only some combinations of type and operator are valid (please refer to Datadog documentation)
      property = null # (String) If assertion type is header, this is the header name
      target   = null # (String) Expected value. Depends on the assertion type, refer to Datadog documentation for details
      targetjsonpath = {
        jsonpath    = null # (String) The JSON path to assert
        operator    = null # (String) The specific operator to use on the path
        targetvalue = null # (String) Expected matching value
      }
    }]
  }]
}
