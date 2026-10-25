# DevOpsHelper 实验基础镜像：预装常用服务与排查工具
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    TERM=xterm-256color

RUN apt-get update && apt-get install -y --no-install-recommends \
        nginx \
        openssh-server openssh-client sshpass \
        redis-server \
        cron \
        curl wget vim less nano \
        net-tools iproute2 iputils-ping dnsutils traceroute tcpdump \
        lsof sysstat procps psmisc \
        mysql-client \
        jq bc \
        sudo file zip unzip gzip tar \
        logrotate \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/log/app /opt/app /backup /run/sshd \
    && echo 'root:devops123' | chpasswd

# 非交互式终端提示
RUN echo 'export PS1="\[\e[1;32m\]\u@lab\[\e[0m\]:\w# "' >> /root/.bashrc
