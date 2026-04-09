# 在 B 机部署目录执行：docker build -t mall/mall-admin:1.0-SNAPSHOT .
# 需与同目录下的 mall-admin-1.0-SNAPSHOT.jar 一起由 Jenkins 传到该目录
FROM openjdk:17

LABEL maintainer="macrozheng"

ENV TZ=Asia/Shanghai \
    SPRING_PROFILES_ACTIVE=prod

ADD mall-admin-1.0-SNAPSHOT.jar /mall-admin-1.0-SNAPSHOT.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/mall-admin-1.0-SNAPSHOT.jar"]
