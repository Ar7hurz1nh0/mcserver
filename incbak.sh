#!/usr/bin/env bash
STATUS=1
while [ $STATUS -ne 0 ]
do
    rconc cdmd save-all
    STATUS=$?
    sleep 1
done
sleep 5;
STATUS=1
while [ $STATUS -ne 0 ]
do
    rconc cdmd tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Backup em andamento, o servidor pode lagar um pouquinho"}]'
    STATUS=$?
    sleep 1
done

readonly SOURCE_DIR="/mnt/d/etec/cdmd+1.19/world"
readonly BACKUP_DIR="/mnt/d/etec/cdmd+1.19/backup"
DATETIME="$(date '+%Y-%m-%d_%H:%M:%S')"
readonly DATETIME
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"
StartDate=$(date +"%s")
readonly StartDate

mkdir -p "${BACKUP_DIR}"

rsync -av --delete \
  "${SOURCE_DIR}/" \
  --link-dest "${LATEST_LINK}" \
  "${BACKUP_PATH}"

rm -rf "${LATEST_LINK}"
ln -s "${BACKUP_PATH}" "${LATEST_LINK}"

FinalDate=$(date +"%s")
readonly FinalDate

readonly Diff="0 $FinalDate seconds - $StartDate seconds"

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

STATUS=1
while [ $STATUS -ne 0 ]
do
    rconc cdmd tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Backup finalizado"}, " ",{"text": "('"$Time"')", "color": "dark_gray"}]'
    STATUS=$?
    sleep 1
done