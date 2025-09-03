#!/bin/bash

SOURCE_DIR=/home/ec2-user/logs
R="\e[31m" #Red color
G="\e[32m" #Green color
N="\e[0m"  #Normal


if [ -d $SOURCE_DIR ] #-d will check the directory is exists or not
then
    echo -e "$SOURCE_DIR is $G exists $N"
else
    echo -e "$SOURCE_DIR $R does not exist $N"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +30) #+30 ->older than 30 days .log files will delete
                                                   #-30 ->less than 30 days files will delete
echo "Files:: $FILES"

while IFS= read -r file #IFS=Internal field seperator is white spaces, here it will ignore white spaces. -r is for not to ignore special charecters like /.
do 
    echo "Deleting file:: $file"
    rm -rf $file
done <<< $FILES  