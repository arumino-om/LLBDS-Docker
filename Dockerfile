FROM alpine:edge

# Create normal user and change user
ARG USERNAME=dockeruser
ARG GROUPNAME=dockeruser
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID $GROUPNAME && \
    adduser -s /bin/bash -u $UID -G $GROUPNAME $USERNAME -D

# Initialize LiteLoaderBDS
RUN apk add --no-cache wine libc6-compat wget su-exec
ARG lip_version=0.14.0
WORKDIR /server_build

RUN wget https://github.com/LiteLDev/Lip/releases/download/v${lip_version}/lip-${lip_version}-linux-amd64.tar.gz && \
    tar -xvf lip-${lip_version}-linux-amd64.tar.gz && \
    chmod +x lip-${lip_version}-linux-amd64/lip && \
    mkdir bedrock_server && \
    cd bedrock_server && \
    ../lip-${lip_version}-linux-amd64/lip install -y bds && \
    wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/2.14.0-beta.1/LiteLoaderBDS.zip && \
    unzip LiteLoaderBDS.zip && \
    mv LiteLoaderBDS/* ./ && \
    WINEDEBUG=-all wine PeEditor.exe && \
    rm ../lip-${lip_version}-linux-amd64.tar.gz && \
    rm ~/.wine -r

# Finalize
COPY entrypoint.sh /
WORKDIR /server
RUN chown $USERNAME:$GROUPNAME -R /server_build/ && \
    chown $USERNAME:$GROUPNAME /server_build && \
    chown $USERNAME:$GROUPNAME /server
USER $USERNAME
ENV WINEDEBUG=-all
STOPSIGNAL SIGINT
ENTRYPOINT ["sh", "/entrypoint.sh"]
