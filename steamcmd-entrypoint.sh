#!/bin/bash
if [ "${WORKSHOP_ITEM}" -gt 0 ]; then
  ./workshop-downloader.sh "${WORKSHOP_ITEM}"
else
	./steamcmd.sh "$@"
fi