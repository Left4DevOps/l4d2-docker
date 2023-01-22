#!/bin/bash
yum -y install curl wget \
  tar bzip2 gzip unzip \
  python3 binutils bc jq tmux \
  glibc.i686 libstdc++ libstdc++.i686 \
  shadow-utils util-linux file nmap-ncat iproute \
  SDL2.i686 SDL2.x86_64

yum -y update --security

useradd louis