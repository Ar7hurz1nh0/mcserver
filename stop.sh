#!/usr/bin/env bash

STATUS=1
while [ $STATUS -ne 0 ]
do
    rconc cdmd stop;
    STATUS=$?;
    sleep .5;
done
sleep 15;