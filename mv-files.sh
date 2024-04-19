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

# 遍历 bin 目录
for file in temp-bin/temp*; do
  # 获取文件名
  filename=$(basename "$file")

  # 获取文件的键
  key="${filename#temp}"

  # 如果字典中存在对应的值
  if [ -n "${mappings[$key]}" ]; then
    # 目标目录为键对应的值
    target_dir="bin/${mappings[$key]}"

    # 如果目标目录不存在，则创建
    if [ ! -d "$target_dir" ]; then
      mkdir -p "$target_dir"
    fi

    # 将文件移动到目标目录，并重命名为 temp
    mv "$file" "$target_dir/${output}"
  fi
done
