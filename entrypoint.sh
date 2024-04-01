#!/bin/bash

# DoS Protection - https://github.com/ValveSoftware/Source-1-Games/issues/5141 / https://old.reddit.com/r/l4d2/comments/19cajdi/are_your_games_lagging_having_trouble/
sudo iptables -I DOCKER-USER -p udp --dport $PORT -m length --length 0:28 -j DROP && sudo iptables -I DOCKER-USER -p udp --dport $PORT -m length --length 2521:65535 -j DROP
if [ $? -eq 0 ]; then
    echo "Added DoS protection"
else
    echo "Did not add DoS protection, may not have --cap-add=NET_ADMIN"
fi

cd "${INSTALL_DIR}" || exit 50

# Server Config
CONFIG_FILE="/cfg/server.cfg"
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
    if [ "${STEAM_GROUP}" -gt 0 ]; then
        echo "sv_steamgroup ${STEAM_GROUP}" >> "${CONFIG_FILE}"
        if [ "${STEAM_GROUP_EXCLUSIVE}" ] ; then
          echo "sv_steamgroup_exclusive 1" >> "${CONFIG_FILE}"
        fi
    fi
fi

# Start Game
if [ $# -eq 0 ]; then
    ./srcds_run -autoupdate -steam_dir ~ -steamcmd_script ~/update.txt -port "$PORT" +map "$MAP"
else
    ./srcds_run "$@"
fi

