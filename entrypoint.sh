#!/bin/bash
if [ -d "/server_build" ]; then
    mv /server_build/* /server/
    rm -r /server_build
fi
cd /server/bedrock_server
wine bedrock_server_mod.exe
