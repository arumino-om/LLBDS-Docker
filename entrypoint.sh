#!/bin/bash
echo "Create user: ${USER_ID}:${GROUP_ID}"
addgroup -g ${GROUP_ID} dockeruser
adduser -s /bin/bash -u ${USER_ID} -g {GROUP_ID} dockeruser

if [ -d "/server_build" ]; then
    cp /server_build/* /server/
    rm -r /server_build
    chown ${USER_ID}:${GROUP_ID} -R /server/*
fi

exec su-exec dockeruser "$@"
cd /server/bedrock_server
wine bedrock_server_mod.exe
