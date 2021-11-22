# Terraform Module - Datadog Synthetic Monitors - Multi-step

## Description

Datadog Synthetics are a way to run tests against an API or HTTP endpoint and return a result to datadog. More information can be found [here](https://docs.datadoghq.com/synthetics/)

## Usage

Please see examples folder for how to use this module.

To be able to use the sensitive function to hide secrets during automation, Terraform v0.15 is required.

## Calling the Datadog Test from the CI/CD Pipeline

As part of the terraform project, a bash shell script is created on apply. This script is based on the following template

```(bash)
set -o pipefail

curl -X POST \
-H 'Content-Type: application/json' \
-H "DD-API-KEY: ${DATADOG_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DATADOG_APP_KEY}" \
-d "{
    \"tests\": [
        {
            \"public_id\": \"${SYNTHETIC_TEST_ID}\"
        }
    ]
}" "https://api.datadoghq.eu/api/v1/synthetics/tests/trigger/ci"
```

The script can be saved on any relative path (just update variable script_relative_path) and called from the pipeline. The pipeline will fail if a negative response is received from the synthetic test.

## Prerequites

To avoid storing the Datadog API and APP keys (secrets) in the repository we leverage Bitbucket variables and Terraform [TF_VAR_xxx](https://www.terraform.io/docs/cli/config/environment-variables.html#tf_var_name) environment variables.

## Documentation

[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)

## Bitbucket Synthethic IP Addresses

[link](https://ip-ranges.datadoghq.eu/synthetics.json)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->