#!/bin/bash
#set -ex

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=${2}
DAYS=${3:-14} #If $3 is empty, default is 14 days
TIME_STAMP=$(date +%F-%H-%M-%S)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[34m"

# Log configuration
LOGS_FOLDER=/var/log/shellscript-logs
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

# Check for root access
check_root(){
    if [ $USERID -ne 0 ];
then
    echo -e "$R ERROR:: Please run this script with root access $N" 
    exit 1
else 
    echo -e "$G You are runing with root access $N"  
fi
}

check_root
mkdir -p $LOGS_FOLDER

# usage help
USAGE(){
    echo "USAGE::sh 19-backup.sh <Source-dir> <Dest-dir> <Days(optional)>"
    exit 1 
}

# Input validation
if [ $# -lt 2 ]
then 
    USAGE
    exit 1
fi    

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R $SOURCE_DIR does not exist, please check..$N"
    exit 1
fi    

if [ ! -d $DEST_DIR ]
then 
    echo -e "$R $DEST_DIR does not exist, please check..$N"
    exit 1
fi    

# Find old log files
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo "Files: $FILES"

#true if file is empty. ! makes it expression false.
if [ ! -z "$FILES" ]  
then 
    echo "Files are found to ZIP: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIME_STAMP.zip"

    # Create ZIP file
    find ${SOURCE_DIR} -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@

    #Check if zip file successfully created or not
    if [ -f $ZIP_FILE ]
    then
        echo "Successfully zipping the file older than $DAYS days"
        #remove the files after zipping
        while IFS= read -r file
        do 
            echo "Deleting the files: $file" | tee -a $LOG_FILE
            rm -rf $file
        done <<< $FILES 
            echo -e "Log files older than $DAYS days removed ... $G SUCCESS $N"
    else
        echo -e "$R Zip file creation is FAILED $N"  
        exit 1
    fi      
else 
    echo -e "No log files found older than $DAYS days...$Y SKIPPING $N"     
fi       
        