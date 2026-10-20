FROM alpine:latest

# 安装 OpenSSH 并生成主机密钥
RUN apk add --no-cache openssh-server && \
    ssh-keygen -A


# 写入公钥并设置权限
RUN mkdir -p /root/.ssh && \
    echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMWCv+Vmqps/8ZnrQLWHWpz/gYcJV0329bLIAgsGyr9O sftp@sftp" > /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
