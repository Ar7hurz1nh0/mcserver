#!/usr/bin/env bash

function execute() {
    local STATUS=1
    while [ $STATUS -ne 0 ]
    do
        # shellcheck disable=SC2068
        rconc cdmd $@
        STATUS=$?
        sleep .5
    done
}

execute save-all
sleep 5;
execute tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Realizando backup e sincronização do servidor, ele pode lagar um pouco durante o processo"}]'
execute tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Iniciando backup"}]'

readonly SOURCE_DIR="/mnt/d/etec/cdmd+1.19/world"
readonly BACKUP_DIR="/mnt/d/etec/cdmd+1.19/backup"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly DATETIME
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly SYNC_PATH="world-link/"
readonly LATEST_LINK="${BACKUP_DIR}/latest"
StartDate=$(date +"%s")

mkdir -p "${BACKUP_DIR}"

rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  "${BACKUP_PATH}"

rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"

FinalDate=$(date +"%s")

Diff="0 $FinalDate seconds - $StartDate seconds"

Hour=$(date -u -d "$Diff" +"%-H")
Min=$(date -u -d "$Diff" +"%-M")
Sec=$(date -u -d "$Diff" +"%-S")

Time="none"
if [ "$Hour" -gt 0 ]; then
    Time="$Hour""h $Min""m $Sec""s"
elif [ "$Min" -gt 0 ]; then
    Time="$Min""m $Sec""s"
else
    Time="$Sec""s"
fi

execute tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Backup finalizado"}, " ",{"text": "('"$Time"')", "color": "dark_gray"}]'

execute tellraw @a '["",{"text":"[Backup]","color":"blue"},{"text":" Iniciando sincronização"}]'

StartDate=$(date +"%s")

rsync -av --delete "${SOURCE_DIR}/*" "${SYNC_PATH}"

FinalDate=$(date +"%s")

Diff="0 $FinalDate seconds - $StartDate seconds"

Hour=$(date -u -d "$Diff" +"%-H")
Min=$(date -u -d "$Diff" +"%-M")
Sec=$(date -u -d "$Diff" +"%-S")

Time="none"
if [ "$Hour" -gt 0 ]; then
    Time="$Hour""h $Min""m $Sec""s"
elif [ "$Min" -gt 0 ]; then
    Time="$Min""m $Sec""s"
else
    Time="$Sec""s"
fi

execute tellraw @a '["",{"text":"[Backup]","color":"blue"},{"text":" Sincronização finalizada"}, " ",{"text": "('"$Time"')", "color": "dark_gray"}]'