#!/bin/sh


if [ ${TYPE} == "SERVER" ]; then
    echo "[INFO] : Start frp server."
    /frp/frps -c /frp/conf/frps.ini
elif [ ${TYPE} == "CLIENT" ]; then
    echo "[INFO] : Start frp client."
    /frp/frpc -c /frp/conf/frpc.ini
else
    echo "[ERROR] : Unknown type. This environment value TYPE should be SERVER or CLIENT."
fi

echo "[INFO] : Exit."