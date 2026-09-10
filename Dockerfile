FROM alpine:3.24

RUN apk add --no-cache openrc openssh \
 && mkdir -p /run/openrc \
 && touch /run/openrc/softlevel \
 && ssh-keygen -A \
 && rc-update add sshd default

 # 告诉 OpenRC 当前运行在 Docker 容器中
RUN printf '%s\n' \
    'rc_sys="docker"' \
    >> /etc/rc.conf

EXPOSE 22

CMD ["/sbin/init"]
