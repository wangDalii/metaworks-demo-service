#!/bin/bash

# 设置变量
IMAGE_NAME="metaworks-demo-service"
IMAGE_TAG=$(date +%Y%m%d%H%M%S)
DOCKER_FILE="Dockerfile"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
DIST_DIR="$(dirname "$SCRIPT_DIR")/dist"

# 颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# 打印带颜色的信息
print_info() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# 构建 Docker 镜像
print_info "Building Docker image: $IMAGE_NAME:$IMAGE_TAG"
docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKER_FILE $PROJECT_ROOT

# 检查构建是否成功
if [ $? -eq 0 ]; then
    print_info "Docker image built successfully!"
    
    # 保存镜像为 tar 文件
    TAR_FILE="$DIST_DIR/${IMAGE_NAME}_${IMAGE_TAG}.tar"
    print_info "Saving image to: $TAR_FILE"
    docker save -o $TAR_FILE $IMAGE_NAME:$IMAGE_TAG
    
    if [ $? -eq 0 ]; then
        print_info "Image saved successfully!"
        print_info "Image size: $(du -h $TAR_FILE | cut -f1)"
    else
        print_error "Failed to save image"
        exit 1
    fi
else
    print_error "Failed to build Docker image."
    exit 1
fi 