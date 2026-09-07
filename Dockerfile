FROM alpine:3.24

RUN apk add --no-cache openrc openssh \
 && mkdir -p /run/openrc \
 && touch /run/openrc/softlevel \
 && ssh-keygen -A \
 && rc-update add sshd default

EXPOSE 22

CMD ["/sbin/init"]
