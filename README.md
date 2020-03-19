# docker_frp

## You can use this to auto generate a docker image of frp server or client for platform of x86 or arm.

---

edite config in build.sh:

```
USAGE=client
VERSION=0.32.0
TARGET=amd64
```
USAGE can be client or server.

VERSION and TARGET should match frp.


---
You can run this by run `./build.sh build`
---
```
USAGE:
docker run -d --restart always -v /dir/of/frp[s,c].ini:/frp/conf --name frp-client frp-client-amd64:0.32.0
```
---

## WARNING!
You should not edit Dockerfile.


