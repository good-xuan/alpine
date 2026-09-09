FROM alpine:3.19

# 下载 Forego 独立静态二进制
ADD https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.tgz /tmp
RUN tar -xzf /tmp/forego-stable-linux-amd64.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/forego && \
    rm -rf /tmp/*

WORKDIR /app

# 内联生成 Procfile（包含两个常驻的空载测试进程）
RUN printf "app1: sleep infinity\napp2: sh -c 'while true; do echo app2 ping; sleep 5; done'\n" > /app/Procfile

ENTRYPOINT ["/usr/local/bin/forego", "start", "-r"]
