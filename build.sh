#!/bin/bash

USAGE=client
VERSION=0.32.0
TARGET=amd64
DOCKERFILE=Dockerfile


get_frp() {
    echo "INFO: start to get frp file."
    if test  -e frp.tar.gz
        then echo "INFO: file frp.tar.gz has exists."
    else
        echo "INFO: start to download frp_${VERSION}_linux_${TARGET}..."
        wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${TARGET}.tar.gz -O frp.tar.gz
        if test  -e frp.tar.gz
            then echo "INFO: download finished."
        else
            echo "ERROR: failed to download and exit!"
        fi
    fi
}

gen_dockerfile() {
    echo "=========INFO:========="
    if [ ${TARGET} == "amd64" -o ${TARGET} == "386" ]; then
        sed -r -i "s/^FROM\s+\w*\/?alpine(:latest)?/FROM alpine:latest/g" ${DOCKERFILE}
        echo "Platform: x86"
    elif [ ${TARGET} == "arm" -o ${TARGET} == "arm64" ]; then
        sed -r -i "s/^FROM\s+\w*\/?alpine(:latest)?/FROM arm32v6\/alpine:latest/g" ${DOCKERFILE}
        echo "Platform: arm"
    else
        echo "ERROR: unknown platform!"
        exit 1
    fi

    sed -r -i "s/^ENV VERSION\s+[0-9].[0-9][0-9].[0-9]$/ENV VERSION ${VERSION}/g" ${DOCKERFILE}
    sed -r -i "s/^ENV PLATFORM\s+\w+$/ENV PLATFORM ${TARGET}/g" ${DOCKERFILE}
    
    if [ ${USAGE} == "client" ]; then
        sed -r -i "s/^(CMD) \[\"\/frp\/frp[c,s]\",\"-c\",\"\/frp\/conf\/frp[c,s].ini\"\]/CMD \[\"\/frp\/frpc\",\"-c\",\"\/frp\/conf\/frpc.ini\"\]/g" ${DOCKERFILE}
        sed -r -i "s/^\s+\&\&\s+cp\s+frp\/frp[c,s]\s+\/frp/    \&\& cp frp\/frpc \/frp/g" ${DOCKERFILE}
        echo "TYPE: client"
    else
        sed -r -i "s/^(CMD) \[\"\/frp\/frp[c,s]\",\"-c\",\"\/frp\/conf\/frp[c,s].ini\"\]/CMD \[\"\/frp\/frps\",\"-c\",\"\/frp\/conf\/frps.ini\"\]/g" ${DOCKERFILE}
        sed -r -i "s/^\s+\&\&\s+cp\s+frp\/frp[c,s]\s+\/frp/    \&\& cp frp\/frps \/frp/g" ${DOCKERFILE}
        echo "TYPE: server"
    fi

    echo "========================"
}

build_image() {
    echo "INFO: start to build docker image: frp-${USAGE}-${TARGET}:${VERSION}"
    docker build -t frp-${USAGE}-${TARGET}:${VERSION} -f ${DOCKERFILE} .
    echo "INFO: finished!"
}



build() {
    get_frp
    gen_dockerfile
    build_image
}

"$@"