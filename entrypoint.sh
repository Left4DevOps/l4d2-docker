#!/bin/bash
# Update Game
./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit

# Server Config
cat > l4d2/left4dead2/cfg/server.cfg <<EOF
hostname ${HOSTNAME}
sv_region ${REGION}
sv_logecho 1
EOF

# Start Game
cd l4d2 && ./srcds_run -console -game left4dead2 -port "$PORT" +maxplayers "$PLAYERS" +map "$MAP"
