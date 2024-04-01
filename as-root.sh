#!/bin/bash
microdnf -y install SDL2.i686 libcurl.i686 glibc-langpack-en tar iptables sudo
microdnf -y update
microdnf clean all

useradd louis
echo "louis ALL=(ALL) NOPASSWD: /usr/sbin/iptables" > /etc/sudoers.d/louis

mkdir /addons /cfg
chown louis:louis /addons /cfg