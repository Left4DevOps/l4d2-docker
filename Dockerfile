FROM rockylinux:9-minimal AS base

ADD as-root.sh .
RUN ./as-root.sh

WORKDIR /home/louis
USER louis

FROM base AS game

ARG GAME_ID=222860
ARG INSTALL_DIR="l4d2"
ARG DEFAULT_MAP="c14m1_junkyard"

EXPOSE 27015/tcp
EXPOSE 27015/udp

ENV MAP=$DEFAULT_MAP \
    PORT=27015 \
    HOSTNAME="Left4DevOps" \
    REGION=255 \
    GAME_ID=$GAME_ID \
    INSTALL_DIR=$INSTALL_DIR \
    STEAM_GROUP=0

ADD as-user.sh .
RUN ./as-user.sh

ADD entrypoint.sh .
ENTRYPOINT ./entrypoint.sh