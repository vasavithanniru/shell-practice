#!/bin/bash
#set -ex

SOURCE_DIR=$1
DEST_DIR=${2}
DAYS=${3:-14} #If $3 is empty, default is 14 days
TIME_STAMP=$(date +%F-%H-%M-%S)

USAGE(){
    echo "USAGE::sh 19-backup.sh <Source-dir> <Dest-dir> <Days(optional)>"
    exit 1 
}

if [ $# -lt 2 ]
then 
    USAGE
    exit 1
fi    

if [ ! -d $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exist, please check.."
    exit 1
fi    

if [ ! -d $DEST_DIR ]
then 
    echo "$DEST_DIR does not exist, please check.."
    exit 1
fi    

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "Files: $FILES"

if [ ! -z $FILES ] #true if file is empty. ! makes it expression false.
then 
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"
    find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@

    #Check if zip file successfully created or not
    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipping the file older than $DAYS"
        #remove the files after zipping
        while IFS= read -r file
        do 
            echo "Deleting the files: $file"
            rm -rf $file
        done <<< $FILES    
    else
        echo "Zipping the files is FAILED"  
        exit 1
    fi      
else 
    echo "No files found older than $DAYS"     
fi       
        