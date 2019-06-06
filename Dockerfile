FROM arm32v6/alpine:latest

RUN apk add --update tzdata
ENV TZ=Asia/Shanghai

ENV VERSION 0.27.0
ENV PLATFORM arm

WORKDIR /home/root/

COPY frp_${VERSION}_linux_${PLATFORM}.tar.gz .

RUN mkdir frp && \
    tar -zvxf frp_${VERSION}_linux_${PLATFORM}.tar.gz \
    && rm -rf  frp_${VERSION}_linux_${PLATFORM}/system* \
    && cp frp_${VERSION}_linux_${PLATFORM}/* ./frp \
    && rm -rf frp_${VERSION}_linux_*

# Clean APK cache
RUN rm -rf /var/cache/apk/*

RUN mkdir /conf
VOLUME /conf

WORKDIR /home/root/frp/

CMD ["./frpc","-c","/conf/frpc.ini"]
