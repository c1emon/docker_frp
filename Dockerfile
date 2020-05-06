FROM amd64/alpine

RUN apk add --update tzdata && rm -rf /var/cache/apk/*
ENV TZ Asia/Shanghai

ENV VERSION 0.32.0

WORKDIR /frp
COPY start.sh /frp/

RUN wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz -O frp.tar.gz \
    && tar -zvxf frp.tar.gz \
    && cp frp_${VERSION}_linux_amd64/frps /frp \
    && cp frp_${VERSION}_linux_amd64/frpc /frp \
    && rm -rf frp_${VERSION}_linux_* && rm -rf frp.tar.gz \
    && mkdir /frp/conf

VOLUME /frp/conf

CMD ["/frp/start.sh"]