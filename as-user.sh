#!/bin/bash
# Install steamcmd
curl https://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xzvf -
./steamcmd.sh +quit

# Symlink steamclient.so
mkdir -p .steam/sdk32/ .steam/sdk64/
ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so
ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

# Install game
./steamcmd.sh +force_install_dir "./${INSTALL_DIR}" +login anonymous +app_update "${GAME_ID}" +quit