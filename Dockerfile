FROM alpine
LABEL jpacg <jpacg@jpacg.me>

ARG SS_VER=3.3.3
ARG SS_OBFS_VER=1.2.0

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 2233
ENV PASSWORD=
ENV METHOD      chacha20-ietf-poly1305
ENV TIMEOUT     300
ENV DNS_ADDRS   8.8.8.8,8.8.4.4
ENV ARGS=

RUN set -ex && \
    apk add --no-cache udns && \
    apk add --no-cache --virtual .build-deps \
                                git \
                                autoconf \
                                automake \
                                make \
                                build-base \
                                curl \
                                libev-dev \
                                c-ares-dev \
                                libtool \
                                linux-headers \
                                libsodium-dev \
                                mbedtls-dev \
                                pcre-dev \
                                tar \
                                udns-dev && \
    cd /tmp/ && \
    git clone https://github.com/shadowsocks/shadowsocks-libev.git && \
    cd shadowsocks-libev && \
    git checkout v$SS_VER && \
    git submodule update --init --recursive && \
    ./autogen.sh && \
    ./configure --prefix=/usr --disable-documentation && \
    make install && \
    cd /tmp/ && \
    wget -c -O v2ray-plugin-linux-amd64-v$SS_OBFS_VER.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/v$SS_OBFS_VER/v2ray-plugin-linux-amd64-v$SS_OBFS_VER.tar.gz && \
    tar xzf v2ray-plugin-linux-amd64-v$SS_OBFS_VER.tar.gz && \
    mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin && \
    chmod +x /usr/bin/v2ray-plugin && \
    cd .. && \
    runDeps="$( \
        scanelf --needed --nobanner /usr/bin/ss-* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/*


EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp

CMD exec ss-server \
        -s $SERVER_ADDR \
        -p $SERVER_PORT \
        -k ${PASSWORD:-$(hostname)} \
        -m $METHOD \
        -t $TIMEOUT \
        -d $DNS_ADDRS \
        -u \
        $ARGS
