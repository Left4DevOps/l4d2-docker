#!/bin/bash
# Auto update flag not working on L4D
if [ "${INSTALL_DIR}" = "l4d" ]; then
    ./steamcmd.sh +runscript update.txt
fi

cd "${INSTALL_DIR}" || exit 50

if [ $# -gt 0 ]; then
    ./srcds_run "$@"
else
    STARTUP=("./srcds_run")
    STARTUP+=("+map \"$DEFAULT_MAP $DEFAULT_MODE\"")
    STARTUP+=("+sv_logecho 1")
    STARTUP+=("+hostname \"${HOSTNAME}\"")
    STARTUP+=("+sv_region ${REGION}")
    STARTUP+=("+motd_enabled 0")

    if [ "${INSTALL_DIR}" = "l4d2" ]; then
            STARTUP+=("-autoupdate -steam_dir $HOME -steamcmd_script $HOME/update.txt")
        fi

    if [ -n "${RCON_PASSWORD}" ]; then
        STARTUP+=("+rcon_password \"${RCON_PASSWORD}\"")
    fi

    if [ "${STEAM_GROUP}" -gt 0 ]; then
        STARTUP+=("+sv_steamgroup ${STEAM_GROUP}")
        if [ "${STEAM_GROUP_EXCLUSIVE}" ] ; then
            STARTUP+=("+sv_steamgroup_exclusive 1")
        fi
    fi

    if [ "${NET_CON_PORT:-0}" -gt 0 ]; then
        STARTUP+=("-netconport ${NET_CON_PORT}")
        if [ -n "${NET_CON_PASSWORD}" ]; then
            STARTUP+=("-netconpassword \"${NET_CON_PASSWORD}\"")
        fi
    fi

    if [ "${FORK:-0}" -gt 0 ]; then
        STARTUP+=("-fork ${FORK} +exec server##.cfg")
    else
        STARTUP+=("-port $PORT")
    fi

    ${STARTUP[*]}
fi