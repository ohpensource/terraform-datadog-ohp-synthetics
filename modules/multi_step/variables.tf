variable "name" {
  type        = string
  description = "Required. Name of Datadog synthetics test"
}

variable "locations" {
  type        = list(any)
  default     = ["aws:eu-west-1"]
  description = "Required. Array of locations used to run the test. Refer to Datadog documentation for available locations"
}

variable "api_type" {
  type        = string
  default     = "api"
  description = "Required. Synthetics test type (api or browser)"
}

variable "status" {
  type        = string
  default     = "paused"
  description = "Required. Define whether you want to start (live) or pause (paused) a Synthetic test"
}

variable "message" {
  type        = string
  default     = ""
  description = "Optional. Message to send on alert"
}

variable "tags" {
  type        = list(any)
  description = "A list of datadog tags to associate with your synthetics test. This can help you categorize and filter tests in the manage synthetics page of the UI"
}

variable "api_subtype" {
  type        = string
  default     = "multi"
  description = "When type is api, choose from http, ssl, tcp, dns or multi"
}

variable "alert_tags" {
  type        = list(string)
  description = "List of alert tags to add to all alert messages, e.g. `[\"@opsgenie\"]` or `[\"@devops\", \"@opsgenie\"]`"
  default     = null
}

variable "alert_tags_separator" {
  type        = string
  description = "Separator for the alert tags. All strings from the `alert_tags` variable will be joined into one string using the separator and then added to the alert message"
  default     = "\n"
}

variable "options_list" {
  type = map(any)
  default = {
    tick_every        = 900
    retry_count       = 2
    retry_interval    = 300
    renotify_interval = 120
  }
}

variable "api_steps" {
  description = "Required. API test steps"
}

variable "datadog_api_key" {
  description = "DataDog API Key (resolved from repo bitbucket local vars)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "datadog_app_key" {
  description = "DataDog App Key (resolved from repo bitbucket local vars)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "script_relative_path" {
  type        = string
  description = "Relative path to file from current working directory. Incl. filename"
  default     = ""
}
