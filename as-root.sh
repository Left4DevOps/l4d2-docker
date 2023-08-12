#!/bin/bash
yum -y install tar gzip \
  libstdc++.i686 SDL2.i686 \
  shadow-utils

yum -y update --security

useradd louis