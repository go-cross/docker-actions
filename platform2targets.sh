#!/bin/bash

declare -A mappings=(
    ["linux/386"]="linux-386-musl"
    ["linux/amd64"]="linux-amd64-musl"
    ["linux/arm/v6"]="linux-armv6-musleabi"
    ["linux/arm/v7"]="linux-armv7l-musleabihf"
    ["linux/arm64"]="linux-arm64-musl"
    ["linux/ppc64le"]="linux-ppc64le-musl"
    ["linux/riscv64"]="linux-riscv64-musl"
    ["linux/s390x"]="linux-s390x-musl"
)

# Read the PLATFORMS string in the environment variable
platforms_str=${PLATFORMS:-""}

# Split string by comma and replace each part
IFS=',' read -ra platforms_list <<< "$platforms_str"
replaced_platforms=()
for platform in "${platforms_list[@]}"; do
    replaced_platforms+=("${mappings[$platform]:-$platform}")
done

# Splice the replaced parts together with commas
replaced_str=$(IFS=,; echo "${replaced_platforms[*]}")

echo "Build targets: $replaced_str"

# Write the results to the file whose environment variable is the GITHUB_OUTPUT path
output_file=${GITHUB_OUTPUT:-"output.txt"}
echo "targets=$replaced_str" >> "$output_file"
