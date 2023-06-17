#!/bin/bash
echo "Change user to ${USER_ID}:${GROUP_ID}"
groupadd -g ${GROUP_ID} dockeruser
useradd -m -s /bin/bash -u ${USER_ID} -g {GROUP_ID} dockeruser

if [ -d "/server_build" ]; then
    cp /server_build/* /server/
    rm -r /server_build
    chown ${USER_ID}:${GROUP_ID} -r /server/*
fi

exec /usr/sbin/gosu dockeruser "$@"
cd /server/bedrock_server
wine bedrock_server_mod.exe
