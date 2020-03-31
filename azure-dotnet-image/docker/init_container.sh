#!/usr/bin/env bash
service ssh start

[ -z "$ASPNETCORE_URLS" ] && export ASPNETCORE_URLS=http://*:"$PORT"

cd /home/site/wwwroot/

exec dotnet hostingstart.dll
