# 原图工坊示例服务

这是一个基于 Spring Boot 的示例服务，用于指导合作伙伴如何开发和部署后端服务。

## 环境要求

- JDK 1.8+
- Maven 3.6+
- Docker (可选，用于容器化部署)
- Kubernetes (可选，用于容器编排)

## 快速开始

### 1. 克隆项目

```bash
git clone [项目地址]
cd metaworks-demo-service
```

### 2. 构建项目

```bash
mvn clean package
```

### 3. 运行项目

```bash
java -jar target/demo3-1.0-SNAPSHOT.jar
```

## 项目结构

```
metaworks-demo-service/
├── src/                    # 源代码目录
│   ├── main/
│   │   ├── java/         # Java 源代码
│   │   └── resources/    # 配置文件
├── helm/                  # Kubernetes Helm 配置
├── sdk/                   # SDK 相关代码
├── docs/                  # 文档目录
└── pom.xml               # Maven 配置文件
```

## 开发指南

### 1. 配置说明

项目配置文件位于 `src/main/resources/` 目录下，包含：
- application.yml：主配置文件



## 部署指南

### 1. Docker 部署

```bash
# 构建 Docker 镜像
./scripts/build-docker.sh

```

