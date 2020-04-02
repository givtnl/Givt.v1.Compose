#!/usr/bin/env bash

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

# start ssh service
service ssh start

[ -z "$ASPNETCORE_URLS" ] && export ASPNETCORE_URLS=http://*:"$PORT"

cd /home/site/wwwroot/
[ -e "$DLL" ] && exec dotnet "$DLL"

echo Could not find .dll

exec /bin/bash