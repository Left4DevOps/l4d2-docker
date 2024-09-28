#!/bin/bash
docker build --progress plain -t left4devops/l4d \
  --build-arg GAME_ID=222840 \
  --build-arg INSTALL_DIR="l4d" \
  --build-arg DEFAULT_MAP="l4d_river01_docks" \
  --build-arg HOST_BANNER="Left 4 DevOps" \
  --build-arg MOTD="Left 4 DevOps" \
  .