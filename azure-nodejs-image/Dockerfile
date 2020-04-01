FROM node:13-alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories;

RUN mkdir -p /home/LogFiles \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && apk update --no-cache \
    && apk add openssh \
    && apk add openrc \
    && apk add bash \
    && apk add python \
    && apk add make \
    && apk add g++ 

EXPOSE 2222 8080 3000

ENV PORT 8080

#disable the /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/ spam sauges
VOLUME [ "/sys/fs/cgroup" ]

#prepare our default dummy site that says youre a retard when it shows
# hashtag de trut hurts
WORKDIR /home/site/wwwroot
COPY default-website/ .
RUN npm install

#copy the ssh config enzo
COPY docker/sshd_config /etc/ssh/

#prepare our init container script
WORKDIR /app
COPY docker/init_container.sh ./
RUN chmod 755 init_container.sh


ENTRYPOINT ["/app/init_container.sh"]
