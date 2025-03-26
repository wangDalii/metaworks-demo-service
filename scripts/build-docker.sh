#!/bin/bash

# 设置变量
IMAGE_NAME="metaworks-demo-service"
IMAGE_TAG="latest"
DOCKER_FILE="Dockerfile"

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# 构建 Docker 镜像
echo "Building Docker image: $IMAGE_NAME:$IMAGE_TAG"
docker build -t $IMAGE_NAME:$IMAGE_TAG -f $DOCKER_FILE .

# 检查构建是否成功
if [ $? -eq 0 ]; then
    echo "Docker image built successfully!"
else
    echo "Failed to build Docker image."
    exit 1
fi 