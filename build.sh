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
        sed -i '1c FROM alpine:latest' ${DOCKERFILE}
        echo "target x86 or x86_64."
    elif [ ${TARGET} == "arm" -o ${TARGET} == "arm64" ]; then
        sed -i '1c FROM arm32v6/alpine:latest' ${DOCKERFILE}
        echo "target arm or arm64."
    else
        echo "unknown taget!"
    fi

    sed -i "6c ENV VERSION ${VERSION}" ${DOCKERFILE}
    sed -i "7c ENV PLATFORM ${TARGET}" ${DOCKERFILE}

    
    if [ ${USAGE} == "client" ]; then
        sed -i '27c CMD ["./frpc","-c","/conf/frpc.ini"]' ${DOCKERFILE}
        echo "build as client."
    else
        sed -i '27c CMD ["./frps","-c","/conf/frps.ini"]' ${DOCKERFILE}
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
