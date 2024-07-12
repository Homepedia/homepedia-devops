#!/bin/sh
URL="http://185.216.26.162"
INTERVAL=0.01

while true; do
    STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $URL)
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Status Code: $STATUS_CODE"

    sleep $INTERVAL
done