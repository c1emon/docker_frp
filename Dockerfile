FROM alpine:latest

RUN apk add --update tzdata && RUN rm -rf /var/cache/apk/*
ENV TZ=Asia/Shanghai

ENV VERSION 0.32.0
ENV PLATFORM amd64

WORKDIR /home/root/

COPY frp.tar.gz .

RUN mkdir -p /frp/conf \
    && tar -zvxf frp.tar.gz \
    && mv frp_${VERSION}_linux_${PLATFORM} frp \
    && cp frp/frpc /frp \
    && rm -rf ./frp*

VOLUME /frp/conf

WORKDIR /frp

CMD ["/frp/frpc","-c","/frp/conf/frpc.ini"]
