#!/usr/bin/env bash

# Crontab list
# 0 */6 * * * /mnt/d/etec/cdmd+1.19/backup.sh
# 0 */1 * * * /mnt/d/etec/cdmd+1.19/incbak.sh

# crontab -l | sed "/^[^#].*\/mnt\/d\/etec\/cdmd+1.19\/incbak.sh/s/^/#/" | crontab -
# crontab -l | sed "/^[^#].*\/mnt\/d\/etec\/cdmd+1.19\/backup.sh/s/^/#/" | crontab -
java \
  -XX:+UseG1GC \
  -XX:+UnlockExperimentalVMOptions \
  -XX:InitiatingHeapOccupancyPercent=24 \
  -XX:ConcGCThreads=4 \
  -XX:G1HeapRegionSize=128M \
  -XX:G1HeapWastePercent=1 \
  -XX:G1MixedGCLiveThresholdPercent=65 \
  -XX:G1RSetUpdatingPauseTimePercent=4 \
  -XX:G1ConcRefinementThreads=4 \
  -XX:+AlwaysPreTouch \
  -Xmx14G \
  -jar fabric-server-launch.jar nogui
# crontab -l | sed "/^#.*\/mnt\/d\/etec\/cdmd+1.19\/incbak.sh/s/^#//" | crontab -
# crontab -l | sed "/^#.*\/mnt\/d\/etec\/cdmd+1.19\/backup.sh/s/^#//" | crontab -