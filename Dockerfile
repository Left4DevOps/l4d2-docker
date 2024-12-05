FROM rockylinux/rockylinux:9-minimal AS base

ADD as-root.sh .
RUN ./as-root.sh

WORKDIR /home/louis
USER louis

FROM base AS game

ARG GAME_ID=222860
ARG INSTALL_DIR="l4d2"
ARG DEFAULT_MAP="c14m1_junkyard"
ARG STEAM_USER=anonymous

EXPOSE 27015/tcp 27015/udp

ADD as-user.sh .
RUN --mount=type=secret,uid=1000,gid=1000,id=steam,target=/home/louis/Steam/config/config.vdf \
    ./as-user.sh

VOLUME ["/addons", "/cfg"]

ENV DEFAULT_MAP=$DEFAULT_MAP \
    DEFAULT_MODE="coop" \
    PORT=0 \
    HOSTNAME="Left4DevOps" \
    REGION=255 \
    GAME_ID=$GAME_ID \
    INSTALL_DIR=$INSTALL_DIR \
    STEAM_GROUP=0

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
