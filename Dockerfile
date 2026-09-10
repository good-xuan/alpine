FROM alpine:3.24

# 直接从 Alpine 官方仓库安装 ttyd、tini 及常用终端环境
RUN apk update && \
    apk add --no-cache \
        ttyd \
        tini \
        bash \
        coreutils

WORKDIR /root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7681

# 入口脚本接管凭证生成与服务启动
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 默认开启可写终端并启动 bash
CMD ["-W", "-p", "7681", "bash"]
