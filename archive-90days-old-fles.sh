#!/bin/bash

#Check user id
USER_ID=$(id -u)

# Directories to clean
DIR1=$1
DIR2=$2

LOGS_FOLDER=/var/log/old-logs
TIME_STAMP=$(date +F_%H%M%S)
LOG_FILE= "$LOGS_FOLDER/old_files_report_$TIME_STAMP.log"

echo "Report at: $report_file"

echo "Script started executing at: $(date)" |  tee -a $report_file

# Check for root access
if [ $USER_ID -ne 0 ]
then
    echo "[ERROR]: Please run this script with root access"  | tee -a $LOG_FILE
    exit 1
else
    echo "You are running the script with root access"
fi        

#Creates logs folder if not exists
mkdir -p $LOGS_FOLDER

for d in "$DIR1" "$DIR2"; do
    echo "Directory: $d"  >> $LOG_FILE



