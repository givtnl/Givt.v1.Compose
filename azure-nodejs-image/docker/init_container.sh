#!/usr/bin/env bash

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

# Ensure this happens after /sbin/init
# why sleep 5 and in dotnet image 8 ?
( sleep 5 ; /etc/init.d/sshd restart ) &

# start the default sait
exec node /home/site/wwwroot/default-static-site.js

#disable the can't open /dev/tty1: No such file or directory spam sausages
ln -sf /dev/null /dev/tty1
ln -sf /dev/null /dev/tty2
ln -sf /dev/null /dev/tty3
ln -sf /dev/null /dev/tty4
ln -sf /dev/null /dev/tty5
ln -sf /dev/null /dev/tty6

# Needs to start as PID 1 for openrc on alpine
exec -c /sbin/init 
