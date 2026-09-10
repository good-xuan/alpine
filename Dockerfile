FROM alpine:3.24

RUN apk update && \
    apk add --no-cache \
        ttyd \
        tini \
        fish \
        coreutils \
        fastfetch

# 1. 确保指定终端类型支持彩色字符与图形
ENV TERM=xterm-256color


RUN echo 'fastfetch' >> /root/.profile 

WORKDIR /root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 7681

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# 明确启动交互式 shell
CMD ["-W", "-p", "7681", "fish", "-l"]
