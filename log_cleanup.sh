#!/bin/bash

#Check user id
USERID=$(id -u)

#Color codes
R="\e[31m"   #Red
G="\e[32m"   #Green
Y="\e[33m"   #Yellow
N="\e[0m"    #Reset/Normal

# Log configuration
LOGS_FOLDER=/var/log/shellscript-logs
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%F-%H:%M:%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log"

# Create logs folder if not exist
mkdir -p $LOGS_FOLDER &>> $LOG_FILE

# Directory to clean
SOURCE_DIR="/home/ec2-user/app-logs"  &>>$LOG_FILE

# Start of script execution
echo "Script started executing at: $(date)"  | tee -a $LOG_FILE

# Check for root access
if [ $USERID -ne 0 ];
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1
else 
    echo -e "$G You are runing with root access $N"   | tee -a $LOG_FILE
fi

# Check Source directory is exists or not
if [ -d $SOURCE_DIR ];
then
    echo -e "$SOURCE_DIR $G is exists $N"  | tee -a $LOG_FILE
else
    echo -e "$SOURCE_DIR $R does not exists $N"  |  tee -a $LOG_FILE
fi        

# Files to delete
FILES_TO_DLETE=$(find $SOURCE_DIR -name "*.log" -m time +14) 

# Print older than 14 days files
echo -e "$Y FILES $N= $FILES" | tee -a  $LOG_FILE

#  Delete each file found
while IFS= read -r FILE_PATH
do 
    echo "DELETING FILES:: $FILE_PATH " | tee -a $LOG_FILE
    rm -rf $FILE_PATH

done >>> $FILES_TO_DELETE

echo "Script executed successfuly at $(date)" | tee -a $LOG_FILE
