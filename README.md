# docker_frp

## You can use this to auto generate a docker image of frp server or client.

---

## 1. Set
In `Dockerfile` , you can set var VERSION to select frp version.
e.g 
```
VERSION=0.32.0
```
You can check the release of frp on github to get # version.


## 2. Run
Set the correct path to conf files in `start_frp.sh`, also those ports. Then just run.

## P.S.
You can also change different kinds of platforms by just changing the word `amd64` to some others that is avaliable.


