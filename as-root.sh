#!/bin/bash
microdnf -y install SDL2.i686 \
    libcurl.i686 \
    glibc-langpack-en \
    tar
microdnf -y update
microdnf clean all

useradd louis

mkdir             /addons /cfg /motd /tmp/dumps /steamapps
chown louis:louis /addons /cfg /motd /tmp/dumps /steamapps