#!/bin/bash

# 定义字典
declare -A mappings=(
  ["linux-386-musl"]="linux/386"
  ["linux-amd64-musl"]="linux/amd64"
  ["linux-armv6-musleabi"]="linux/arm/v6"
  ["linux-armv7l-musleabihf"]="linux/arm/v7"
  ["linux-arm64-musl"]="linux/arm64"
  ["linux-ppc64le-musl"]="linux/ppc64le"
  ["linux-riscv64-musl"]="linux/riscv64"
  ["linux-s390x-musl"]="linux/s390x"
)

repo=$(basename "$REPOSITORY")
string=$OUTPUT
output="${string//\$repo/$repo}"

echo "output=$output"
echo "output=$output" >> "$GITHUB_OUTPUT"

# Traverse the bin directory
for file in temp-bin/temp*; do
  # Get filename
  filename=$(basename "$file")

  # Get key from filename
  key="${filename#temp}"

  # if the key exists in the mappings
  if [ -n "${mappings[$key]}" ]; then
    target_dir="bin/${mappings[$key]}"

    # if the target directory does not exist, create it
    if [ ! -d "$target_dir" ]; then
      mkdir -p "$target_dir"
    fi

    # Move the file to the target directory
    mv "$file" "$target_dir/${output}"
  fi
done
