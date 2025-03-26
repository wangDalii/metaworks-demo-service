# 开发指南

## 目录
1. [开发环境搭建](#开发环境搭建)
2. [项目结构说明](#项目结构说明)
3. [开发规范](#开发规范)
4. [接口开发指南](#接口开发指南)
5. [安全开发指南](#安全开发指南)
6. [测试指南](#测试指南)

## 开发环境搭建

### 1. 基础环境要求
- JDK 1.8+
- Maven 3.6+
- IDE (推荐使用 IntelliJ IDEA)
- Git

### 2. 开发工具配置
1. **IDE 配置**
   - 安装 Lombok 插件
   - 配置 Maven 设置
   - 配置编码为 UTF-8

2. **Git 配置**
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

## 项目结构说明

### 1. 核心目录
```
src/main/java/
├── config/          # 配置类
├── controller/      # 控制器
├── service/         # 服务层
├── repository/      # 数据访问层
├── model/          # 数据模型
└── util/           # 工具类
```

### 2. 配置文件
```
src/main/resources/
├── application.yml          # 主配置文件
├── application-dev.yml     # 开发环境配置
└── application-prod.yml    # 生产环境配置
```

## 开发规范

### 1. 代码规范
- 遵循阿里巴巴 Java 开发手册
- 使用统一的代码格式化工具
- 类名使用大驼峰命名法
- 方法名使用小驼峰命名法
- 常量使用全大写下划线分隔

### 2. 注释规范
- 类注释：说明类的用途、作者、创建时间
- 方法注释：说明方法的功能、参数、返回值
- 关键代码注释：说明复杂逻辑的实现思路

### 3. Git 提交规范
提交信息格式：
```
<type>(<scope>): <subject>

<body>

<footer>
```

type 类型：
- feat: 新功能
- fix: 修复bug
- docs: 文档更新
- style: 代码格式调整
- refactor: 重构
- test: 测试相关
- chore: 构建过程或辅助工具的变动

## 接口开发指南

### 1. RESTful API 规范
- 使用 HTTP 方法表示操作类型
- 使用复数名词表示资源集合
- 使用 HTTP 状态码表示请求结果
- 返回统一的响应格式

### 2. 接口文档
- 使用 Swagger 注解编写接口文档
- 及时更新接口文档
- 提供接口调用示例

## 安全开发指南

### 1. 认证授权
- 使用 JWT 进行身份认证
- 实现基于角色的访问控制
- 敏感信息加密存储

### 2. 数据安全
- 使用参数化查询防止 SQL 注入
- 对用户输入进行验证和转义
- 敏感数据加密传输

## 测试指南

### 1. 单元测试
- 使用 JUnit 5 编写单元测试
- 测试覆盖率要求 > 80%
- 关键业务逻辑必须有单元测试

### 2. 接口测试
- 使用 Postman 进行接口测试
- 编写接口测试用例
- 记录测试结果

### 3. 性能测试
- 使用 JMeter 进行性能测试
- 设置合理的性能指标
- 记录性能测试报告

## 常见问题

### 1. 开发环境问题
Q: 如何解决 Maven 依赖下载失败？
A: 检查网络连接，必要时配置国内镜像源。

### 2. 部署问题
Q: 如何修改服务端口？
A: 在 application.yml 中修改 server.port 配置。

### 3. 调试问题
Q: 如何开启调试模式？
A: 在 application-dev.yml 中设置 debug=true。 