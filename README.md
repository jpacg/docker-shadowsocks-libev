# docker-shadowsocks-libev
Shadowsocks libev image with obfs.

https://github.com/shadowsocks/shadowsocks-libev

Latest Version: v3.1.0

https://github.com/shadowsocks/simple-obfs

Latest Version: v0.0.4

Useage:

```yaml
version: '2'
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
      - OPTIONS="--plugin obfs-server --plugin-opts obfs=tls;fast-open"
    restart: always
```
