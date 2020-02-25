FROM debian:buster-slim

ENV MINECRAFT_BE_VERSION=1.14.30.2

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        openssl \
        ca-certificates \
        libcurl4-openssl-dev \
        unzip \
        wget \
    ; \
    wget -q -O /bedrock-server.zip https://minecraft.azureedge.net/bin-linux/bedrock-server-$MINECRAFT_BE_VERSION.zip ; \
    unzip -q /bedrock-server.zip -d /minecraft-be; \
    rm -f /bedrock-server.zip; \
    apt-get purge -y --auto-remove \
        wget \
        unzip \
    ; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /minecraft-be

EXPOSE 19132

ENV PATH="/minecraft-be:${PATH}"
ENV LD_LIBRARY_PATH="."

CMD [ "bedrock_server" ]
