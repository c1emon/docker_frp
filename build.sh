#!/bin/bash

VERSION=0.27.0
TARGET=amd64


get_frp() {
    echo "start to download frp_${VERSION}_linux_${TARGET}..."
    wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${TARGET}.tar.gz -O frp.tar.gz
    if test  -e frp.tar.gz
    then echo "download finish."
    else echo "fail to download!"
    fi
}



build() {

}

"$@"
