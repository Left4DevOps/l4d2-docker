#!/bin/bash
docker build -t left4devops/l4d \
  --build-arg GAME_ID=222840 \
  --build-arg INSTALL_DIR="l4d" \
  --build-arg DEFAULT_MAP="l4d_river01_docks" \
  .