#!/bin/bash
./steamcmd.sh +runscript update.txt

cd "${INSTALL_DIR}" || exit 50

if [ $# -gt 0 ]; then
    ./srcds_run "$@"
else
    STARTUP=("./srcds_run")
    STARTUP+=("+sv_logecho 1")
    STARTUP+=("+motd_enabled 0")
    STARTUP+=("+hostname \"${HOSTNAME}\"")
    STARTUP+=("+sv_region ${REGION}")

    if [ "${STEAM_GROUP}" -gt 0 ]; then
        STARTUP+=("+sv_steamgroup ${STEAM_GROUP}")
        if [ "${STEAM_GROUP_EXCLUSIVE}" ] ; then
            STARTUP+=("+sv_steamgroup_exclusive 1")
        fi
    fi

    STARTUP+=("+map \"$DEFAULT_MAP $DEFAULT_MODE\"")

    if [ -n "${GAME_TYPES}" ]; then
        STARTUP+=("+sv_gametypes \"${GAME_TYPES}\"")
    fi

    if [ "${FORK:-0}" -gt 0 ]; then
        STARTUP+=("-fork ${FORK} +exec server##.cfg")
    else
        if [ "${PORT:-0}" -gt 0 ]; then
            STARTUP+=("-port $PORT")
        fi
    fi

    if [ "${LAN}" ] ; then
        STARTUP+=("+sv_lan 1")
    fi

    if [ -n "${RCON_PASSWORD}" ]; then
        STARTUP+=("+rcon_password \"${RCON_PASSWORD}\"")
    fi

    if [ "${NET_CON_PORT:-0}" -gt 0 ]; then
        STARTUP+=("-netconport ${NET_CON_PORT}")
        if [ -n "${NET_CON_PASSWORD}" ]; then
            STARTUP+=("-netconpassword \"${NET_CON_PASSWORD}\"")
        fi
    fi

    if [ -n "${EXTRA_ARGS}" ]; then
        STARTUP+=("${EXTRA_ARGS}")
    fi

    ${STARTUP[*]}
fi