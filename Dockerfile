FROM alpine:3.24

# 安装 runit
RUN apk add --no-cache runit

# 内联创建服务目录及 run 脚本，并赋执行权限
RUN mkdir -p /etc/service/app1 /etc/service/app2 && \
    printf '#!/bin/sh\nexec 2>&1\necho "app1 start"\nexec sleep infinity\n' > /etc/service/app1/run && \
    printf '#!/bin/sh\nexec 2>&1\nwhile true; do echo "app2 heartbeat"; sleep 5; done\n' > /etc/service/app2/run && \
    chmod +x /etc/service/app1/run /etc/service/app2/run

ENTRYPOINT ["runsvdir", "-P", "/etc/service"]
