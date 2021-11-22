locals {
  alert_tags = var.alert_tags != null ? format("%s%s", var.alert_tags_separator, join(var.alert_tags_separator, var.alert_tags)) : ""

  # local_scripts_dir = var.local_scripts_dir != null || var.local_scripts_dir != "" ? "${var.local_scripts_dir}/" : ""

  script_relative_path = var.script_relative_path == "" ? "${path.cwd}/scripts/datadog_synthetic_test.sh" : var.script_relative_path
}
