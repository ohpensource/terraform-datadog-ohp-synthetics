#!/bin/bash

# Install Terraform-docs if not installed
TFM_DOCS_VER="0.13.0"
MOD_DIR="modules"

if ! command -v terraform-docs >/dev/null 2>&1; then
  curl -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${TFM_DOCS_VER}/terraform-docs-v${TFM_DOCS_VER}-linux-amd64.tar.gz"
  tar -xzf terraform-docs.tar.gz 
  chmod +x terraform-docs 
  mv terraform-docs /usr/local/bin/terraform-docs
fi

# Create docs for each module
if [ -d "$MOD_DIR" ]; then
  for f in $(ls $MOD_DIR); do
    if [ -d "./$MOD_DIR/$f" ]; then
      # cycle through each module dir and create docs
      echo -e "\n## Creating terraform docs for module $f"
      terraform-docs markdown table --sort-by required --output-file README.md "./$MOD_DIR/$f" 
      git add "./$MOD_DIR/$f/README.md"
    fi
  done
else
  echo -e "\n## Creating terraform docs for root module"
  terraform-docs markdown table --sort-by required --output-file  README.md .
fi  