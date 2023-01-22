#!/bin/bash

# Update Game
./steamcmd.sh +force_install_dir "./${INSTALL_DIR}" +login anonymous +app_update "${GAME_ID}" +quit
cd "${INSTALL_DIR}" || exit 50

# Server Config
if [ "${INSTALL_DIR}" = "l4d2" ]; then
    CONFIG_DIR="left4dead2/cfg"
elif [ "${INSTALL_DIR}" = "l4d" ]; then
    CONFIG_DIR="left4dead/cfg"
else
  exit 100
fi
CONFIG_FILE="${CONFIG_DIR}/server.cfg"
if [ -f "${CONFIG_FILE}" ]; then
    echo "server.cfg already exists"
else
    cat > "${CONFIG_FILE}" <<EOF
hostname "${HOSTNAME}"
sv_region ${REGION}
sv_logecho 1
motd_enabled 0
EOF
    if [ -n "${RCON_PASSWORD}" ]; then
        echo "rcon_password \"${RCON_PASSWORD}\"" >> "${CONFIG_FILE}"
    fi
fi


# Start Game
if [ $# -eq 0 ]; then
    ./srcds_run -port "$PORT" +map "$MAP"
else
    ./srcds_run "$@"
fi

