# docker-shadowsocks-libev
Shadowsocks libev image with obfs.

https://github.com/shadowsocks/shadowsocks-libev

Latest Version: v3.2.3

https://github.com/shadowsocks/simple-obfs

Latest Version: v0.0.5

Useage:

```yaml
version: '3'
services:
  shadowsocks:
    image: jpacg/shadowsocks-libev
    ports:
      - "8388:8388/tcp"
      - "8388:8388/udp"
    environment:
      - SERVER_PORT="8388"
      - METHOD="chacha20"
      - PASSWORD="mypassword"
      - OPTIONS="--plugin obfs-server --plugin-opts obfs=tls;fast-open;failover=bing.com"
    restart: always
```
