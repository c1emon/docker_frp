#!/bin/bash

USAGE=client
VERSION=0.27.0
TARGET=amd64
DOCKERFILE=Dockerfile


get_frp() {
    echo "start to download frp_${VERSION}_linux_${TARGET}..."
    wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${TARGET}.tar.gz -O frp.tar.gz
    if test  -e frp.tar.gz
    then echo "download finish."
    else echo "fail to download!"
    fi
}

gen_dockerfile() {
    if [ ${TARGET} == "amd64" -o ${TARGET} == "386" ]; then
        sed -r -i "s/^FROM\s+\w*\/?alpine:latest$/FROM alpine:latest/g" ${DOCKERFILE}
        echo "target x86 or x86_64."
    elif [ ${TARGET} == "arm" -o ${TARGET} == "arm64" ]; then
        sed -r -i "s/^FROM\s+\w*\/?alpine:latest$/FROM arm32v6\/alpine:latest/g" ${DOCKERFILE}
        echo "target arm or arm64."
    else
        echo "unknown taget!"
    fi

    sed -r -i "s/^ENV VERSION\s+[0-9].[0-9][0-9].[0-9]$/ENV VERSION ${VERSION}/g" ${DOCKERFILE}
    sed -r -i "s/^ENV PLATFORM\s+\w+$/ENV PLATFORM ${TARGET}/g" ${DOCKERFILE}
    
    if [ ${USAGE} == "client" ]; then
        sed -r -i "s/^CMD \[\".\/frp[c,s]\",\"-[c,s]\",\"\/conf\/frp[c,s].ini\"\]$/CMD [\".\/frpc\",\"-c\",\"\/conf\/frpc.ini\"]/g" ${DOCKERFILE}
        echo "build as client."
    else
        sed -r -i "s/^CMD \[\".\/frp[c,s]\",\"-[c,s]\",\"\/conf\/frp[c,s].ini\"\]$/CMD [\".\/frps\",\"-c\",\"\/conf\/frps.ini\"]/g" ${DOCKERFILE}
        echo "build as server."
    fi
}

build_image() {
    echo "start building..."
    docker build -t frp-${USAGE}-${TARGET}:${VERSION} -f ${DOCKERFILE} .
}



build() {
    get_frp
    gen_dockerfile
    build_image
}

"$@"
