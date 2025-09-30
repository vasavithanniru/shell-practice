#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if $3 is empty, default is 14
TIMESTAMP=$(date +%F-%H-%M-%S) 
#file_name=$(ls $SOURCE_DIR | cut -d "." -f1)


USAGE(){
    echo "USAGE:: sh $0 <source> <destination> <days(optional)>"
}

failure(){
    echo "Failed at $1:$2"
}

trap 'failure "$LINENO" "$BASH_COMMAND"' ERR


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
cnt=$( echo "$files" | grep -c . )  # count non-empty lines
echo " Count of files older than 14 days: $cnt"
echo "  Files:"  
echo "$FILES" 

#echo "Files: $FILES"

#Check files are available or not
if [ ! -z $FILES ]
then
    echo "Files are found"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip" #Zip the files
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip $ZIP_FILE -@

    if [ -f $ZIP_FILE ]  #check zipping file is succesfull or not
    then
        echo "Successfully zipped the files"

        while IFS= read -r file
        do 
            echo "Deleting Files: $file"
            rm -rf $file
        done <<< $FILES    

    else
        echo "Zipping the files is Failed"
        exit 1    
    fi

else
    echo "Files are not found older than $DAYS" 
fi       