#!/usr/bin/env bash

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

# Starting nginx
mkdir -p /home/LogFiles/nginx
# this line is required or else it will error a while when running ze container
if test ! -e /home/LogFiles/nginx/error.log; then 
    touch /home/LogFiles/nginx/error.log
fi

#start ssh service
/usr/sbin/sshd

#disable the can't open /dev/tty1: No such file or directory spam sausages
ln -sf /dev/null /dev/tty1
ln -sf /dev/null /dev/tty2
ln -sf /dev/null /dev/tty3
ln -sf /dev/null /dev/tty4
ln -sf /dev/null /dev/tty5
ln -sf /dev/null /dev/tty6

cd /home/site/wwwroot
[ -e "package.json" ] && exec npm start

exec node default-website/default-static-site.js
