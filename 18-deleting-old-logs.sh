#!/bin/bash

SOURCE_DIR=/c/Users/DELL/old-logs  #/home/ec2-user/logs
R="\e[31m"
G="\e[32m"
N="\e[0m"


if [ -d $SOURCE_DIR ] #-d will check the dir is exists or not
then
    echo -e "$SOURCE_DIR is $G exists $N"
else
    echo -e "$SOURCE_DIR $R does not exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14) #+14 ->older than 14 days files will delete
                                                   #-14 ->less than 14 days files will delete
echo "Files:: $FILES"

while IFS= read -r file #IFS=Internal field seperator is white spaces, here it will ignore white spaces. -r is for not to ignore special charecters like /.
do 
    echo "Deleting file:: $file"
    rm -rf $file
done <<< $FILES  