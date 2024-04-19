import os

mappings = {
    "linux/386": "linux-386-musl",
    "linux/amd64": "linux-amd64-musl",
    "linux/arm/v6": "linux-armv6-musleabi",
    "linux/arm/v7": "linux-armv7l-musleabihf",
    "linux/arm64": "linux-arm64-musl",
    "linux/ppc64le": "linux-ppc64le-musl",
    "linux/riscv64": "linux-riscv64-musl",
    "linux/s390x": "linux-s390x-musl",
}

platforms_str = os.environ.get("PLATFORMS", "")

platforms_list = platforms_str.split(",")
replaced_platforms = [mappings.get(platform, platform) for platform in platforms_list]

replaced_str = ",".join(replaced_platforms)

# 将结果写入到环境变量为GITHUB_OUTPUT路径的文件中
output_file = os.environ.get("GITHUB_OUTPUT", "output.txt")
with open(output_file, "w") as f:
    f.write(f"targets={replaced_str}")
