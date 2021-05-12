#!/bin/bash

# Install Terraform-docs if not installed
TFM_DOCS_VER="0.13.0"

if ! command -v terraform-docs >/dev/null 2>&1; then
  curl -Lo ./terraform-docs.tar.gz "https://github.com/terraform-docs/terraform-docs/releases/download/v${TFM_DOCS_VER}/terraform-docs-v${TFM_DOCS_VER}-linux-amd64.tar.gz"
  tar -xzf terraform-docs.tar.gz 
  chmod +x terraform-docs 
  mv terraform-docs /usr/local/bin/terraform-docs
fi

# Create docs for each module
if [ -d modules ]; then
  cd ./modules || exit
  for f in *; do
    if [ -d "$f" ]; then
      # cycle through each module dir and create docs
      cd "$f" || exit
      echo -e "\n## Creating terraform docs for module $f"
      terraform-docs markdown table --output-file  "$f"/README.md --sort-by required
      git add README.md
      cd ..
    fi
  done
  cd ..
  return
else
  echo -e "\n## Creating terraform docs for module"
  terraform-docs markdown table --output-file  README.md --sort-by required
fi  