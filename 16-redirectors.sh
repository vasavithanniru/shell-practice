#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER=/var/log/shell-script
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%F-%H:%M:%S)
#/var/log/shell-script/16-redirectors.sh-time
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log" 
mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
    echo "Run this script with root prevellege" | tee -a $LOG_FILE
    exit 1
fi    

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "$2 installation is failed..check it.." | tee -a $LOG_FILE
        exit 1
    else
        echo "$2 installation is success.." | tee -a $LOG_FILE
    fi        
}

for package in $@
do
    dnf list installed $package -y &>> $LOG_FILE

    if [ $? -ne 0 ]
    then
        echo "$package is not installed..going to install it" | tee -a $LOG_FILE
        dnf install $package -y &>> $LOG_FILE
        VALIDATE $? "$package"
    else
        echo "$package is already installed..nothing to do" | tee -a $LOG_FILE
    fi       
done    