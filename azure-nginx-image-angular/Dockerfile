FROM nginx:mainline-alpine-perl

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.10/main" >> /etc/apk/repositories;

COPY docker/init_container.sh /bin/
COPY docker/sshd_config /etc/ssh/
COPY docker/nginx.conf /etc/nginx/nginx.conf

RUN echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && mkdir -p /var/www \
    && chown -R nginx:nginx /var/www \	
    && rm -rf /var/log/nginx \
    && mkdir -p /home/LogFiles \
    && ln -s /home/LogFiles/nginx /var/log/nginx \
    && ln -s /home/site/wwwroot /var/www/ \
    && apk update --no-cache \
    && apk add openssh \
    && ssh-keygen -A \
    && chmod 755 /bin/init_container.sh \
    && apk add bash 

#disable the /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/ spam sauges
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 2222 80

ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/init_container.sh"]