FROM left4devops/steamcmd AS download
ARG STEAM_USER=anonymous
RUN --mount=type=secret,uid=1000,gid=1000,id=steam,target=/home/louis/Steam/config/config.vdf \
    ./steamcmd.sh +login $STEAM_USER +app_update 222860 +quit

FROM rockylinux/rockylinux:9-minimal AS server

ADD as-root.sh .
RUN ./as-root.sh

WORKDIR /home/louis
USER louis

COPY --chown=louis:louis --from=download "/steamapps" "/steamapps"

ARG GAME_ID=222860 \
    INSTALL_DIR="l4d2" \
    DEFAULT_MAP="c14m1_junkyard"

EXPOSE 27015/tcp 27015/udp

ADD as-user.sh .
RUN ./as-user.sh

VOLUME ["/addons", "/cfg"]

ENV DEFAULT_MAP=$DEFAULT_MAP \
    DEFAULT_MODE="coop" \
    PORT=0 \
    HOSTNAME="Left4DevOps" \
    REGION=255 \
    GAME_ID=$GAME_ID \
    INSTALL_DIR=$INSTALL_DIR \
    STEAM_GROUP=0 \
    HOST_CONTENT="" \
    MOTD_CONTENT="Play nice, kill zombies" \
    MOTD=0

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
