# docker-shadowsocks-libev
Shadowsocks libev image with obfs.

[shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) version: v3.3.3

[v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin) version: v1.2.0

Useage:

```
docker run -d --restart=always --name shadowsocks-2233 --net=host -e SERVER_PORT=2233 -e PASSWORD=mypassword -e METHOD=chacha20-ietf-poly1305 jpacg/shadowsocks-libev
```

---

Basic
```yaml
version: '3'
services:
  shadowsocks:
    image: jpacg/shadowsocks-libev
    ports:
      - "2233:2233/tcp"
      - "2233:2233/udp"
    environment:
      - SERVER_PORT="2233"
      - METHOD="chacha20-ietf-poly1305"
      - PASSWORD="mypassword"
    restart: always
```

---

Advanced

```yaml
version: '3'
services:
  shadowsocks:
    image: jpacg/shadowsocks-libev
    ports:
      - "2233:2233/tcp"
      - "2233:2233/udp"
    environment:
      - SERVER_PORT="2233"
      - METHOD="chacha20-ietf-poly1305"
      - PASSWORD="mypassword"
      - ARGS="--plugin v2ray-plugin --plugin-opts \"server\""
    restart: always
```
