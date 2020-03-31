FROM mcr.microsoft.com/dotnet/core/runtime:3.1

COPY docker/init_container.sh /bin/
COPY docker/sshd_config /etc/ssh/

RUN apt-get update \
    && apt-get install -y apt-utils --no-install-recommends \
    && echo "root:Docker!" | chpasswd \
    && echo "cd /home" >> /etc/bash.bashrc \
    && apt update \
    && apt install -y --no-install-recommends openssh-server \
    && chmod 755 /bin/init_container.sh \
    && mkdir -p /home/LogFiles/ 

EXPOSE 2222 8080

ENV PORT 8080

COPY default-website/ /home/site/wwwroot/

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/bin/init_container.sh"] 