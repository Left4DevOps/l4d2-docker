#!/bin/bash
microdnf -y install SDL2.i686 \
    libcurl.i686 \
    glibc-langpack-en \
    tar \
    telnet
microdnf -y update
microdnf clean all

useradd louis

mkdir /addons /cfg /tmp/dumps
chown louis:louis /addons /cfg /tmp/dumps