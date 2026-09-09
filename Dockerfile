FROM alpine:3.24

ARG S6_OVERLAY_VERSION=3.2.3.2

# Alpine 必须安装 xz 才能解压 .tar.xz 格式
RUN apk add --no-cache xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && rm -f /tmp/s6-overlay-noarch.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz && rm -f /tmp/s6-overlay-x86_64.tar.xz

ENTRYPOINT ["/init"]
