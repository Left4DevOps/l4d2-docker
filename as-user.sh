#!/bin/bash
# Install steamcmd
mkdir -p .steam/sdk32/
ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so
curl https://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xzvf -

# Convenient symlinks for mount points
if [ "${INSTALL_DIR}" = "l4d2" ]; then
    GAME_DIR="Steam/steamapps/common/Left 4 Dead 2 Dedicated Server/"
    ln -s "${GAME_DIR}" "./${INSTALL_DIR}"
    GAME_DIR=${GAME_DIR}left4dead2/
elif [ "${INSTALL_DIR}" = "l4d" ]; then
    GAME_DIR="Steam/steamapps/common/Left 4 Dead Dedicated Server/"
    ln -s "${GAME_DIR}" "./${INSTALL_DIR}"
    GAME_DIR=${GAME_DIR}left4dead/
else
    exit 100
fi

mkdir -p Steam
ln -s /steamapps Steam/steamapps

mv "./${GAME_DIR}/addons/"* /addons
rm -rf "./${GAME_DIR}/addons/"
ln -s /addons/ "./${GAME_DIR}/"

mv "./${GAME_DIR}/cfg/"* "/cfg"
rm -rf "./${GAME_DIR}/cfg/"
ln -s /cfg/ "./${GAME_DIR}/"

ln -s /motd/host.txt  "./${GAME_DIR}/myhost.txt"
ln -s /motd/motd.txt  "./${GAME_DIR}/mymotd.txt"

# Update game
echo """
login anonymous
app_update ${GAME_ID}
quit""" > update.txt
./steamcmd.sh +runscript update.txt