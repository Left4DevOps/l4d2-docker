FROM amazonlinux:2

RUN yum -y install curl wget tar bzip2 gzip unzip python3 binutils bc jq tmux glibc.i686 libstdc++ libstdc++.i686 \
    shadow-utils util-linux file nmap-ncat iproute SDL2.i686 SDL2.x86_64 \
    && yum -y update --security

RUN useradd louis
WORKDIR /home/louis
USER louis

RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && tar -xzf steamcmd_linux.tar.gz \
    && rm steamcmd_linux.tar.gz && ./steamcmd.sh +quit
RUN mkdir -p .steam/sdk32/ && ln -s ~/linux32/steamclient.so ~/.steam/sdk32/steamclient.so \
    && mkdir -p .steam/sdk64/ && ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
RUN ./steamcmd.sh +login anonymous +force_install_dir ./l4d2 +app_update 222860 +quit

EXPOSE 27015/tcp
EXPOSE 27015/udp
ENV PORT=27015 \
    PLAYERS=8 \
    MAP="c14m1_junkyard" \
    REGION=255 \
    HOSTNAME="Left4DevOps L4D2"

ADD entrypoint.sh entrypoint.sh
ENTRYPOINT ./entrypoint.sh
