#!/bin/bash

# 设置颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 打印带颜色的信息
print_info() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
HELM_DIR="$PROJECT_ROOT/deploy/helm"
DIST_DIR="$(dirname "$SCRIPT_DIR")"

# 检查Chart.yaml是否存在
if [ ! -f "$HELM_DIR/Chart.yaml" ]; then
    print_error "Chart.yaml not found in $HELM_DIR"
    exit 1
fi

# 读取Chart.yaml中的name和version
CHART_NAME=$(grep '^name:' "$HELM_DIR/Chart.yaml" | awk '{print $2}')
CHART_VERSION=$(grep '^version:' "$HELM_DIR/Chart.yaml" | awk '{print $2}')

if [ -z "$CHART_NAME" ] || [ -z "$CHART_VERSION" ]; then
    print_error "Failed to read name or version from Chart.yaml"
    exit 1
fi

# 设置输出文件名（在dist目录下）
OUTPUT_FILE="$DIST_DIR/$CHART_NAME-$CHART_VERSION.tgz"

# 切换到helm目录
cd "$HELM_DIR" || {
    print_error "Failed to change directory to $HELM_DIR"
    exit 1
}

# 打包helm chart
print_info "Packaging Helm chart: $CHART_NAME-$CHART_VERSION"
if tar -czf "$OUTPUT_FILE" .; then
    print_info "Successfully created $OUTPUT_FILE"
    # 显示文件大小
    FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    print_info "Package size: $FILE_SIZE"
else
    print_error "Failed to package Helm chart"
    exit 1
fi 