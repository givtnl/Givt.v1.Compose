FROM mcr.microsoft.com/dotnet/aspnet:5.0

COPY docker/init_container.sh /bin/
COPY docker/sshd_config /etc/ssh/

RUN echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && chmod 755 /bin/init_container.sh \
    && mkdir -p /home/LogFiles/ \
    && mkdir -p /home/site/wwwroot/ 

#disable the /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/ spam sauges
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 2222 8080

ENV PORT 8080
ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot
ENV ASPNETCORE_URLS=

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/init_container.sh"] 