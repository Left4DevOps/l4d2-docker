#!/bin/bash
yum -y install tar bzip2 gzip unzip \
  glibc.i686 libstdc++ libstdc++.i686 \
  shadow-utils \
  SDL2.i686 SDL2.x86_64

yum -y update --security

useradd louis