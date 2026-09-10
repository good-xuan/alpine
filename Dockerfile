FROM alpine:3.24

# 开启 community 仓库并安装 ttyd、fastfetch 等依赖
RUN apk update && \
    apk add --no-cache \
        ttyd \
        tini \
        bash \
        coreutils \
        fastfetch

# 在进入终端时自动运行 fastfetch
RUN echo 'fastfetch' >> /root/.bashrc

WORKDIR /root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7681

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 关键：加上 --login 参数，确保每次 Web 终端接入时都会以登录 Shell 读取 .bashrc
CMD ["-W", "-p", "7681", "bash", "--login"]
