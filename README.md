# docker_frp

## You can use this to auto generate a docker image of frp server or client with platform of x86 or arm.

---

edite config in build.sh:

```
USAGE=client
VERSION=0.27.0
TARGET=amd64
DOCKERFILE=Dockerfile
```
USAGE can be client or server.

VERSION and TARGET should match frp.


---
You can run this by run `./build.sh build`
---

## WARNING! 
Because of the sed commond change Dockerfile by line, so you should not edit Dockerfile.


