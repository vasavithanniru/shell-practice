#!/bin/bash

#Source directory
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

#Finds older than 30 days .log files
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +30) 

#Prints older than 30 days .log files
echo "Files:: $FILES"

#IFS=Internal Field Separator, which by default includes spaces, tabs, and newlines. Setting IFS= before read temporarily resets it to an empty value, ensuring lines are not split on whitespace.
while IFS= read -r file 
do 
    echo "Deleting file:: $file"
    rm -rf $file
done <<< $FILES  