#!/bin/bash
set -e

mkdir -p .steam/sdk32/ .local/bin Steam
ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so
curl https://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xzvf -

ln -s /steamapps Steam/steamapps

cd .local/bin

curl -L https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip -o pup.zip
unzip pup.zip
rm -f pup.zip

mkdir -p /addons/workshop
