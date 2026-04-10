# 通用 Spring Boot 镜像：通过构建参数 JAR_FILE 指定要打入的 jar（与部署目录中的文件名一致）。
#
# 示例：
#   docker build --build-arg JAR_FILE=mall-admin-1.0-SNAPSHOT.jar -t mall/mall-admin:1.0-SNAPSHOT .
#   docker build --build-arg JAR_FILE=mall-portal-1.0-SNAPSHOT.jar -t mall/mall-portal:1.0-SNAPSHOT .
#   docker build --build-arg JAR_FILE=mall-search-1.0-SNAPSHOT.jar -t mall/mall-search:1.0-SNAPSHOT .
#
# 若构建时出现 429：错峰 docker pull，或调整本机 Docker registry-mirrors。
FROM tkdue63hmyvk42axmc.xuanyuan.run/library/eclipse-temurin:17-jre-jammy

ARG JAR_FILE=mall-admin-1.0-SNAPSHOT.jar

LABEL maintainer="lgw"

ENV TZ=Asia/Shanghai \
    SPRING_PROFILES_ACTIVE=prod

# 统一打为 /application.jar，避免 ENTRYPOINT 随模块名变化
COPY ${JAR_FILE} /application.jar

# 各服务端口由应用配置决定；此处列出常用端口仅作文档说明
EXPOSE 8080 8085 8081

ENTRYPOINT ["java", "-jar", "/application.jar"]
