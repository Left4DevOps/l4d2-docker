#!/bin/bash
# Install steamcmd
wget https://media.steampowered.com/installer/steamcmd_linux.tar.gz && tar -xzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz && ./steamcmd.sh +quit

# Symlink steamclient.so
mkdir -p .steam/sdk32/ && ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so \
    && mkdir -p .steam/sdk64/ && ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

# Install game
./steamcmd.sh +force_install_dir "./${INSTALL_DIR}" +login anonymous +app_update "${GAME_ID}" +quit