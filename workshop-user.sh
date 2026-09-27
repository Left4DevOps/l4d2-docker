#!/bin/bash
set -e

mkdir -p .local/bin
cd .local/bin

curl -L https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip -o pup.zip
unzip pup.zip
rm -f pup.zip
mkdir -p /addons/workshop
chown -R louis:louis /addons