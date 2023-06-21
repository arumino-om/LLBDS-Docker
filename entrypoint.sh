#!/bin/bash
if [ -d "/server_build" ]; then
    mv /server_build/* /server/
fi

cd /server/bedrock_server
exec wine bedrock_server_mod.exe
