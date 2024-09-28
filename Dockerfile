FROM rockylinux/rockylinux:9-minimal AS base

ADD as-root.sh .
RUN ./as-root.sh

WORKDIR /home/louis
USER louis

FROM base AS game

ARG GAME_ID=222860 \
    INSTALL_DIR="l4d2" \
    DEFAULT_MAP="c14m1_junkyard" \
    HOST_BANNER="http://www.l4d.com/l4d2_servermessage/banner.htm" \
    MOTD="https://www.l4d.com/l4d2_servermessage/index.htm"

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
    HOST_BANNER=$HOST_BANNER \
    MOTD=$MOTD \
    MOTD_ENABLED=0

ADD entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
