# 部署指南

## 目录
1. [部署环境要求](#部署环境要求)
2. [部署方式](#部署方式)
3. [配置说明](#配置说明)
4. [监控与运维](#监控与运维)
5. [故障处理](#故障处理)

## 部署环境要求

### 1. 硬件要求
- CPU: 2核+
- 内存: 4GB+
- 磁盘: 20GB+

### 2. 软件要求
- JDK 1.8+
- Docker 20.10+
- Kubernetes 1.20+
- Helm 3.0+

## 部署方式

### 1. 本地部署

#### 1.1 直接运行
```bash
# 构建项目
mvn clean package

# 运行服务
java -jar target/demo3-1.0-SNAPSHOT.jar
```

#### 1.2 使用脚本部署
```bash
# 构建 Docker 镜像
./scripts/build-docker.sh

# 运行容器
./scripts/run-docker.sh
```

### 2. Kubernetes 部署

#### 2.1 使用 Helm 部署
```bash
# 部署应用
./scripts/deploy-helm.sh
```

#### 2.2 手动部署
```bash
# 创建命名空间
kubectl create namespace metaworks-demo

# 部署应用
helm install metaworks-demo-service ./helm \
    --namespace metaworks-demo \
    --set image.tag=latest
```

## 配置说明

### 1. 环境配置
- 开发环境：application-dev.yml
- 生产环境：application-prod.yml

### 2. 关键配置项
```yaml
server:
  port: 8080

spring:
  profiles:
    active: prod

logging:
  level:
    root: INFO
    com.example: DEBUG
```

### 3. 安全配置
```yaml
security:
  jwt:
    secret: your-secret-key
    expiration: 86400000
```

## 监控与运维

### 1. 健康检查
- 访问 `/actuator/health` 检查服务健康状态
- 访问 `/actuator/info` 查看服务信息

### 2. 日志管理
- 日志文件位置：/var/log/metaworks-demo/
- 日志轮转配置
- 日志级别调整

### 3. 性能监控
- JVM 监控
- 接口响应时间监控
- 系统资源监控

## 故障处理

### 1. 常见问题
1. 服务无法启动
   - 检查端口占用
   - 检查配置文件
   - 检查日志文件

2. 内存溢出
   - 调整 JVM 参数
   - 检查内存泄漏
   - 优化代码逻辑

3. 接口超时
   - 检查网络连接
   - 优化接口性能
   - 调整超时配置

### 2. 应急处理流程
1. 发现问题
2. 收集信息
3. 分析原因
4. 制定方案
5. 执行修复
6. 验证结果
7. 总结经验

### 3. 备份恢复
1. 数据备份
2. 配置文件备份
3. 恢复流程
4. 验证恢复

## 升级指南

### 1. 升级步骤
1. 备份数据
2. 停止服务
3. 更新代码
4. 重新部署
5. 验证功能

### 2. 回滚方案
1. 准备回滚脚本
2. 保存旧版本
3. 执行回滚
4. 验证回滚

## 安全建议

### 1. 系统安全
- 定期更新系统
- 配置防火墙
- 限制访问权限

### 2. 应用安全
- 使用 HTTPS
- 配置安全头
- 实施访问控制

### 3. 数据安全
- 加密敏感数据
- 定期备份
- 访问审计 