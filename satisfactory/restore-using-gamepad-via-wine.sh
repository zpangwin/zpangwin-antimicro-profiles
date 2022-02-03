#!/bin/bash
STEAM_APP_ID='526870'
TARGET_GAME_COMPAT_DIR=''

processIsRunning=$(pgrep -ifa 'wine|proton|soldier' 2>/dev/null|grep -Pv '\b(sublime_text|gedit|atom|geany|xed|[bd]ash|[fkz]?sh|fish)\b.*(wine|proton|soldier)'|wc -l);
if [[ 0 != "${processIsRunning}" ]]; then
	echo "E: Wine/proton processes detected. Make sure all game and wine processes are closed and try again."
	exit 1;
fi

STEAM_INSTALL_DIR='';
STEAM_CONFIG_FILE='';
if [[ -f "${HOME}/.steam/config/config.vdf" ]]; then
    STEAM_CONFIG_FILE="${HOME}/.steam/config/config.vdf";

elif [[ -d "${HOME}/.steam" && -L "${HOME}/.steam/steam" && -d "${HOME}/.steam/steam/config" ]]; then
    STEAM_CONFIG_FILE="$(realpath "${HOME}/.steam/steam/config/config.vdf" 2>/dev/null)";

elif [[ -f "${HOME}/.local/share/Steam/config/config.vdf" ]]; then
    STEAM_CONFIG_FILE="${HOME}/local/share/Steam/config/config.vdf";
fi

if [[ -z "${STEAM_CONFIG_FILE}" ]]; then
	echo "E: Unable to find steam's config.vdf file to determine Library folder locations.";
	exit 10;
elif [[ ! ${STEAM_CONFIG_FILE} =~ ^/.*/config/config\.vdf$ ]]; then
	echo "E: Invalid config.vdf file; Unable to determine Library folder locations.";
	exit 11;
fi

STEAM_INSTALL_DIR="$(echo "${STEAM_CONFIG_FILE}"|sed -E 's|/config/config.vdf||g')";
if [[ -z "${STEAM_INSTALL_DIR}" ]]; then
	echo "E: Unable to find main steam install dir.";
	exit 12;
fi

echo "";
echo "STEAM_APP_ID:                     '${STEAM_APP_ID}'";
echo "STEAM_INSTALL_DIR:                '${STEAM_INSTALL_DIR}'";
echo "STEAM_CONFIG_FILE:                '${STEAM_CONFIG_FILE}'";

STEAM_LIBRARY_BASE_DIR_ARRAY=(  );
STEAM_LIBRARY_GAME_DIR_ARRAY=(  );
STEAM_LIBRARY_COMPAT_DIR_ARRAY=(  );

STEAM_LIBRARY_BASE_DIR_ARRAY+=("${STEAM_INSTALL_DIR}");
STEAM_LIBRARY_GAME_DIR_ARRAY+=("${STEAM_INSTALL_DIR}/common");
STEAM_LIBRARY_COMPAT_DIR_ARRAY+=("${STEAM_INSTALL_DIR}/compatdata");
if [[ -d "${STEAM_INSTALL_DIR}/compatdata/${STEAM_APP_ID}/pfx" ]]; then
	TARGET_GAME_COMPAT_DIR="${STEAM_INSTALL_DIR}/compatdata/${STEAM_APP_ID}/pfx";
fi

echo "";
steamDownloadFolder='';
while IFS= read -r steamDownloadFolder; do
    if [[ -z "${steamDownloadFolder}" || ! -d "${steamDownloadFolder}" ]]; then
        #echo "Skipping empty or non-existent steamDownloadFolder";
        continue;
    fi
    echo "  steamDownloadFolder:            '${steamDownloadFolder}'"
    STEAM_LIBRARY_BASE_DIR_ARRAY+=("${steamDownloadFolder}");

    if [[ -d "${steamDownloadFolder}/steamapps/common" && "0" != $(find "${steamDownloadFolder}/steamapps/common" -mindepth 1 -maxdepth 1 -type d 2>/dev/null|wc -l) ]]; then
    	STEAM_LIBRARY_GAME_DIR_ARRAY+=("${steamDownloadFolder}/steamapps/common");
    fi

    if [[ -d "${steamDownloadFolder}/steamapps/compatdata" && "0" != $(find "${steamDownloadFolder}/steamapps/compatdata" -mindepth 1 -maxdepth 1 -type d 2>/dev/null|wc -l) ]]; then
        STEAM_LIBRARY_COMPAT_DIR_ARRAY+=("${steamDownloadFolder}/steamapps/compatdata");

    	if [[ -d "${steamDownloadFolder}/steamapps/compatdata/${STEAM_APP_ID}/pfx" ]]; then
    		TARGET_GAME_COMPAT_DIR="${steamDownloadFolder}/steamapps/compatdata/${STEAM_APP_ID}/pfx";
    	fi
    fi

done < <(grep -P '"BaseInstallFolder_\d"' "${STEAM_CONFIG_FILE}" 2>/dev/null|sed -E 's/^\s*"BaseInstallFolder_[0-9][0-9]*"\s+"([^"]+)"\s*$/\1/g')

echo "";
echo "TARGET_GAME_COMPAT_DIR:           '${TARGET_GAME_COMPAT_DIR}'";
echo "STEAM_CONFIG_FILE:                '${STEAM_CONFIG_FILE}'";
echo "STEAM_LIBRARY_COMPAT_DIR_ARRAY:   '${STEAM_LIBRARY_COMPAT_DIR_ARRAY[@]}'";

if [[ -z "${TARGET_GAME_COMPAT_DIR}" ]]; then
	echo "E: Unable to find compatdata dir for game with steam app id '${STEAM_APP_ID}'.";
	exit 20;
fi

TARGET_REG_FILE="${TARGET_GAME_COMPAT_DIR}/system.reg";

# create backup
cp -a "${TARGET_REG_FILE}" "${TARGET_REG_FILE}.$(date +'%Y-%m-%d_%H%M%S').before-restoring.bak"

hasRegKey="$(grep -Pc '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}")";
hasEnableSDL="$(grep -P '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}" -A 20|grep -Pc '^"Enable SDL"=dword:0000000[01]$')"
isSDLEnabled="$(grep -P '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}" -A 20|grep -Pc '^"Enable SDL"=dword:00000001$')"

if [[ 0 == "${hasRegKey}" ]]; then
	printf '\n[System\\\\CurrentControlSet\\\\Services\\\\winebus] 1641232632\n#time=1d800cb55b24ac6\n"Enable SDL"=dword:00000001\n\n' >> "${TARGET_REG_FILE}";

elif [[ 0 == "${hasEnableSDL}" ]]; then
	# https://unix.stackexchange.com/a/26289/379297
	perl -0777 -i -pe 's/(\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]\s+\d+[\n\r]+#time=\w+)[\n\r]+/$1\n"Enable SDL"=dword:00000001\n/gs' "${TARGET_REG_FILE}"

elif [[ 0 == "${isSDLEnabled}" ]]; then
	sed -Ei 's/^("Enable SDL"=dword):.*$/\1:00000001/g' "${TARGET_REG_FILE}";
fi

hasRegKey="$(grep -Pc '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}")";
hasEnableSDL="$(grep -P '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}" -A 20|grep -Pc '^"Enable SDL"=dword:0000000[01]$')"
isSDLEnabled="$(grep -P '\[System\\\\CurrentControlSet\\\\Services\\\\winebus\]' "${TARGET_REG_FILE}" -A 20|grep -Pc '^"Enable SDL"=dword:00000001$')"
status='FAILED';

if [[ 1 == "${hasRegKey}" && 1 == "${hasEnableSDL}" && 1 == "${isSDLEnabled}" ]]; then
	status='SUCCESS';
fi

echo "";
grep '^"Enable SDL"=dword' "${TARGET_REG_FILE}"
echo "";
echo "${status}: SDL should be enabled, allowing Proton/Wine to pass gamepads through to game process.";
echo "";
