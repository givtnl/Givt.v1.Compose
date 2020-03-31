FROM nginx:mainline-alpine-perl

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.6/main" >> /etc/apk/repositories;

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
    && apk add openrc \
    && apk add bash 

EXPOSE 2222 80

#disable the /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/ spam sauges
VOLUME [ "/sys/fs/cgroup" ]

#@maarten unsure als deze in de base image of in de application image moeten
#groetjes Anthony ah yeet
#ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
#ENV WEBSITE_INSTANCE_ID localInstance
#ENV PATH ${PATH}:/home/site/wwwroot

# prepare everything for our shell script
RUN  mkdir -p /usr/local/bin
COPY docker/init_container.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/init_container.sh

COPY docker/sshd_config /etc/ssh/
COPY docker/nginx.conf /etc/nginx/nginx.conf

WORKDIR /home/site/wwwroot
COPY ./default-website ./

ENTRYPOINT ["/usr/local/bin/init_container.sh"]