#!/bin/bash
docker build --progress plain -t left4devops/l4d2 \
    --build-arg STEAM_USER="${STEAM_USER:-anonymous}" \
    --secret id=steam,src=config.vdf \
    .