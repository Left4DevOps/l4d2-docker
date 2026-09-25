#!/bin/bash
WORKSHOP_FOLDER="/addons/workshop"

get_workshop_id() {
	id=${1##*=}
  echo "$id"
}

check_for_collections() {
	local code
	local source
	code=$(curl -s -o /tmp/workshop.html -w "%{response_code}" "https://steamcommunity.com/sharedfiles/filedetails/?id=${1}")
	source=$(cat /tmp/workshop.html)

	if [ "${code}" -ge 400 ]; then
		echo "A ${code} error occurred"
		return
	fi

	local items
	items=($(echo "${source}" | pup '.collectionItemDetails > a attr{href}'))

	if [ ${#items[@]} -gt 0 ]; then #it's a collection, check for nested collections
		echo "collection - ${1}"
		for item in "${items[@]}"; do
			check_for_collections "$(get_workshop_id "${item}")"
		done
	else # assume item, let's check if we need to download it
		echo "item - ${1}"
		workshopItemTitle=$(echo "${source}" | pup ".workshopItemTitle text{}")
		echo "Downloading ${workshopItemTitle} ${1}"
		bin_path=$(./steamcmd.sh +login ${STEAM_USERNAME} +workshop_download_item 550 "${1}" +quit | grep "Success. " | awk -F'"' '{print $2}')
		if [ ! -f "${WORKSHOP_FOLDER}/${1}.vpk" ]; then
			touch "${bin_path}"
			mv "${bin_path}" "${WORKSHOP_FOLDER}/${1}.vpk"
			ln -s "${WORKSHOP_FOLDER}/${1}.vpk" "${bin_path}"
		fi
	fi
}

if ! ./steamcmd.sh +login ${STEAM_USERNAME} +quit; then
	echo "Could not login as ${STEAM_USERNAME}"
	exit 1
fi

check_for_collections "${WORKSHOP_ITEM}"
