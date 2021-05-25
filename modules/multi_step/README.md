# Terraform Module - Datadog Synthetic Monitors - Multi-step

## Description

Describe what your module does here.

## Usage

Describe how to use your module here.

## Prerequites

If there are any prerequistes to making this module work, add them here.

### Optional

* [pre-commit](https://pre-commit.com/#install)
    * Install the pre-commit hooks in the mod repo using

      ```(text)
      pre-commit install
      ```

* Python3 & pip
    * Any addtional pip modules should be added to requirements.txt

## Documentation

[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)

## Bitbucket Synthethic IP Addresses

[link](https://ip-ranges.datadoghq.eu/synthetics.json)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>0.14 |
| <a name="requirement_datadog"></a> [datadog](#requirement\_datadog) | ~> 2.21 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | ~> 2.21 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_synthetics_test.multi](https://registry.terraform.io/providers/DataDog/datadog/latest/docs/resources/synthetics_test) | resource |
| [local_file.run_test_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_steps"></a> [api\_steps](#input\_api\_steps) | Required. API test steps | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Required. Name of Datadog synthetics test | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of datadog tags to associate with your synthetics test. This can help you categorize and filter tests in the manage synthetics page of the UI | `list(any)` | n/a | yes |
| <a name="input_alert_tags"></a> [alert\_tags](#input\_alert\_tags) | List of alert tags to add to all alert messages, e.g. `["@opsgenie"]` or `["@devops", "@opsgenie"]` | `list(string)` | `null` | no |
| <a name="input_alert_tags_separator"></a> [alert\_tags\_separator](#input\_alert\_tags\_separator) | Separator for the alert tags. All strings from the `alert_tags` variable will be joined into one string using the separator and then added to the alert message | `string` | `"\n"` | no |
| <a name="input_api_subtype"></a> [api\_subtype](#input\_api\_subtype) | When type is api, choose from http, ssl, tcp, dns or multi | `string` | `"multi"` | no |
| <a name="input_api_type"></a> [api\_type](#input\_api\_type) | Required. Synthetics test type (api or browser) | `string` | `"api"` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | DataDog API Key (resolved from repo bitbucket local vars) | `string` | `""` | no |
| <a name="input_datadog_app_key"></a> [datadog\_app\_key](#input\_datadog\_app\_key) | DataDog App Key (resolved from repo bitbucket local vars) | `string` | `""` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | Required. Array of locations used to run the test. Refer to Datadog documentation for available locations | `list(any)` | <pre>[<br>  "aws:eu-west-1"<br>]</pre> | no |
| <a name="input_message"></a> [message](#input\_message) | Optional. Message to send on alert | `string` | `""` | no |
| <a name="input_options_list"></a> [options\_list](#input\_options\_list) | n/a | `map(any)` | <pre>{<br>  "renotify_interval": 100,<br>  "retry_count": 2,<br>  "retry_interval": 300,<br>  "tick_every": 900<br>}</pre> | no |
| <a name="input_script_relative_path"></a> [script\_relative\_path](#input\_script\_relative\_path) | Relative path to file from current working directory. Incl. filename | `string` | `""` | no |
| <a name="input_status"></a> [status](#input\_status) | Required. Define whether you want to start (live) or pause (paused) a Synthetic test | `string` | `"paused"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->