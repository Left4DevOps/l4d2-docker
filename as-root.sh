#!/bin/bash
microdnf -y install SDL2.i686 glibc-langpack-en tar
microdnf -y update
microdnf clean all

useradd louis

mkdir /addons /cfg
chown louis:louis /addons /cfg