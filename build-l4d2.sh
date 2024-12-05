#!/bin/bash
docker build \
  -t left4devops/l4d2 \
  --progress plain \
  --secret id=steam,src="$(pwd)/config.vdf" \
  --build-arg STEAM_USER="${STEAM_USER}" \
  .