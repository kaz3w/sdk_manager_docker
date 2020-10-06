#!/bin/bash
echo "PROXY=" "${http_proxy}"
case ${http_proxy} in 
"0.0.0.0") 
    echo "NO_PROXY";; 
*) 
    touch /etc/apt/apt.conf
    echo "Acquire::http::proxy \"${APT_PROXY}\";" > /etc/apt.apt.conf
    echo "Acquire::https::proxy	\"${APT_PROXY}\";" >> /etc/apt/apt.conf
    echo "Acquire::ftp::proxy	\"${APT_PROXY}\";" >> /etc/apt/apt.conf;; 
esac