#!/bin/bash
# Convenient symlinks for mount points
if [ "${INSTALL_DIR}" = "l4d2" ]; then
    GAME_DIR="${INSTALL_DIR}/left4dead2"
elif [ "${INSTALL_DIR}" = "l4d" ]; then
    GAME_DIR="${INSTALL_DIR}/left4dead"
else
    exit 100
fi

mkdir -p ./"${GAME_DIR}"
ln -s /addons "./${GAME_DIR}/addons"
ln -s /cfg    "./${GAME_DIR}/cfg"

# Install steamcmd
mkdir -p .steam/sdk32/
ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so
curl https://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xzvf -

# Install game
echo """force_install_dir "/home/louis/${INSTALL_DIR}"
login ${STEAM_USER}
app_update ${GAME_ID}
quit""" > update.txt
./steamcmd.sh +runscript update.txt