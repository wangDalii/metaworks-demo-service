# 使用 JDK 8 作为基础镜像
FROM openjdk:8-jdk-alpine

# 设置工作目录
WORKDIR /app

# 复制 Maven 构建的 jar 文件
COPY app.jar app.jar

# 设置环境变量
ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# 暴露端口
EXPOSE 8889

# 启动命令
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"] 