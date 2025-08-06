#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if $3 is empty, default is 14
TIMESTAMP=$(date +%F-%H-%M-%S) 

USAGE(){
    echo "USAGE:: sh 20.backup.sh <source> <destination> <days(optional)>"
}

if [ $# -lt 2 ]
then 
    USAGE
    exit 1
fi    

if [ ! -d $SOURCE_DIR ]
then 
    echo "$SOURCE_DIR does not exist..Please check"
fi  

if [ ! -d $DEST_DIR ]
then
    echo "$DEST_DIR does not exist..Please check"
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "Files: $FILES"