#!/bin/bash

# 设置变量
HOST="119.3.88.39"
DOMAIN="ytgfst"
IMAGE_NAMESPACE="sthy-hz"
USERNAME="ytgfst"
PASSWORD="Smart@ytst202311"
TEMPLATE_NAME="gdesre-alarmflink"
TEMPLATE_FILENAME="gdesre-alarm-23.0.0.B011.zip"
TEMPLATE_VERSION="1.0.0"

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

# 1. 获取 FS Token
get_fs_token() {
    print_info "Getting FS Token..."
    local response=$(curl -s -X POST "https://${HOST}:31943/v3/auth/tokens" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -d "{
            \"auth\": {
                \"identity\": {
                    \"methods\": [\"password\"],
                    \"password\": {
                        \"user\": {
                            \"name\": \"${USERNAME}\",
                            \"password\": \"${PASSWORD}\",
                            \"domain\": {
                                \"name\": \"${DOMAIN}\"
                            }
                        }
                    }
                },
                \"scope\": {
                    \"project\": {
                        \"name\": \"${IMAGE_NAMESPACE}\"
                    }
                }
            }
        }")

    # 从响应头中提取 token
    local token=$(curl -s -X POST "https://${HOST}:31943/v3/auth/tokens" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -d "{
            \"auth\": {
                \"identity\": {
                    \"methods\": [\"password\"],
                    \"password\": {
                        \"user\": {
                            \"name\": \"${USERNAME}\",
                            \"password\": \"${PASSWORD}\",
                            \"domain\": {
                                \"name\": \"${DOMAIN}\"
                            }
                        }
                    }
                },
                \"scope\": {
                    \"project\": {
                        \"name\": \"${IMAGE_NAMESPACE}\"
                    }
                }
            }
        }" -i | grep "X-Subject-Token" | awk '{print $2}')

    if [ -z "$token" ]; then
        print_error "Failed to get token"
        return 1
    fi

    print_info "Token obtained successfully"
    echo "$token"
}

# 2. 提交 TOSCA 模板
submit_tosca_template() {
    local token=$1
    print_info "Submitting TOSCA template..."

    curl -X POST "https://${HOST}:31800/v2/templates" \
        -H "X-Auth-Token: ${token}" \
        -H "Content-Type: multipart/form-data" \
        -F "resource={\"name\":\"${TEMPLATE_NAME}\",\"description\":\"xxx\",\"version\":\"${TEMPLATE_VERSION}\",\"domain\":\"${DOMAIN}\",\"vendor\":\"${DOMAIN}\",\"main_file_name\":\"blueprint.yaml\",\"filename\":\"${TEMPLATE_FILENAME}\"}" \
        -F "archive_content=@/path/to/your/template.zip"

    if [ $? -eq 0 ]; then
        print_info "TOSCA template submitted successfully"
    else
        print_error "Failed to submit TOSCA template"
    fi
}

# 3. 提交 Helm 模板
submit_helm_template() {
    local token=$1
    print_info "Submitting Helm template..."

    curl -X POST "https://${HOST}:31943/v2/charts" \
        -H "X-Auth-Token: ${token}" \
        -H "Content-Type: multipart/form-data" \
        -H "Projectname: ${IMAGE_NAMESPACE}" \
        -F "content=@/path/to/your/chart.tgz" \
        -F "parameters={\"domain\":\"${DOMAIN}\",\"public\":false,\"override\":true,\"skip_lint\":false}"

    if [ $? -eq 0 ]; then
        print_info "Helm template submitted successfully"
    else
        print_error "Failed to submit Helm template"
    fi
}

# 4. 上传镜像
upload_image() {
    local token=$1
    print_info "Uploading image..."

    curl -X PUT "https://${HOST}:20202/dockyard/v2/domains/${DOMAIN}/namespaces/${IMAGE_NAMESPACE}/images" \
        -H "X-Auth-Token: ${token}" \
        -H "Content-Type: multipart/form-data" \
        -F "file=@/path/to/your/image.tar"

    if [ $? -eq 0 ]; then
        print_info "Image uploaded successfully"
    else
        print_error "Failed to upload image"
    fi
}

# 主函数
main() {
    # 获取 token
    local token=$(get_fs_token)
    if [ -z "$token" ]; then
        print_error "Failed to get token, exiting..."
        exit 1
    fi

    # 执行各个操作
    submit_tosca_template "$token"
    submit_helm_template "$token"
    upload_image "$token"
}

# 执行主函数
main 