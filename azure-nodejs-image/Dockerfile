FROM node:13-alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.11/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.11/main" >> /etc/apk/repositories;

COPY docker/init_container.sh /bin/
COPY docker/sshd_config /etc/ssh/

RUN echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && mkdir -p /home/LogFiles \
    && apk update --no-cache \
    && apk add openssh \
    && ssh-keygen -A \
    && chmod 755 /bin/init_container.sh \
    && apk add bash 

#disable the /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/ spam sauges
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

COPY ./default-website /home/site/wwwroot/default-website/
WORKDIR /home/site/wwwroot/default-website/
RUN npm install

ENTRYPOINT ["/bin/init_container.sh"]
