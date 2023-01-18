#!/usr/bin/env bash

StartDate=$(date +"%s")
sleep 10;
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

STATUS=1
while [ $STATUS -ne 0 ]
do
    rconc cdmd tellraw @a '["",{"text":"[Backup]","color":"dark_purple"},{"text":" Backup finalizado"}," ",{"text": "('"$Time"')", "color": "dark_gray"}]'
    STATUS=$?
    sleep 1
done