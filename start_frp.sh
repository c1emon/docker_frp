#!/bin/bash

docker run -d \
    -e TYPE=SERVER \
    -v /path/to/conf:/frp/conf
    -p 7000:7000 \
    -p 25565:25565 \
    --name frps \
    clemon1015/frp:0.32.0