#!/bin/bash
yum -y install libstdc++.i686 SDL2.i686 glibc-langpack-en

yum -y update --security

useradd louis