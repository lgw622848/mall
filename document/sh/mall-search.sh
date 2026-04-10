#!/usr/bin/env bash
#
# 在 B 机执行：先基于当前目录的 JAR + Dockerfile 构建镜像，再启动容器。
# Jenkins 需将 mall-search-1.0-SNAPSHOT.jar 与本目录 Dockerfile 传到 deploy_dir（见下方变量）。
#
set -euo pipefail

app_name='mall-search'
version='1.0-SNAPSHOT'
image_name="mall/${app_name}:${version}"
deploy_dir="/mydata/app/${app_name}"

docker stop "${app_name}" 2>/dev/null || true
echo '----stop container----'
docker rm "${app_name}" 2>/dev/null || true
echo '----rm container----'

if [[ ! -d "${deploy_dir}" ]]; then
  echo "错误：部署目录不存在: ${deploy_dir}"
  exit 1
fi
if [[ ! -f "${deploy_dir}/${app_name}-${version}.jar" ]]; then
  echo "错误：未找到 ${deploy_dir}/${app_name}-${version}.jar，请先由 Jenkins 上传 JAR"
  exit 1
fi
if [[ ! -f "${deploy_dir}/Dockerfile" ]]; then
  echo "错误：未找到 ${deploy_dir}/Dockerfile，请先由 Jenkins 上传 Dockerfile"
  exit 1
fi

docker build \
  --build-arg "JAR_FILE=${app_name}-${version}.jar" \
  -t "${image_name}" \
  "${deploy_dir}"
echo '----docker build----'

docker image prune -f >/dev/null 2>&1 || true
echo '----prune dangling images (optional)----'

docker run -p 8081:8081 --name "${app_name}" \
  --link mysql:db \
  --link elasticsearch:es \
  -e TZ="Asia/Shanghai" \
  -v /etc/localtime:/etc/localtime \
  -v "/mydata/app/${app_name}/logs:/var/logs" \
  -d "${image_name}"
echo '----start container----'
