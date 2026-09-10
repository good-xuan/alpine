FROM alpine:3.24

RUN apk update && \
    apk add --no-cache \
        ttyd \
        tini \
        bash \
        coreutils \
        fastfetch

# 1. 确保指定终端类型支持彩色字符与图形
ENV TERM=xterm-256color

# 2. Alpine 默认会读取 /root/.profile，直接写入 .profile 和 .bashrc，确保登录与非登录都能触发
RUN echo 'fastfetch' >> /root/.profile && \
    echo 'fastfetch' >> /root/.bashrc

WORKDIR /root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7681

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 明确启动交互式 shell
CMD ["-W", "-p", "7681", "bash", "-l"]
