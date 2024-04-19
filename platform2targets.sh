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

# 读取环境变量中的PLATFORMS字符串
platforms_str=${PLATFORMS:-""}

# 以逗号分割字符串，并替换每个部分
IFS=',' read -ra platforms_list <<< "$platforms_str"
replaced_platforms=()
for platform in "${platforms_list[@]}"; do
    replaced_platforms+=("${mappings[$platform]:-$platform}")
done

# 将替换后的部分用逗号拼接起来
replaced_str=$(IFS=,; echo "${replaced_platforms[*]}")

# 将结果写入到环境变量为GITHUB_OUTPUT路径的文件中
output_file=${GITHUB_OUTPUT:-"output.txt"}
echo "targets=$replaced_str" >> "$output_file"
