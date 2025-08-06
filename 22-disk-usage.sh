#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5   #it is usually 75

while IFS= read -r line
do 
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    DIR_PATH=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo "$DIR_PATH utilized more than $DISK_THRESHOLD. Current value is: $USAGE. Please check..."
    fi  
done <<< $DISK_USAGE
