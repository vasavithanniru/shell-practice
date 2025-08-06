#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5   #it is usually 75

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

while IFS= read -r line
do 
    USAGE=$(echo $line | grep xfs | awk -F " " '{print $6F}' | cut -d "%" -f1)
    DIR_PATH=$(echo $line | grep xfs | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo -e "$G $DIR_PATH $N  $R utilized more than $DISK_THRESHOLD $N. $Y Current value is: $USAGE $N. Please check..."
    fi  
done <<< $DISK_USAGE
